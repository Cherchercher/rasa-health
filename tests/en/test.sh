[ -d results ]&& rm -rf results; rasa test nlu -u ./data/ground_truth_data.json  --model models; [[ -s ./results/intent_errors.json ]] && echo 'Error: not all phrases got matched with right intents'|| echo 'success'