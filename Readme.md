# Linguist
This is the repo for the training data for the multilingual bot.
Currently it supports training in Chinese, English and German. We are expanding its capacity to Spanish, and 8 other languages.

### Setup
`python setup.py install`

### Chinese NLP
### Pretrained Model
file you need to have: https://drive.google.com/file/d/1G4BLpB_OQcCwEm4bVbpXjzlHnuBDlICG/view?usp=sharing

put this under data/cn/ (e.g. data/cn/total_word_feature_extractor_zh.dat)

We used a petrained model generated from Chinese Wikipedia Dump and Baidu corpus by MITIE wordrep tools (takes 2-3 days for training)

To train a custom model, please build the [MITIE Wordrep Tool](https://github.com/mit-nlp/MITIE/tree/master/tools/wordrep). Note that Chinese corpus should be tokenized first before feeding into the tool for training. Close-domain corpus that best matches user case works best.

(Optional) Use Jieba User Defined Dictionary or Switch Jieba Default Dictionoary:

You can put in **file path** or **directory path** as the "user_dicts" value. (sample_configs/config_jieba_mitie_sklearn_plus_dict_path.yml)


### Usage:

Generate training phrases `npx chatito core/cn --format=rasa --outputPath=core/cn --trainingFileName=training_data.json`

Train the model `rasa train nlu --config configs/cn/rasa_config.yml --nlu ./core/cn/training_data.json`

Test the model `sh ./tests/cn/test.sh`


### Germain NLP
### Pretrained Model
https://deepset.ai/german-bert

Install `python -m spacy download de_trf_bertbasecased_lg`

### Usage:

Generate training phrases `npx chatito core/de --format=rasa --outputPath=core/de --trainingFileName=training_data.json`

Train the model `rasa train nlu --config configs/de/rasa_config.yml --nlu ./core/de/training_data.json`

Test the model `sh ./tests/de/test.sh`




### English NLP

Generate training phrases `npx chatito core/en --format=rasa --outputPath=core/en --trainingFileName=training_data.json`

Train the model `rasa train nlu --config configs/en/rasa_config.yml --nlu ./core/en/training_data.json`

Test the model `sh ./tests/en/test.sh`


