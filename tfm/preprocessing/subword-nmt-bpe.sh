#!/usr/bin/env bash

# In general, BPE is recommended as preprocessing for corpus in machine translation because its segmentation procedure reduces processing time and contains subword information
# In the case of embeddings, there is not that much research on it, but GloVe and  word2vec models
# where only the individual word vectors are taken into consideration the study:
# Faster Training of Word Embeddings - https://openreview.net/pdf?id=v5WXtSXsVCJ
# shows that it can speed-up training and provide slightly better semantic quality but worse syntactic quality in the case of fastText instead of using subword information
# since the individual word vectors (.vec file in fasttext) do not contain subword information and we are forced to use them instead of the binary model,
# it is possible that training the vectors (and the final models) over BPE provides better cross-lingual results (and incidentally faster training speed)

L1=$1
L2=$2
CORPUS_FILE=$3
VOCAB_FILE=$4
CODES_FILE=$5
NUM_OPERATIONS=$6

# Learn byte pair encoding on the concatenation of the training text, and get resulting vocabulary for each
subword-nmt learn-joint-bpe-and-vocab --input $CORPUS_FILE.$L1 $CORPUS_FILE.$L2 -s $NUM_OPERATIONS -o $CODES_FILE --write-vocabulary $VOCAB_FILE.$L1 $VOCAB_FILE.$L2

# Re-apply byte pair encoding with vocabulary filter, obtaining the joint codes file acting as the joint embedding, which is commonly used as a parameter for the nmt framework:
subword-nmt apply-bpe -c $CODES_FILE --vocabulary $VOCAB_FILE.$L1 --vocabulary-threshold 50 < $CORPUS_FILE.$L1 > $CORPUS_FILE.BPE.$L1
subword-nmt apply-bpe -c $CODES_FILE  --vocabulary $VOCAB_FILE.$L2 --vocabulary-threshold 50 < $CORPUS_FILE.$L2 > $CORPUS_FILE.BPE.$L2

# As a last step, extract the vocabulary to be used by the neural network. Example with Nematus:
# nematus/data/build_dictionary.py $CORPUS_FILE.BPE.$L1 $CORPUS_FILE.BPE.$L2
