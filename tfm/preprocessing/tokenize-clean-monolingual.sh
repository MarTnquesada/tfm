#!/usr/bin/env bash

file=$1
lang=$2

# Check out http://www.statmt.org/wmt07/baseline.html
docker container run -it --rm -v ${PWD}/data/:/data moses /bin/bash -c "scripts/tokenizer/tokenizer.perl -l ${lang} < ${file}.${lang} > ${file}.tok.${lang}"
docker container run -it --rm -v ${PWD}/data/:/data moses scripts/training/clean-corpus-n.perl ${file}.tok ${lang} ${lang} ${file}.clean 1 60