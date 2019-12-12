#!/bin/bash

set -x
set -e
set -o pipefail

agent=$1

python -m rasa_nlu.train \
    -c /Linguist/configs/$agent/rasa_config.yml \
    --data /Linguist/core/$agent/training_data.json \
    --fixed_model_name core_$agent \
    -o models \
    --project linguist \
    --verbose
