#!/bin/bash

set -x
set -e
set -o pipefail

agent=$1

cd /Linguist

python -m rasa train \
    --verbose
    --config /Linguist/configs/$agent/rasa_config.yml \
    --data /Linguist/core/$agent/training_data.json \
    --fixed_model_name core_$agent \
    --out models \
    --project linguist \
    nlu
