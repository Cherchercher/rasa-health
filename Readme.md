# rasa-health (multi-language)

This is contains production ready multi-language Rasa NLU .
Currently it supports training in Chinese, English, Japanese and German. We are expanding its capacity to Spanish, and 8 other languages.

### Setup with docker
1. enable Duckling:
docker run -p 8000:8000 rasa/duckling

2. run image:
docker build -t rasa-health .
docker run rasa-health

### Setup without docker
pip install rasa

### English NLP
Train:

Add intents and entities under `core/en/`
Update configs/en/rasa_config.yml if neccessary

Generate training phrases `npx chatito core/en --format=rasa --formatOptions=./core/en/rasaOptions.json --outputPath=core/en --trainingFileName=training_data.json`
Train the model `rasa train nlu --config configs/en/rasa_config.yml --nlu ./core/en/training_data.json`

Add proposed phrases with their corresponding intents and entities under `data/ground_truth_data_en.json`

Cross validate the model at the root of project directory `sh ./tests/en/test.sh`. Model evaluation results are in `results`

Test the model with actual messages at the root of project directory `sh ./tests/en/test-ground_truth.sh`. Wrong intent classifications are listed in `results/intent_errors.json`. Wrong entity classifications are listed in `results/CRFEntityExtractor_errors.json`

Run:
rasa run -v -m models --enable-api --port 5000


### Chinese NLP

### Usage:

Add intents and entities under `core/cn/`

Generate training phrases `npx chatito core/cn --format=rasa --outputPath=core/cn --trainingFileName=training_data.json`

Train the model `rasa train nlu --config configs/cn/rasa_config.yml --nlu ./core/cn/training_data.json`

Add proposed phrases with their corresponding intents and entities under `data/ground_truth_data_cn.json`

Test the model at the root of project directory `sh ./tests/cn/test.sh`. Wrong classifications are listed in `result/intent_errors.json`.

### Germain NLP

### Pretrained Model

https://deepset.ai/german-bert

Install `python -m spacy download de_trf_bertbasecased_lg`

### Usage:

Add intents and entities under `core/de/`

Generate training phrases `npx chatito core/de --format=rasa --outputPath=core/de --trainingFileName=training_data.json`

Train the model `rasa train nlu --config configs/de/rasa_config.yml --nlu ./core/de/training_data.json`

Add proposed phrases with their corresponding intents and entities under `data/ground_truth_data_de.json`

Test the model at the root of project directory `sh ./tests/de/test.sh`. Wrong classifications are listed in `result/intent_errors.json`

### Japanese NLP

### Tokenizer

https://github.com/WorksApplications/SudachiPy

Install `pip install SudachiPy`

### Usage:

Add intents and entities under `core/cn/`

Generate training phrases `npx chatito core/cn --format=rasa --outputPath=core/cn --trainingFileName=training_data.json`

Train the model `rasa train nlu --config configs/cn/rasa_config.yml --nlu ./core/cn/training_data.json`

Add proposed phrases with their corresponding intents and entities under `data/ground_truth_data_cn.json`

Test the model at the root of project directory `sh ./tests/cn/test.sh`. Wrong classifications are listed in `result/intent_errors.json`.

### Enlish NLU Notes

entity
"Category": "TEST_TREATMENT_PROCEDURE",

entity
NEGATION

/\*previously diagnosed, previously admitted
