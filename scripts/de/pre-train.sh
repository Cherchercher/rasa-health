#!/bin/bash

set -x
set -e
set -o pipefail

pip install -r requirements_de.txt
python -m spacy download de_trf_bertbasecased_lg
