#!/bin/bash

set -x
set -e
set -o pipefail

agent=$1

cd /Linguist

python -m rasa train nlu \
    --config /Linguist/configs/$agent/rasa_config.yml \
    --data /Linguist/core/$agent/training_data.json \
    --fixed-model-name linguist/core_$agent \
    --out models \
    --verbose
