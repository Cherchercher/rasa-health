#! /bin/bash

agent=$1

cd /Linguist

if [ $1 == 'de' ]
    then
        pip install -r requirements_de.txt
        python -m spacy download de_trf_bertbasecased_lg
fi

if [ $1 == 'cn' ]
    then
        pip install -r requirements_cn.txt
fi

python -m rasa_nlu.train \
    -c /Linguist/configs/$agent/rasa_config.yml \
    --data /Linguist/core/$agent/training_data.json \
    --fixed_model_name core_$agent \
    -o models \
    --project linguist \
    --verbose
