#!/usr/bin/env bash

for lang in en fr de ru hi; do
    for dimension in 512; do
        ./fastText/fasttext skipgram -input ././../../../data/datasets/monolingual/monolingual.clean.${lang} -output ././../../../data/embeddings/monolingual-${lang}-3-6-${dimension} -minn 3 -maxn 6 -dim ${dimension} -epoch 5 -lr 0.05
        rm  ././../../../data/embeddings/monolingual-${lang}-3-6-${dimension}.bin
    done
done