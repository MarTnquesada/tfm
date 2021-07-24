#!/usr/bin/env bash

# We found that for languages that share an alphabet,
# learning BPE on the concatenation of the (two or more) involved languages
# increases the consistency of segmentation, and reduces the problem of inserting/deleting characters
# when copying/transliterating names.

# number of merge operations estimated from https://aclanthology.org/2020.findings-emnlp.352.pdf
n_ops=48000

for lang in fr de ru hi; do
    # Monolingual corpus
    monolingual_file=././../../data/datasets/monolingual/monolingual
    file=././../../data/datasets/parallel/${lang}-en
    # learn codes
    ./fastBPE/fast learnbpe ${n_ops} ${monolingual_file}.clean.${lang} ${monolingual_file}.clean.en > ${monolingual_file}.${lang}.codes
    # apply codes to train
    ./fastBPE/fast applybpe ${monolingual_file}.clean.bpe_${n_ops}.${lang} ${monolingual_file}.clean.${lang} ${monolingual_file}.${lang}.codes
    ./fastBPE/fast applybpe ${monolingual_file}.clean.bpe_${n_ops}.${lang}-en ${monolingual_file}.clean.en ${monolingual_file}.${lang}.codes
    # get train vocabulary
    ./fastBPE/fast getvocab ${monolingual_file}.clean.bpe_${n_ops}.${lang} > ${monolingual_file}.clean.bpe_${n_ops}.${lang}.vocab
    ./fastBPE/fast getvocab ${monolingual_file}.clean.bpe_${n_ops}.en > ${monolingual_file}.clean.bpe_${n_ops}.${lang}-en.vocab

    # Parallel corpus
    # apply codes to train
    ./fastBPE/fast applybpe ${file}.train.clean.bpe_${n_ops}.${lang} ${file}.train.clean.${lang} ${monolingual_file}.${lang}.codes ${monolingual_file}.clean.bpe_${n_ops}.${lang}.vocab
    ./fastBPE/fast applybpe ${file}.train.clean.bpe_${n_ops}.en ${file}.train.clean.en ${monolingual_file}.${lang}.codes ${monolingual_file}.clean.bpe_${n_ops}.${lang}-en.vocab
    # apply codes to dev
    ./fastBPE/fast applybpe ${file}.dev.clean.bpe_${n_ops}.${lang} ${file}.dev.clean.${lang} ${monolingual_file}.${lang}.codes ${monolingual_file}.clean.bpe_${n_ops}.${lang}.vocab
    ./fastBPE/fast applybpe ${file}.dev.clean.bpe_${n_ops}.en ${file}.dev.clean.en ${monolingual_file}.${lang}.codes ${monolingual_file}.clean.bpe_${n_ops}.${lang}-en.vocab
    # apply codes to test
    ./fastBPE/fast applybpe ${file}.test.clean.bpe_${n_ops}.${lang} ${file}.test.clean.${lang} ${monolingual_file}.${lang}.codes ${monolingual_file}.clean.bpe_${n_ops}.${lang}.vocab
    ./fastBPE/fast applybpe ${file}.test.clean.bpe_${n_ops}.en ${file}.test.clean.en ${monolingual_file}.${lang}.codes ${monolingual_file}.clean.bpe_${n_ops}.${lang}-en.vocab
done