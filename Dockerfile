FROM 261695625069.dkr.ecr.us-east-1.amazonaws.com/rasa-pipeline:latest

RUN apt-get update && apt-get install -y jq

ADD models /rasa_nlu/models/
ADD readiness-probe.sh /
WORKDIR /rasa_nlu
EXPOSE 5000

CMD ["python", "-m", "rasa_nlu.server", "-v", "--path", "/rasa_nlu/models"]
