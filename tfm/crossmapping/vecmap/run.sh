#!/usr/bin/env bash

for lang in fr de ru hi; do
    # Dimensions compatible with CUDA
    dimension=50
    python -m tfm.crossmapping.vecmap.map_embeddings data/embeddings/monolingual-${lang}-3-6-${dimension}.vec data/embeddings/monolingual-en-3-6-${dimension}.vec data/embeddings/monolingual-${lang}-3-6-${dimension}-vecmap-en.vec data/embeddings/monolingual-en-3-6-${dimension}-vecmap-${lang}.vec --batch_size 1000 --unsupervised --verbose
    dimension=100
    python -m tfm.crossmapping.vecmap.map_embeddings data/embeddings/monolingual-${lang}-3-6-${dimension}.vec data/embeddings/monolingual-en-3-6-${dimension}.vec data/embeddings/monolingual-${lang}-3-6-${dimension}-vecmap-en.vec data/embeddings/monolingual-en-3-6-${dimension}-vecmap-${lang}.vec --batch_size 1000 --unsupervised --verbose

    # Dimensions that generate a CUDA memory error and therefore need to be cross-mapped using CPU
    dimension=150
    python -m tfm.crossmapping.vecmap.map_embeddings data/embeddings/monolingual-${lang}-3-6-${dimension}.vec data/embeddings/monolingual-en-3-6-${dimension}.vec data/embeddings/monolingual-${lang}-3-6-${dimension}-vecmap-en.vec data/embeddings/monolingual-en-3-6-${dimension}-vecmap-${lang}.vec --batch_size 1000 --unsupervised --verbose
    dimension=200
    python -m tfm.crossmapping.vecmap.map_embeddings data/embeddings/monolingual-${lang}-3-6-${dimension}.vec data/embeddings/monolingual-en-3-6-${dimension}.vec data/embeddings/monolingual-${lang}-3-6-${dimension}-vecmap-en.vec data/embeddings/monolingual-en-3-6-${dimension}-vecmap-${lang}.vec --batch_size 1000 --unsupervised --verbose
    dimension=250
    python -m tfm.crossmapping.vecmap.map_embeddings data/embeddings/monolingual-${lang}-3-6-${dimension}.vec data/embeddings/monolingual-en-3-6-${dimension}.vec data/embeddings/monolingual-${lang}-3-6-${dimension}-vecmap-en.vec data/embeddings/monolingual-en-3-6-${dimension}-vecmap-${lang}.vec --batch_size 1000 --unsupervised --verbose
    dimension=300
    python -m tfm.crossmapping.vecmap.map_embeddings data/embeddings/monolingual-${lang}-3-6-${dimension}.vec data/embeddings/monolingual-en-3-6-${dimension}.vec data/embeddings/monolingual-${lang}-3-6-${dimension}-vecmap-en.vec data/embeddings/monolingual-en-3-6-${dimension}-vecmap-${lang}.vec --batch_size 1000 --unsupervised --verbose
done