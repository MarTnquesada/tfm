#!/usr/bin/env bash

python XLM/train.py

## main parameters
--exp_name mlm_${lang}_en_${dimension}     # experiment name
--dump_path ././../../../data/models/xlm/  # where to store the experiment

## data location / training objective
--data_path ././../../../data/datasets/monolingual/   # data location
--lgs ${lang}-en                        # considered languages
--clm_steps ''                          # CLM objective
--mlm_steps ${lang}',en'                # MLM objective

## transformer parameters
--emb_dim ${dimension}                  # embeddings / model dimension (was 1024)
--n_layers 6                            # number of layers
--n_heads 8                             # number of heads
--dropout 0.1                           # dropout
--attention_dropout 0.1                 # attention dropout
--gelu_activation true                  # GELU instead of ReLU

## optimization
--batch_size 32                         # sequences per batch
--bptt 256                              # sequences length
--optimizer adam,lr=0.0001              # optimizer
--epoch_size 200000                     # number of sentences per epoch
--validation_metrics _valid_mlm_ppl     # validation metric (when to save the best model)
--stopping_criterion _valid_mlm_ppl,10  # end experiment if stopping criterion does not improve
