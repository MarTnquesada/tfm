#!/usr/bin/env bash

# number of merge operations estimated from https://aclanthology.org/2020.findings-emnlp.352.pdf
n_ops=48000

# Monolingual corpus
monolingual_file=././../../data/datasets/monolingual/monolingual
for lang in en fr de ru hi; do
    # learn codes
    ./fastBPE/fast learnbpe ${n_ops} ${monolingual_file}.clean.${lang} > ${monolingual_file}.${lang}.clean.bpe_${n_ops}.codes
    # apply codes to train
    ./fastBPE/fast applybpe ${monolingual_file}.clean.bpe_${n_ops}.${lang} ${monolingual_file}.${lang}.clean.bpe_${n_ops}.codes
    # get train vocabulary
    ./fastBPE/fast getvocab ${monolingual_file}.clean.bpe_${n_ops}.${lang} > ${monolingual_file}.clean.bpe_${n_ops}.${lang}.vocab
done

# Parallel corpus
for lang in fr de ru hi; do
    file=././../../data/datasets/parallel/${lang}-en
    # apply codes to train
    ./fastBPE/fast applybpe ${file}.train.clean.bpe_${n_ops}.${lang} ${file}.train.clean.${lang} ${monolingual_file}.${lang}.clean.bpe_${n_ops}.codes ${monolingual_file}.clean.bpe_${n_ops}.${lang}.vocab
    ./fastBPE/fast applybpe ${file}.train.clean.bpe_${n_ops}.en ${file}.train.clean.en ${monolingual_file}.en.clean.bpe_${n_ops}.codes ${monolingual_file}.clean.bpe_${n_ops}.en.vocab
    # apply codes to dev
    ./fastBPE/fast applybpe ${file}.dev.clean.bpe_${n_ops}.${lang} ${file}.dev.clean.${lang} ${monolingual_file}.${lang}.clean.bpe_${n_ops}.codes ${monolingual_file}.clean.bpe_${n_ops}.${lang}.vocab
    ./fastBPE/fast applybpe ${file}.dev.clean.bpe_${n_ops}.en ${file}.dev.clean.en ${monolingual_file}.en.clean.bpe_${n_ops}.codes ${monolingual_file}.clean.bpe_${n_ops}.en.vocab
    # apply codes to test
    ./fastBPE/fast applybpe ${file}.test.clean.bpe_${n_ops}.${lang} ${file}.test.clean.${lang} ${monolingual_file}.${lang}.clean.bpe_${n_ops}.codes ${monolingual_file}.clean.bpe_${n_ops}.${lang}.vocab
    ./fastBPE/fast applybpe ${file}.test.clean.bpe_${n_ops}.en ${file}.test.clean.en ${monolingual_file}.en.clean.bpe_${n_ops}.codes ${monolingual_file}.clean.bpe_${n_ops}.en.vocab
done