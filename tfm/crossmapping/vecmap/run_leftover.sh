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

echo
echo ------------ VECMAP ------------
echo ------- \(BASE TOKENIZATION\) -------
echo ---\[COSINE SIMILARITY\]---
echo LANG   ---   DIMENSION
lang=de
dimension=100
echo ${lang}   ---   ${dimension}
python3 -m tfm.evaluation.evaluate_embedding_word_translation \
    data/embeddings/monolingual-${lang}-3-6-${dimension}-vecmap-en.vec \
    data/embeddings/monolingual-en-3-6-${dimension}-vecmap-${lang}.vec \
    -d data/datasets/eval_dicts/${lang}-en.txt \
    --retrieval csls --cuda
for lang in ru hi; do
    for dimension in 50 100; do
        echo ${lang}   ---   ${dimension}
        python3 -m tfm.evaluation.evaluate_embedding_word_translation \
            data/embeddings/monolingual-${lang}-3-6-${dimension}-vecmap-en.vec \
            data/embeddings/monolingual-en-3-6-${dimension}-vecmap-${lang}.vec \
            -d data/datasets/eval_dicts/${lang}-en.txt \
            --retrieval csls --cuda
    done
done
for lang in fr de ru hi; do
    for dimension in 400 500; do
        echo ${lang}   ---   ${dimension}
        python3 -m tfm.evaluation.evaluate_embedding_word_translation \
        data/embeddings/monolingual-${lang}-3-6-${dimension}-vecmap-en.vec \
        data/embeddings/monolingual-en-3-6-${dimension}-vecmap-${lang}.vec \
        -d data/datasets/eval_dicts/${lang}-en.txt \
        --retrieval csls --cuda
    done
done

echo ---\[L2 DISTANCE\]---
echo LANG   ---   DIMENSION
lang=de
dimension=100
echo ${lang}   ---   ${dimension}
python3 -m tfm.evaluation.evaluate_embedding_word_translation \
    data/embeddings/monolingual-${lang}-3-6-${dimension}-vecmap-en.vec \
    data/embeddings/monolingual-en-3-6-${dimension}-vecmap-${lang}.vec \
    -d data/datasets/eval_dicts/${lang}-en.txt \
    --retrieval csls --dot --cuda
for lang in ru hi; do
    for dimension in 50 100; do
        echo ${lang}   ---   ${dimension}
        python3 -m tfm.evaluation.evaluate_embedding_word_translation \
            data/embeddings/monolingual-${lang}-3-6-${dimension}-vecmap-en.vec \
            data/embeddings/monolingual-en-3-6-${dimension}-vecmap-${lang}.vec \
            -d data/datasets/eval_dicts/${lang}-en.txt \
            --retrieval csls --dot --cuda
    done
done
for lang in fr de ru hi; do
    for dimension in 400 500; do
        echo ${lang}   ---   ${dimension}
        python3 -m tfm.evaluation.evaluate_embedding_word_translation \
        data/embeddings/monolingual-${lang}-3-6-${dimension}-vecmap-en.vec \
        data/embeddings/monolingual-en-3-6-${dimension}-vecmap-${lang}.vec \
        -d data/datasets/eval_dicts/${lang}-en.txt \
        --retrieval csls --dot --cuda
    done
done