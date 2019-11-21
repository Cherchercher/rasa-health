#! /bin/bash
cd /Linguist

python -m rasa_nlu.train \
    -c /Linguist/configs/en/rasa_config.yml \
    --data /Linguist/core/en/training_data.json \
    --fixed_model_name core_en \
    -o models \
    --project linguist \
    --verbose

# uncomment for other agents
# python -m rasa_nlu.train \
#     -c /Linguist/configs/cn/rasa_config.yml \
#     --data /Linguist/core/cn/training_data.json \
#     --fixed_model_name core_cn \
#     -o models \
#     --project linguist \
#     --verbose

# python -m rasa_nlu.train \
#     -c /Linguist/configs/de/rasa_config.yml \
#     --data /Linguist/core/de/training_data.json \
#     --fixed_model_name core_de \
#     -o models \
#     --project linguist \
#     --verbose
