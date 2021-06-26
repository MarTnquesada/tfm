#!/usr/bin/env bash

file=$1
lang1=$2
lang2=$3

# Check out http://www.statmt.org/wmt07/baseline.html
docker container run -it --rm -v ${PWD}/data/:/data moses /bin/bash -c "scripts/tokenizer/tokenizer.perl ${lang1} < ${file}.${lang1} > ${file}.tok.${lang1}"
docker container run -it --rm -v ${PWD}/data/:/data moses /bin/bash -c "scripts/tokenizer/tokenizer.perl ${lang2} < ${file}.${lang2} > ${file}.tok.${lang2}"

docker container run -it --rm -v ${PWD}/data/:/data moses scripts/training/clean-corpus-n.perl ${file}.tok ${lang1} ${lang2} ${file}.clean 1 40