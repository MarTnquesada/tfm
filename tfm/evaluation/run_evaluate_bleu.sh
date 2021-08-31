#!/usr/bin/env bash

for lang in fr de ru hi; do
    onmt_translate -model data/models/trained/${lang}-en/run/model_step_40000.pt -src data/datasets/parallel/${lang}-en.test.clean.${lang} -output data/models/eval/pred_${lang}-en.txt -gpu 0 -verbose
    docker container run -it --rm -v ${PWD}/data/:/data moses /bin/bash -c "scripts/generic/multi-bleu.perl data/datasets/parallel/${lang}-en.test.clean.en < data/models/eval/pred_${lang}-en.txt"
done