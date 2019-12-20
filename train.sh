#!/bin/bash

set -x
set -e
set -o pipefail

agent=$1

cd /Linguist

rasa train nlu \
    --config ./configs/$agent/rasa_config.yml \
    --nlu ./core/$agent/training_data.json \
    --fixed-model-name core_$agent \
    --out models \
    --verbose
