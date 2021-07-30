#!/usr/bin/env bash

for lang in fr de ru hi; do
    dimension=100
    python -m ../../../../tfm.crossmapping.vecmap.map_embeddings data/embeddings/monolingual-${lang}-3-6-${dimension}.vec data/embeddings/monolingual-en-3-6-${dimension}.vec data/embeddings/monolingual-${lang}-3-6-${dimension}-en.vec data/embeddings/monolingual-en-3-6-${dimension}-${lang}.vec --cuda --batch_size 1000 --unsupervised --verbose
    dimension=300
    python -m ../../../../tfm.crossmapping.vecmap.map_embeddings data/embeddings/monolingual-${lang}-3-6-${dimension}.vec data/embeddings/monolingual-en-3-6-${dimension}.vec data/embeddings/monolingual-${lang}-3-6-${dimension}-en.vec data/embeddings/monolingual-en-3-6-${dimension}-${lang}.vec --cuda --batch_size 50 --unsupervised --verbose
done