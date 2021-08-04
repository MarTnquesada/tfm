#!/usr/bin/env bash

for lang in fr de ru hi; do
    for dimension in 50 100 150 200 250; do
        cp ././../../../data/embeddings/monolingual-${lang}-3-6-${dimension}.vec ././../../../data/embeddings/monolingual-${lang}-3-6-${dimension}-muse-en.vec
        cp ././../../../data/embeddings/monolingual-en-3-6-${dimension}.vec ././../../../data/embeddings/monolingual-en-3-6-${dimension}-muse-${lang}.vec
        python MUSE/unsupervised.py --src_lang ${lang} --tgt_lang en \
            --src_emb ././../../../data/embeddings/monolingual-${lang}-3-6-${dimension}-muse-en.vec \
            --tgt_emb ././../../../data/embeddings/monolingual-en-3-6-${dimension}-muse-${lang}.vec\
            --emb_dim ${dimension}--cuda --max_vocab -1
        # CAREFUL: if memory errors happen, return max_vocab to default value
    done
done