#!/usr/bin/env bash

# go to "Train your own XLM model with MLM or MLM+TLM" in the XLM github (no need to add TLM)
# and especially the section right after (Applications: Supervised / Unsupervised MT)

# Requires that corpora are tokenized with BPE - this script takes joint BPE tokenization
for lang in fr de ru hi; do
    for dimension in 50 100 150 200 250 300; do
        # Binarize vocab and training data
        # Source
        python XLM/preprocess.py \
        ././../../../data/datasets/monolingual/${monolingual_file}.clean.${lang}-en.bpe_${n_ops}.${lang}-en.vocab \
        ././../../../data/datasets/monolingual/${monolingual_file}.clean.${lang}.bpe_${n_ops}.${lang}-en
        # Target
        python XLM/preprocess.py \
        ././../../../data/datasets/monolingual/${monolingual_file}.clean.${lang}-en.bpe_${n_ops}.${lang}-en.vocab \
        ././../../../data/datasets/monolingual/${monolingual_file}.clean.en.bpe_${n_ops}.${lang}-en

        # Train XLM model (MLM only) from monolingual corpora
        python XLM/train.py

        # Train model on supervised corpora from pretrained XLM
        python XLM/train.py
    done
done