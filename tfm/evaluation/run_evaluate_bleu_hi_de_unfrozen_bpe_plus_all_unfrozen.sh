#!/usr/bin/env bash

# BPE
for lang in de hi; do
  for method in base muse vecmap concat; do
    echo "${lang} -- ${method} -- unfrozen - bpe"
    onmt_translate -model data/models/trained/${lang}-en_512_${method}_unfrozen_bpe/model_step_20000.pt -src data/datasets/parallel/${lang}-en.test.clean.bpe_48000.${lang} -output data/models/eval/pred_${lang}-en_512_${method}_unfrozen_bpe.txt -gpu 0
    docker container run --rm -v ${PWD}/data/:/data moses /bin/bash -c "scripts/generic/multi-bleu.perl /data/datasets/parallel/${lang}-en.test.clean.bpe_48000.en < /data/models/eval/pred_${lang}-en-512.txt"
  done
done

# Non-BPE
for lang in fr de ru hi; do
  for method in base muse vecmap concat; do
    echo "${lang} -- ${method} -- unfrozen - nonbpe"
    onmt_translate -model data/models/trained/${lang}-en_512_${method}_unfrozen/model_step_20000.pt -src data/datasets/parallel/${lang}-en.test.clean.${lang} -output data/models/eval/pred_${lang}-en_512_${method}_unfrozen_bpe.txt -gpu 0
    docker container run --rm -v ${PWD}/data/:/data moses /bin/bash -c "scripts/generic/multi-bleu.perl /data/datasets/parallel/${lang}-en.test.clean.en < /data/models/eval/pred_${lang}-en_512_${method}_unfrozen_bpe.txt"
  done
done