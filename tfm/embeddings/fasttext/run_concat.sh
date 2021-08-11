#!/usr/bin/env bash

for lang in de; do
    for dimension in 200 250 300; do
        cat ././../../../data/datasets/monolingual/monolingual.clean.${lang} >> ././../../../data/datasets/monolingual/monolingual.clean.${lang}-en
        cat ././../../../data/datasets/monolingual/monolingual.clean.en >> ././../../../data/datasets/monolingual/monolingual.clean.${lang}-en
        ./fastText/fasttext skipgram -input ././../../../data/datasets/monolingual/monolingual.clean.${lang}-en -output ././../../../data/embeddings/monolingual-${lang}-en-3-6-${dimension} -minn 3 -maxn 6 -dim ${dimension} -epoch 5 -lr 0.05
        rm ././../../../data/embeddings/monolingual-${lang}-en-3-6-${dimension}.bin
        rm ././../../../data/datasets/monolingual/monolingual.clean.${lang}-en
    done
done

for lang in ru hi; do
    for dimension in 50 100 150 200 250 300; do
        cat ././../../../data/datasets/monolingual/monolingual.clean.${lang} >> ././../../../data/datasets/monolingual/monolingual.clean.${lang}-en
        cat ././../../../data/datasets/monolingual/monolingual.clean.en >> ././../../../data/datasets/monolingual/monolingual.clean.${lang}-en
        ./fastText/fasttext skipgram -input ././../../../data/datasets/monolingual/monolingual.clean.${lang}-en -output ././../../../data/embeddings/monolingual-${lang}-en-3-6-${dimension} -minn 3 -maxn 6 -dim ${dimension} -epoch 5 -lr 0.05
        rm ././../../../data/embeddings/monolingual-${lang}-en-3-6-${dimension}.bin
        rm ././../../../data/datasets/monolingual/monolingual.clean.${lang}-en
    done
done