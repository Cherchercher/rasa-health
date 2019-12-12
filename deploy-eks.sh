#!/bin/bash

set -x
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

# strip agent from end of version string
actual_version=$(echo $version | sed -e "s/-${agent}\$//")

ns=$(aws --region ${region} ssm get-parameter --name /rasa/linguistbot/${env}/${agent}/namespace --query 'Parameter.Value' --output text)
/usr/local/bin/kustomize build overlays/${region}/${env}/${agent} | \
    sed -e "s/{{AGENT}}/${agent}/" -e "s/{{VERSION}}/${actual_version}/" | \
    /usr/local/bin/kubectl --kubeconfig /var/lib/jenkins/.kube/${env}--${region}.config --namespace ${ns} apply -f -
