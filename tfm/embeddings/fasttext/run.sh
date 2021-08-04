#!/usr/bin/env bash

for lang in en fr de ru hi; do
    for dimension in 50 100 150 200 250 300; do
        ./fastText/fasttext skipgram -input ././../../../data/datasets/monolingual/monolingual.clean.${lang} -output ././../../../data/embeddings/monolingual-${lang}-3-6-${dimension} -minn 3 -maxn 6 -dim ${dimension} -epoch 5 -lr 0.05
        rm  ././../../../data/embeddings/monolingual-${lang}-3-6-${dimension}.bin
    done
done