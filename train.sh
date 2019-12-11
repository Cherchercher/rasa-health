#!/bin/bash

set -x
set -e
set -o pipefail

agent=$1

cd /Linguist

scripts/$agent/pre-train.sh $agent
scripts/$agent/train.sh $agent
