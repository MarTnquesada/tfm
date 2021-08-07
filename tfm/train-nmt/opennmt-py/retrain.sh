#!/usr/bin/env bash

while getopts k: flag
do
    case "${flag}" in
        k) checkpoint=${OPTARG};;
    esac
done

onmt_train -train_from ${checkpoint}