#!/usr/bin/env bash


for lang in fr de ru hi; do
    for dimension in 400 500 1000; do
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
    --retrieval csls
for lang in ru hi; do
    for dimension in 50 100; do
        echo ${lang}   ---   ${dimension}
        python3 -m tfm.evaluation.evaluate_embedding_word_translation \
            data/embeddings/monolingual-${lang}-3-6-${dimension}-vecmap-en.vec \
            data/embeddings/monolingual-en-3-6-${dimension}-vecmap-${lang}.vec \
            -d data/datasets/eval_dicts/${lang}-en.txt \
            --retrieval csls
    done
done
for lang in fr de ru hi; do
    for dimension in 400 500; do
        echo ${lang}   ---   ${dimension}
        python3 -m tfm.evaluation.evaluate_embedding_word_translation \
        data/embeddings/monolingual-${lang}-3-6-${dimension}-vecmap-en.vec \
        data/embeddings/monolingual-en-3-6-${dimension}-vecmap-${lang}.vec \
        -d data/datasets/eval_dicts/${lang}-en.txt \
        --retrieval csls
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
    --retrieval csls --dot
for lang in ru hi; do
    for dimension in 50 100; do
        echo ${lang}   ---   ${dimension}
        python3 -m tfm.evaluation.evaluate_embedding_word_translation \
            data/embeddings/monolingual-${lang}-3-6-${dimension}-vecmap-en.vec \
            data/embeddings/monolingual-en-3-6-${dimension}-vecmap-${lang}.vec \
            -d data/datasets/eval_dicts/${lang}-en.txt \
            --retrieval csls --dot
    done
done
for lang in fr de ru hi; do
    for dimension in 400 500; do
        echo ${lang}   ---   ${dimension}
        python3 -m tfm.evaluation.evaluate_embedding_word_translation \
        data/embeddings/monolingual-${lang}-3-6-${dimension}-vecmap-en.vec \
        data/embeddings/monolingual-en-3-6-${dimension}-vecmap-${lang}.vec \
        -d data/datasets/eval_dicts/${lang}-en.txt \
        --retrieval csls --dot
    done
done