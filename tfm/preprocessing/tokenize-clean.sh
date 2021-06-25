#!/usr/bin/env bash

file=$1
lang1=$2
lang2=$3

# Check out http://www.statmt.org/wmt07/baseline.html
docker container run -it --rm -v ${PWD}/data/:/data moses scripts/tokenizer/tokenizer.perl $lang1 < /data/datasets/$file.$lang1 > /data/datasets/$file.tok.$lang1
docker container run -it --rm -v ${PWD}/data/:/data moses scripts/tokenizer/tokenizer.perl $lang2 < /data/datasets/$file.$lang2 > /data/datasets/$file.tok.$lang2

docker container run -it --rm -v ${PWD}/data/:/data moses scripts/training/clean-corpus-n.perl /data/datasets/$file.tok $lang1 $lang2 /data/datasets/$file.clean 1 40