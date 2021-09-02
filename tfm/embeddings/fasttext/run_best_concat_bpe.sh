#!/usr/bin/env bash

for lang in fr de ru hi; do
    for dimension in 50 100 150 200 250 300; do
        cat ././../../../data/datasets/monolingual/monolingual.clean.${lang}.bpe_48000.${lang}-en >> ././../../../data/datasets/monolingual/monolingual.clean.bpe_48000.${lang}-en
        cat ././../../../data/datasets/monolingual/monolingual.clean.en.bpe_48000.${lang}-en >> ././../../../data/datasets/monolingual/monolingual.clean.bpe_48000.${lang}-en
        ./fastText/fasttext skipgram -input ././../../../data/datasets/monolingual/monolingual.clean.bpe_48000.${lang}-en -output ././../../../data/embeddings/monolingual-${lang}-en-3-6-${dimension}.bpe_48000 -minn 3 -maxn 6 -dim ${dimension} -epoch 5 -lr 0.05
        rm ././../../../data/embeddings/monolingual-${lang}-en-3-6-${dimension}.bpe_48000.bin
        rm ././../../../data/datasets/monolingual/monolingual.clean.bpe_48000.${lang}-en
    done
done