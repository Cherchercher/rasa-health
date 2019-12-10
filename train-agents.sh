$(aws ecr get-login --no-include-email --region us-east-1)
set -e
set -o pipefail

agent=$1

# Run chatito
docker pull 261695625069.dkr.ecr.us-east-1.amazonaws.com/rasa-pipeline-chatito:latest
docker run --rm -v $(pwd)/core/$agent:/core/$agent \
  261695625069.dkr.ecr.us-east-1.amazonaws.com/rasa-pipeline-chatito:latest \
  npx chatito core/$agent \
  --format=rasa \
  --formatOptions=./core/$agent/rasaOptions.json \
  --outputPath=core/$agent \
  --trainingFileName=training_data.json

# Preprocess and Train the data
docker pull 261695625069.dkr.ecr.us-east-1.amazonaws.com/rasa-pipeline:latest
# Disable nvidia for now since we dont have to much examples now
docker run --rm -v $(pwd):/Linguist 261695625069.dkr.ecr.us-east-1.amazonaws.com/rasa-pipeline:latest /Linguist/train.sh $agent

# Get the current version
export version=$(cat VERSION)

# Build the image we're going to deploy to k8s
docker build -t linguist-rasa-$agent:$version .

# Tag the image
docker tag linguist-rasa-$agent:$version 261695625069.dkr.ecr.us-east-1.amazonaws.com/linguist-rasa-$agent:$version

# Push the version to ECR
docker push 261695625069.dkr.ecr.us-east-1.amazonaws.com/linguist-rasa-$agent:$version