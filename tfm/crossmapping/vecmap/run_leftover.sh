#!/usr/bin/env bash


lang=de
dimension=100
python -m tfm.crossmapping.vecmap.map_embeddings data/embeddings/monolingual-${lang}-3-6-${dimension}.vec data/embeddings/monolingual-en-3-6-${dimension}.vec data/embeddings/monolingual-${lang}-3-6-${dimension}-vecmap-en.vec data/embeddings/monolingual-en-3-6-${dimension}-vecmap-${lang}.vec --batch_size 1000 --unsupervised --verbose

for lang in ru hi; do
    for dimension in 50 100; do
        python -m tfm.crossmapping.vecmap.map_embeddings data/embeddings/monolingual-${lang}-3-6-${dimension}.vec data/embeddings/monolingual-en-3-6-${dimension}.vec data/embeddings/monolingual-${lang}-3-6-${dimension}-vecmap-en.vec data/embeddings/monolingual-en-3-6-${dimension}-vecmap-${lang}.vec --batch_size 1000 --unsupervised --verbose
    done
done

for lang in fr de ru hi; do
    for dimension in 400 500; do
        python -m tfm.crossmapping.vecmap.map_embeddings data/embeddings/monolingual-${lang}-3-6-${dimension}.vec data/embeddings/monolingual-en-3-6-${dimension}.vec data/embeddings/monolingual-${lang}-3-6-${dimension}-vecmap-en.vec data/embeddings/monolingual-en-3-6-${dimension}-vecmap-${lang}.vec --batch_size 1000 --unsupervised --verbose
    done
done