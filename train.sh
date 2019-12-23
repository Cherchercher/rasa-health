#!/bin/bash

set -x
set -e
set -o pipefail

agent=$1

cd /Linguist

if [ agent = 'cn' ]
then
    rasa train nlu \
    --config ./configs/$agent/rasa_config.yml \
    --nlu ./core/$agent/training_data.json \
    --fixed-model-name core_$agent \
    --out ./tmp/tmpoyzgq_93/nlu/addons_intent_classifier_textcnn_tf \
    --verbose
else
    rasa train nlu \
        --config ./configs/$agent/rasa_config.yml \
        --nlu ./core/$agent/training_data.json \
        --fixed-model-name core_$agent \
        --out models \
        --verbose
fi
