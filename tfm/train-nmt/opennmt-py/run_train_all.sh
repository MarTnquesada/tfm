#!/usr/bin/env bash

# Non-BPE

# BPE
for lang in en fr de ru hi; do
    for method in base muse vecmap concat; do
        for dimension in 512; do
            for weights in frozen unfrozen; do
                mkdir data/models/trained/${lang-en}_${dimension}_${method}_${weights}
                ./tfm/train-nmt/opennmt-py/train.sh -c ./tfm/train-nmt/opennmt-py/configs/${lang-en}/${lang-en}_${dimension}_${method}_${weights}.yml
            done
        done
    done
done

# BPE
for lang in en fr de ru hi; do
    for method in base muse vecmap concat; do
        for dimension in 512; do
            for weights in frozen unfrozen; do
                mkdir data/models/trained/${lang-en}_${dimension}_${method}_${weights}_bpe/
                ./tfm/train-nmt/opennmt-py/train.sh -c ./tfm/train-nmt/opennmt-py/configs/${lang-en}/${lang-en}_${dimension}_${method}_${weights}_bpe.yml -b true
            done
        done
    done
done