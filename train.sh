#!/bin/bash

set -x
set -e
set -o pipefail

agent=$1

cd /Linguist
 
python -m rasa train nlu \
    --config ./configs/$agent/rasa_config.yml \
    --data ./core/$agent/training_data.json \
    --fixed-model-name core_$agent \
    --out models \
    --verbose
