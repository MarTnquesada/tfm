#!/usr/bin/env bash

for lang in fr de ru hi; do
    for dimension in 512; do
        ./fastText/fasttext skipgram -input ././../../../data/datasets/monolingual/monolingual.clean.${lang}.bpe_48000.${lang}-en -output ././../../../data/embeddings/monolingual-${lang}-3-6-${dimension}.bpe_48000.${lang}-en -minn 3 -maxn 6 -dim ${dimension} -epoch 5 -lr 0.05
        ./fastText/fasttext skipgram -input ././../../../data/datasets/monolingual/monolingual.clean.en.bpe_48000.${lang}-en -output ././../../../data/embeddings/monolingual-en-3-6-${dimension}.bpe_48000.${lang}-en -minn 3 -maxn 6 -dim ${dimension} -epoch 5 -lr 0.05
        rm  ././../../../data/embeddings/monolingual-${lang}-3-6-${dimension}.bpe_48000.${lang}-en.bin
        rm  ././../../../data/embeddings/monolingual-en-3-6-${dimension}.bpe_48000.${lang}-en.bin
    done
done