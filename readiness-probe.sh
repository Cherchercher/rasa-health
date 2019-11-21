#!/bin/bash

STATUS_JSON=$(curl -s --max-time 5 "http://localhost:5000/status")
CHECK_CORE_EN=$(echo $STATUS_JSON | jq '.available_projects."linguist".loaded_models | index("core_en")')
# uncomment for other agents
# CHECK_CORE_DE=$(echo $STATUS_JSON | jq '.available_projects."linguist".loaded_models | index("core_de")')
# CHECK_CORE_CN=$(echo $STATUS_JSON | jq '.available_projects."linguist".loaded_models | index("core_cn")')

check_query() {
    QUERY_JSON=$(curl -s --max-time 5 $1)
    CHECK_QUERY=$(echo $QUERY_JSON | jq -r '.id')
    if [ -z "$CHECK_QUERY" ]; then
        exit 1
    fi
}

if [ -z "$CHECK_CORE_EN" -o "$CHECK_CORE_EN" = "null" ]; then
    check_query "http://localhost:5000/parse?project=linguist&model=core_en&query=is the car available now"
fi
# uncomment for other agents
# if [ -z "$CHECK_CORE_CN" -o "$CHECK_CORE_CN" = "null" ]; then
#     check_query "http://localhost:5000/parse?project=linguist&model=core_cn&query=车"
# fi

# if [ -z "$CHECK_CORE_DE" -o "$CHECK_CORE_DE" = "null" ]; then
#     check_query "http://localhost:5000/parse?project=linguist&model=core_de&query=wie viel kostet"
# fi

