#!/usr/bin/env bash

for lang in fr de ru hi; do
    for dimension in 50 100 150 200 250; do
        python MUSE/unsupervised.py --src_lang ${lang} --tgt_lang en \
            --src_emb ././../../../data/embeddings/monolingual-${lang}-3-6-${dimension}.vec \
            --tgt_emb ././../../../data/embeddings/monolingual-en-3-6-${dimension}.vec \
            --cuda --max_vocab -1
        # CAREFUL: if memory errors happen, return max_vocab to default value
    done
done