#!/usr/bin/env bash

echo
echo ------------ VECMAP ------------
echo ------- \(BASE TOKENIZATION\) -------
echo ---\[COSINE SIMILARITY\]---
echo LANG   ---   DIMENSION
for lang in fr de ru hi; do
    for dimension in 50 100 150 200 250 300; do
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
for lang in fr de ru hi; do
    for dimension in 50 100 150 200 250 300; do
        echo ${lang}   ---   ${dimension}
        python3 -m tfm.evaluation.evaluate_embedding_word_translation \
        data/embeddings/monolingual-${lang}-3-6-${dimension}-vecmap-en.vec \
        data/embeddings/monolingual-en-3-6-${dimension}-vecmap-${lang}.vec \
        -d data/datasets/eval_dicts/${lang}-en.txt \
        --retrieval csls --cuda
    done
done


echo
echo ------------ MUSE ------------
echo ------- \(BASE TOKENIZATION\) -------
echo ---\[COSINE SIMILARITY\]---
echo LANG   ---   DIMENSION
for lang in fr de ru hi; do
    for dimension in 50 100 150 200 250 300; do
        echo ${lang}   ---   ${dimension}
        python3 -m tfm.evaluation.evaluate_embedding_word_translation \
        data/embeddings/monolingual-${lang}-3-6-${dimension}-muse-en.vec \
        data/embeddings/monolingual-en-3-6-${dimension}-muse-${lang}.vec \
        -d data/datasets/eval_dicts/${lang}-en.txt \
        --retrieval csls --cuda
    done
done
echo ---\[L2 DISTANCE\]---
echo LANG   ---   DIMENSION
for lang in fr de ru hi; do
    for dimension in 50 100 150 200 250 300; do
        echo ${lang}   ---   ${dimension}
        python3 -m tfm.evaluation.evaluate_embedding_word_translation \
        data/embeddings/monolingual-${lang}-3-6-${dimension}-muse-en.vec \
        data/embeddings/monolingual-en-3-6-${dimension}-muse-${lang}.vec \
        -d data/datasets/eval_dicts/${lang}-en.txt \
        --retrieval csls --cuda
    done
done


echo
echo ------------ CONCAT------------
echo ------- \(BASE TOKENIZATION\) -------
echo ---\[COSINE SIMILARITY\]---
echo LANG   ---   DIMENSION
for lang in fr de ru hi; do
    for dimension in 50 100 150 200 250 300; do
        echo ${lang}   ---   ${dimension}
        python3 -m tfm.evaluation.evaluate_embedding_word_translation \
        data/embeddings/monolingual-${lang}-en-3-6-${dimension}.vec \
        data/embeddings/monolingual-${lang}-en-3-6-${dimension}.vec \
        -d data/datasets/eval_dicts/${lang}-en.txt \
        --retrieval csls --cuda
    done
done
echo ---\[L2 DISTANCE\]---
echo LANG   ---   DIMENSION
for lang in fr de ru hi; do
    for dimension in 50 100 150 200 250 300; do
        echo ${lang}   ---   ${dimension}
        python3 -m tfm.evaluation.evaluate_embedding_word_translation \
        data/embeddings/monolingual-${lang}-en-3-6-${dimension}.vec \
        data/embeddings/monolingual-${lang}-en-3-6-${dimension}.vec \
        -d data/datasets/eval_dicts/${lang}-en.txt \
        --retrieval csls --cuda
    done
done