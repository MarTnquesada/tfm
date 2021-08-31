#!/usr/bin/env bash

for lang in fr de ru hi; do
    for dimension in 512; do
        python -m tfm.crossmapping.vecmap.map_embeddings data/embeddings/monolingual-${lang}-3-6-${dimension}.vec data/embeddings/monolingual-en-3-6-${dimension}.vec data/embeddings/monolingual-${lang}-3-6-${dimension}-vecmap-en.vec data/embeddings/monolingual-en-3-6-${dimension}-vecmap-${lang}.vec --batch_size 1000 --unsupervised --verbose
    done
done

# BPE mappings
for lang in fr de ru hi; do
    for dimension in 512; do
        python -m tfm.crossmapping.vecmap.map_embeddings data/embeddings/monolingual-${lang}-3-6-${dimension}.bpe_48000.${lang}-en.vec data/embeddings/monolingual-en-3-6-${dimension}.bpe_48000.${lang}-en.vec data/embeddings/monolingual-${lang}-3-6-${dimension}.bpe_48000.${lang}-en.vecmap-en.vec data/embeddings/monolingual-en-3-6-${dimension}.bpe_48000.${lang}-en.vecmap-${lang}.vec --batch_size 1000 --unsupervised --verbose
    done
done
