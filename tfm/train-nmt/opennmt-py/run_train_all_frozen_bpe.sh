#!/usr/bin/env bash

# BPE
for lang in fr de ru hi; do
    for method in base muse vecmap concat; do
        for dimension in 512; do
            for weights in frozen; do
                mkdir data/models/trained/${lang}-en_${dimension}_${method}_${weights}_bpe/
                ./tfm/train-nmt/opennmt-py/train.sh -c ./tfm/train-nmt/opennmt-py/configs/${lang}-en/${lang}-en_${dimension}_${method}_${weights}_bpe.yml -b true
            done
        done
    done
done