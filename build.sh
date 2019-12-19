#!/bin/bash

set -x
set -e
set -o pipefail

agent=$1

readonly BRANCH="master"
readonly VERSION_FILE="VERSION_$agent"

get_updated_version() {
    major=$(cut -d '.' -f 1 ${VERSION_FILE})
    minor=$(cut -d '.' -f 2 ${VERSION_FILE} | xargs -I '{}' expr '{}' + 1)
    echo "${major}.${minor}.0"
}

build() {
    version=$1

    $(aws ecr get-login --no-include-email --region us-east-1)

    # Run chatito
    docker pull 261695625069.dkr.ecr.us-east-1.amazonaws.com/rasa-pipeline-chatito:latest

    docker run --rm -v $(pwd)/core/${agent}:/core/${agent} \
        261695625069.dkr.ecr.us-east-1.amazonaws.com/rasa-pipeline-chatito:latest \
        npx chatito core/${agent} \
        --format=rasa \
        --formatOptions=./core/${agent}/rasaOptions.json \
        --outputPath=core/${agent} \
        --trainingFileName=training_data.json

    # Preprocess and Train the data
    docker pull 261695625069.dkr.ecr.us-east-1.amazonaws.com/linguist-pipeline:latest
    # Disable nvidia for now since we dont have to much examples now
    docker run --rm -v $(pwd):/Linguist 261695625069.dkr.ecr.us-east-1.amazonaws.com/linguist-pipeline:latest /Linguist/train.sh ${agent}

    # Build the image we're going to deploy to k8s
    docker build \
        -t linguist-rasa-${agent}:${version} \
        -t 261695625069.dkr.ecr.us-east-1.amazonaws.com/linguist-rasa-${agent}:latest \
        -t 261695625069.dkr.ecr.us-east-1.amazonaws.com/linguist-rasa-${agent}:${version} \
        .
}

commit_and_tag() {
    echo "$1" > ${VERSION_FILE}
    git add ${VERSION_FILE}
    git commit -m "${1} for ${agent}"
    git tag "${1}-${agent}"
    if [ "$?" -ne 0 ]; then
        echo "Failed to commit or tag new version: $1"
        exit 1
    fi
}

push_tag() {
    git push --tags origin $BRANCH
    if [ "$?" -ne 0 ]; then
        echo "Failed to push new version commit to ${BRANCH}"
        exit 1
    fi
}

push_ecr_image() {
    # Push the version to ECR
    docker push 261695625069.dkr.ecr.us-east-1.amazonaws.com/linguist-rasa-${agent}
}

main() {
    git checkout $BRANCH
    version=$(get_updated_version)
    build $version
    commit_and_tag $version
    push_tag
    push_ecr_image
    exit 0
}

main
