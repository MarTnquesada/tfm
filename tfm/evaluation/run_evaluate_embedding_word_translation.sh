#!/usr/bin/env bash

echo
echo ------------ MUSE ------------
echo ------- \(BASE TOKENIZATION\) -------
echo ---\[COSINE SIMILARITY\]---
echo LANG   ---   DIMENSION
for lang in fr de ru hi; do
    for dimension in 512; do
        echo ${lang}   ---   ${dimension}
        python3 -m tfm.evaluation.evaluate_embedding_word_translation \
        data/embeddings/${lang}-en-muse/${dimension}/vectors-${lang}.txt \
        data/embeddings/${lang}-en-muse/${dimension}/vectors-en.txt \
        -d data/datasets/eval_dicts/${lang}-en.txt \
        --retrieval csls
    done
done

echo
echo ------------ CONCAT------------
echo ------- \(BASE TOKENIZATION\) -------
echo ---\[COSINE SIMILARITY\]---
echo LANG   ---   DIMENSION
for lang in ru hi; do
    for dimension in 512; do
        echo ${lang}   ---   ${dimension}
        python3 -m tfm.evaluation.evaluate_embedding_word_translation \
        data/embeddings/monolingual-${lang}-en-3-6-${dimension}.vec \
        data/embeddings/monolingual-${lang}-en-3-6-${dimension}.vec \
        -d data/datasets/eval_dicts/${lang}-en.txt \
        --retrieval csls
    done
done

echo
echo ------------ MUSE ------------
echo ------- \(BASE TOKENIZATION\) -------
echo ---\[COSINE SIMILARITY\]---
echo LANG   ---   DIMENSION
for lang in fr de ru hi; do
    for dimension in 512; do
        echo ${lang}   ---   ${dimension}
        python3 -m tfm.evaluation.evaluate_embedding_word_translation \
        data/embeddings/${lang}-en-muse/${dimension}/vectors-${lang}.txt \
        data/embeddings/${lang}-en-muse/${dimension}/vectors-en.txt \
        -d data/datasets/eval_dicts/${lang}-en.txt \
        --retrieval csls
    done
done


echo
echo ------------ BASELINE ------------
echo ------- \(BASE TOKENIZATION\) -------
echo ---\[COSINE SIMILARITY\]---
echo LANG   ---   DIMENSION
for lang in fr de ru hi; do
    for dimension in 512; do
        echo ${lang}   ---   ${dimension}
        python3 -m tfm.evaluation.evaluate_embedding_word_translation \
        data/embeddings/monolingual-${lang}-3-6-${dimension}.vec \
        data/embeddings/monolingual-en-3-6-${dimension}.vec \
        -d data/datasets/eval_dicts/${lang}-en.txt \
        --retrieval csls
    done
done

echo
echo ------------ VECMAP ------------
echo ------- \(BASE TOKENIZATION\) -------
echo ---\[COSINE SIMILARITY\]---
echo LANG   ---   DIMENSION
for lang in fr de ru hi; do
    for dimension in 512; do
        echo ${lang}   ---   ${dimension}
        python3 -m tfm.evaluation.evaluate_embedding_word_translation \
        data/embeddings/monolingual-${lang}-3-6-${dimension}-vecmap-en.vec \
        data/embeddings/monolingual-en-3-6-${dimension}-vecmap-${lang}.vec \
        -d data/datasets/eval_dicts/${lang}-en.txt \
        --retrieval csls
    done
done
