#!/usr/bin/env bash

while getopts c:b: flag
do
    case "${flag}" in
        c) config=${OPTARG};;
        b) bpe=${OPTARG};;
    esac
done

# If using BPE, no need to generate vocab, instead use pre-generated BPE dictionary
if [ ${bpe} = "" ]; then
    echo "Building vocab for model ${config}"
    onmt_build_vocab -config ${config} -n_sample 10000
fi

echo "Launching Transformer model training for ${config}"
onmt_train -config ${config}