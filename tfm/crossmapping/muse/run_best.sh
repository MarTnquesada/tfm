#!/usr/bin/env bash

for lang in fr de ru hi; do
    for dimension in 512; do
        python MUSE/unsupervised.py --src_lang ${lang} --tgt_lang en \
            --src_emb ././../../../data/embeddings/monolingual-${lang}-3-6-${dimension}.vec \
            --tgt_emb ././../../../data/embeddings/monolingual-en-3-6-${dimension}.vec \
            --emb_dim ${dimension} --max_vocab 20000 --dis_most_frequent 7500 \
            --exp_path ~/tfm/data/embeddings/ --exp_name ${lang}-en-muse --exp_id ${dimension} \
            --normalize_embeddings center --cuda True
            # If cuda memory error, its probably necessary to reduce vocab size --dico_max_size 20000
    done
done

# BPE mappings
for lang in fr de ru hi; do
    for dimension in 512; do
        python MUSE/unsupervised.py --src_lang ${lang} --tgt_lang en \
            --src_emb ././../../../data/embeddings/monolingual-${lang}-3-6-${dimension}.bpe_48000.${lang}-en.vec \
            --tgt_emb ././../../../data/embeddings/monolingual-en-3-6-${dimension}.bpe_48000.${lang}-en.vec \
            --emb_dim ${dimension} --max_vocab 20000 --dis_most_frequent 7500 \
            --exp_path ~/tfm/data/embeddings/ --exp_name ${lang}-en-muse --exp_id ${dimension}-bpe \
            --normalize_embeddings center --cuda True
            # If cuda memory error, its probably necessary to reduce vocab size --dico_max_size 20000
    done
done