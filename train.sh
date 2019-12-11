#! /bin/bash

agent=$1

cd /Linguist

RUN pip install -r requirements.txt
RUN python -m spacy download de_trf_bertbasecased_lg

python -m rasa_nlu.train \
    -c /Linguist/configs/$agent/rasa_config.yml \
    --data /Linguist/core/$agent/training_data.json \
    --fixed_model_name core_$agent \
    -o models \
    --project linguist \
    --verbose
