
**Example of training launch with default parameters:**

    ./fasttext skipgram -input data/fil9 -output result/fil9 -minn 3 -maxn 6 -dim 100 -epoch 5 -lr 0.05
    
The output is a fil9.bin file and a fil9.vec file. The former is the full fasttext model, which includes subword information, while the latter only contains the word vectors.
BPE could be applied as preprocessing for the corpus if only the word vectors can be used, otherwise not since the subword information in fasttext plays a similar role.