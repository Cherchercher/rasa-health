FROM rasa/rasa:1.10.8-full

ADD models /rasa_nlu/models/
ADD readiness-probe.sh /
WORKDIR /rasa_nlu
EXPOSE 5000

CMD ["run", "-v", "-m", "models", "--enable-api", "--port", "5000"]
