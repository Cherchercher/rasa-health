#!/usr/bin/env bash

set -e
set -o pipefail

agent=$1
env=$2
version=$3
region=${4:-us-east-1}

if [ -z "$agent" ] || [ -z "$env" ] || [ -z "$version" ]; then
    echo "Usage: $0 <agent> <env> <version> [<region>]"
    echo "          <region> defaults to 'us-east-1' if not specified."
    exit 1
fi

cd kubernetes

pushd base
/usr/local/bin/kustomize edit set imagetag 261695625069.dkr.ecr.us-east-1.amazonaws.com/linguist-rasa-$agent:$version
popd

ns=$(aws --region $region ssm get-parameter --name /rasa/linguistbot/$env/namespace --query 'Parameter.Value' --output text)
/usr/local/bin/kustomize build overlays/$region/$env | /usr/local/bin/kubectl --kubeconfig /var/lib/jenkins/.kube/${env}--${region}.config --namespace $ns apply -f -
