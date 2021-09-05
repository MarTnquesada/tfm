#!/usr/bin/env bash

echo
echo ------------ CONCAT------------
echo ------- \(BPE TOKENIZATION\) -------
echo ---\[COSINE SIMILARITY\]---
echo LANG   ---   DIMENSION
for lang in fr de ru hi; do
    for dimension in 512; do
        echo ${lang}   ---   ${dimension}
        python3 -m tfm.evaluation.evaluate_embedding_word_translation \
        data/embeddings/monolingual-${lang}-en-3-6-${dimension}.bpe_48000.vec \
        data/embeddings/monolingual-${lang}-en-3-6-${dimension}.bpe_48000.vec \
        -d data/datasets/eval_dicts/${lang}-en.txt \
        --retrieval csls
    done
done

echo
echo ------------ MUSE ------------
echo ------- \(BPE TOKENIZATION\) -------
echo ---\[COSINE SIMILARITY\]---
echo LANG   ---   DIMENSION
for lang in fr de ru hi; do
    for dimension in 512; do
        echo ${lang}   ---   ${dimension}
        python3 -m tfm.evaluation.evaluate_embedding_word_translation \
        data/embeddings/${lang}-en-muse/${dimension}-bpe/vectors-${lang}.txt \
        data/embeddings/${lang}-en-muse/${dimension}-bpe/vectors-en.txt \
        -d data/datasets/eval_dicts/${lang}-en.txt \
        --retrieval csls
    done
done

echo
echo ------------ BASELINE ------------
echo ------- \(BPE TOKENIZATION\) -------
echo ---\[COSINE SIMILARITY\]---
echo LANG   ---   DIMENSION
for lang in fr de ru hi; do
    for dimension in 512; do
        echo ${lang}   ---   ${dimension}
        python3 -m tfm.evaluation.evaluate_embedding_word_translation \
        data/embeddings/monolingual-${lang}-3-6-${dimension}.bpe_48000.${lang}-en.vec \
        data/embeddings/monolingual-en-3-6-${dimension}.bpe_48000.${lang}-en.vec \
        -d data/datasets/eval_dicts/${lang}-en.txt \
        --retrieval csls
    done
done

echo
echo ------------ VECMAP ------------
echo ------- \(BPE TOKENIZATION\) -------
echo ---\[COSINE SIMILARITY\]---
echo LANG   ---   DIMENSION
for lang in fr de ru hi; do
    for dimension in 512; do
        echo ${lang}   ---   ${dimension}
        python3 -m tfm.evaluation.evaluate_embedding_word_translation \
        data/embeddings/monolingual-${lang}-3-6-${dimension}.bpe_48000.${lang}-en.vecmap-en.vec \
        data/embeddings/monolingual-en-3-6-${dimension}.bpe_48000.${lang}-en.vecmap-${lang}.vec \
        -d data/datasets/eval_dicts/${lang}-en.txt \
        --retrieval csls
    done
done

