$(aws ecr get-login --no-include-email --region us-east-1)

# Run chatito
docker pull 261695625069.dkr.ecr.us-east-1.amazonaws.com/rasa-pipeline-chatito:latest
docker run --rm -v $(pwd)/core/en:/core/en 261695625069.dkr.ecr.us-east-1.amazonaws.com/rasa-pipeline-chatito:latest npx chatito core/en --format=rasa --outputPath=core/en --trainingFileName=training_data.json
# uncomment for other agents
#docker run --rm -v $(pwd)/core/en:/core/de 261695625069.dkr.ecr.us-east-1.amazonaws.com/rasa-pipeline-chatito:latest npx chatito core/de --format=rasa --outputPath=core/de --trainingFileName=training_data.json
#docker run --rm -v $(pwd)/core/en:/core/cn 261695625069.dkr.ecr.us-east-1.amazonaws.com/rasa-pipeline-chatito:latest npx chatito core/cn --format=rasa --outputPath=core/cn --trainingFileName=training_data.json

# Preprocess and Train the data
docker pull 261695625069.dkr.ecr.us-east-1.amazonaws.com/rasa-pipeline:latest
docker run --runtime=nvidia --rm -v $(pwd):/Linguist 261695625069.dkr.ecr.us-east-1.amazonaws.com/rasa-pipeline:latest /Linguist/train.sh

# Get the current version
export version=$(cat VERSION)

# Build the image we're going to deploy to k8s
docker build -t linguist-rasa:$version .

# Tag the image
docker tag linguist-rasa:$version 261695625069.dkr.ecr.us-east-1.amazonaws.com/linguist-rasa:$version

# Push the version to ECR
docker push 261695625069.dkr.ecr.us-east-1.amazonaws.com/linguist-rasa:$version