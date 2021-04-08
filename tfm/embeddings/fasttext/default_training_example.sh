#!/usr/bin/env bash

./fasttext skipgram -input data/fil9 -output result/fil9 -minn 3 -maxn 6 -dim 100 -epoch 5 -lr 0.05