#!/usr/bin/env bash

# go to "Train your own XLM model with MLM or MLM+TLM" in the XLM github (no need to add TLM)
# and especially the section right after (Applications: Supervised / Unsupervised MT)

# Requires that corpora are tokenized with BPE - this script takes joint BPE tokenization
for lang in fr de ru hi; do
    for dimension in 1024; do
        # Binarize vocab and training data
        # Source
        python XLM/preprocess.py \
        ././../../../data/datasets/monolingual/monolingual.clean.${lang}-en.bpe_48000.${lang}-en.vocab \
        ././../../../data/datasets/monolingual/monolingual.clean.${lang}.bpe_48000.${lang}-en
        # Target
        python XLM/preprocess.py \
        ././../../../data/datasets/monolingual/monolingual.clean.${lang}-en.bpe_48000.${lang}-en.vocab \
        ././../../../data/datasets/monolingual/monolingual.clean.en.bpe_48000.${lang}-en

        # Train XLM model (MLM only) from monolingual corpora
        ./pretrain.sh

        # Train model on supervised corpora from pretrained XLM
        ./train_unsupervised.sh
    done
done