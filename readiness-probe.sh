#!/bin/bash

# STATUS_JSON=$(curl -s --max-time 5 "http://localhost:5000/status")
# CHECK_CORE_EN=$(echo $STATUS_JSON | jq '.available_projects."linguist".loaded_models | index("core_en")')
# uncomment for other agents
# CHECK_CORE_DE=$(echo $STATUS_JSON | jq '.available_projects."linguist".loaded_models | index("core_de")')
# CHECK_CORE_CN=$(echo $STATUS_JSON | jq '.available_projects."linguist".loaded_models | index("core_cn")')

check_query() {
    QUERY_JSON=$(curl -s --max-time 5 "http://localhost:5000/model/parse" -X POST -d $1)
    CHECK_QUERY=$(echo $QUERY_JSON | jq -r '.id')
    if [ -z "$CHECK_QUERY" ]; then
        exit 1
    fi
}

# if [ -z "$CHECK_CORE_EN" -o "$CHECK_CORE_EN" = "null" ]; then
    # check_query "{\"text\":\"is the car available now\"}"
# fi

# if [ -z "$CHECK_CORE_CN" -o "$CHECK_CORE_CN" = "null" ]; then
    # check_query "{\"text\":\"车\"}"
# fi

# if [ -z "$CHECK_CORE_DE" -o "$CHECK_CORE_DE" = "null" ]; then
    # check_query "{\"text\":\"wie viel kostet\"}"
# fi

# default for now
check_query "{\"text\":\"hello\"}"