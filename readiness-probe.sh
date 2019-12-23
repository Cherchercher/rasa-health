#!/bin/bash

STATUS_JSON=$(curl -s --max-time 5 "http://localhost:5000/status")
CHECK_CORE_EN=$(echo $STATUS_JSON | jq '.model_file | index("core_en")')
CHECK_CORE_DE=$(echo $STATUS_JSON | jq '.model_file | index("core_de")')
CHECK_CORE_CN=$(echo $STATUS_JSON | jq '.model_file | index("core_cn")')

check_query() {
    QUERY_JSON=$(curl -s --max-time 5 "http://localhost:5000/model/parse?emulation_mode=DIALOGFLOW" -X POST -d "{\"text\":\"$1\"}")
    echo $QUERY_JSON
    CHECK_QUERY=$(echo $QUERY_JSON | jq -r '.id')

    if [ "$CHECK_QUERY" == "null" ]; then
        exit 1
    fi
}

if [ "$CHECK_CORE_EN" != "null" ]; then
    check_query "is the car available now"
fi

if [ "$CHECK_CORE_CN" != "null" ]; then
    check_query "车"
fi

if [ "$CHECK_CORE_DE" != "null" ]; then
    check_query "wie viel kostet"
fi
