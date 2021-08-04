# Limitations and challenges of unsupervised cross-lingual pre-training

This repository contains code, data and links that can be used to reproduce the results of this master's thesis.


### Corpora
This work used exclusively corpora released in the WMT14 translation task (see https://www.statmt.org/wmt14/translation-task.html).

*Monolingual data:* 
- *EN*: News Crawl 2011-2013
- *FR*: News Crawl 2007-2013
- *DE*: News Crawl 2012-2013
- *RU*: News Crawl 2007-2013
- *HI*: News Crawl 2007-2013 + HindMonoCorp 0.5

Because the Hindi section of the corpus is quite small and therefore insufficient to train monolingual embeddings, it has been decided to also use the HindMonoCorp 0.5 (http://ufallab.ms.mff.cuni.cz/~bojar/hindencorp/). 
This version of the corpus has the same content as the one provided for the WMT14 pre-release, but some of the tokenization and format inconsistencies have been fixed.
For EN and DE, only part of the News Crawl corpus has been used, as it is desirable to keep the size 

In the case of monolingual corpora, for EN and DE not all of the provided data is used, since it is desirable to keep similar training volumes between all languages to avoid any interactions derived from differences in corpus size.
For HI it could seem as though the corpus is noticeably bigger than all others, but since on average each MB on text information is translated as 2.4MB of information in Hindi due encoding, it actually contains less data than EN, FR and DE.
Since this effect is also notable in Russian (1MB EN per each 1.9MB RU), this is actually the corpus with the lowest amount of data available, even if the file size remains similar to all other languages save for Hindi.  
    
*Parallel data:* Since none of the parallel data sources are available for all of the 4 languages considered, the following options are chosen as train sets:
   - *FR-EN*: Europarlv7, Common Crawl corpus.
   - *DE-EN*: Europarlv7, Common Crawl corpus.
   - *RU-EN*: Common Crawl corpus, Yandex 1M corpus (v1.3 in original case).
   - *HI-EN*: HindiEnCorp 0.5 (as mentioned before, this is a revised version of the original pre-release for WMT14 with no new content but some format fixes).

In this case, there is a similar dataset size for all language pairs barring Hindi (which has a smaller corpus), and therefore no volume corrections are made.
   
The dev corpora used is an aggregation of the development sets provided in the task. Similarly, the filtered test sets used to obtain the final results in the task are used as test dataset.
   
To compile the corpus used in the experiments presented in the project related to this repository, first download all previously mentioned datasets and organize them as follows in the root level of this project:
```

tfm/
    |
    data/
    |   |--datasets/
    |       |--monolingual_sources/
    |       |   |--hindmonocorp05/
    |       |   |--newscrawl
    |       |
    |       |--parallel_sources/
    |           |--commoncrawl
    |           |--dev
    |           |--europarl-v7
    |           |--hindencorp05
    |           |--test
    |           |--yandex1mcorpus
    tfm/
    |   |--...
    ...      
```
After this, execute the bash script `tfm/preprocessing/pack-corpora.sh` to pack the previously listed corpora within a `monolingual` and a `parallel` folder within the `data/datasets` path.

### Pre-processing

The following steps are applied for all monolingual and parallel corpora:
   - Normalize unicode punctuation econding.
   - Tokenization.
   - Clean and eliminate empty sentences, sentences with a ratio higher than 1-9 from source to target, and those containing more than 60 words.

To apply this pre-processing to the corpus, install a Moses Docker image named "moses" and execute the script `tfm/preprocessing/normalize-tokenize-clean.sh`.

In some of the experiments, byte-pair encoding (BPE) is applied to the training datasets in order to evaluate its effect on cross-lingual embeddings and their use as pre-training:

   - For joint BPE embeddings, where both source and target language share the same codes and vocabulary size, use the script `tfm/preprocessing/fastbpe_joint.sh`.
    In general, this approach is most effective when two languages share an alphabet, and facilitates learning cross-lingual features.
   - For independent BPE embeddings (each language's codes are define on their own), use `tfm/preprocessing/fastbpe_independent.sh`.
   
For both options, the monolingual side of the corpora is used to learn the codes and define the vocabulary.
Remember that, when using BPE, it will also need to be applied to bilingual dictionaries used to evaluate cross-lingual models (IMPORTANT: CHECK IF USING THE VOCABULARY WHEN APPLYING BPE TO THE EVAL DICT HAS ANY ADVERSE EFFECT).

<!---
your comment goes here
and here
% No truecasing since it seems kind of inconsecuential for this application, given that it applies capital letters to the beginning of sentences 

HEY WHAT YOU HAVE DONE IS GOOD BUT CHECK THIS, LOOKS INTERESTING https://github.com/rsennrich/wmt16-scripts/blob/master/sample/preprocess.sh
-->

### Monolingual embedding training

Two main embedding models were used in this work:
   - **Word2vec skip-gram embeddings**. For this, the FastText framework was used, although only the word vectors (.vec) files were used for experimentation, ignoring the models containing subword information (.bin).
   All embeddings used default parameters except for dimension, whose effects are studied in this work: `./tfm/embeddings/fasttext/fastText/fasttext skipgram -input <INPUT> -output <OUTPUT> -minn 3 -maxn 6 -dim <DIM> -epoch 5 -lr 0.05`
   To generate all FastText embeddings used in this work, use `tfm/embeddings/fasttext/run.sh`.
   - **XLM (cross-lingual language model)**. 
   
### Cross-lingual embedding mapping

   - **VecMap**. An example launch of the VecMap cross-mapping procedure for a pair of FastText embeddings in French and English with dimension 100 would be the following:
   `python -m tfm.crossmapping.vecmap.map_embeddings data/embeddings/monolingual-fr-3-6-100.vec data/embeddings/monolingual-en-3-6-100.vec data/embeddings/monolingual-fr-3-6-100-en.vec data/embeddings/monolingual-en-3-6-100-fr.vec --cuda --batch_size 1000 --unsupervised --verbose`
    There exists a known bug that creates memory allocation problems for mappings of embeddings with dimension greater than 150 when using CUDA support.
    For this reason, mappings for embeddings of dimension >= 150 are calculated on CPU.
    To get all VecMap cross-mapped embeddings used in this work, use `tfm/crossmapping/vecmap/run.sh`.
   - **MUSE**. To get all MUSE cross-mapped embeddings used in this work, use `tfm/crossmapping/muse/run.sh`.
   - *Concat*. Trains FastText embeddings over a concatenation of monolingual corpora. To get all concat embeddings used in this work, use `tfm/embeddings/fasttext/run_concat.sh`.
   - **XLM**. 

### Cross-lingual embedding evaluation
   - **Word translation (BLI)**. For both L2-distance and cosine similarity evaluations, the script `tfm/evaluation/evaluate_embedding_word_translation`, taken from the VecMap repository, is used.
   In the case of L2-distance, use the option --dot. For cosine similarity, omit this parameter. 
   An example for the evaluation of fr-en cross-mapped embeddings could be `python -m tfm.evaluation.evaluate_embedding_word_translation data/embeddings/monolingual-fr-3-6-100-en.vec data/embeddings/monolingual-en-3-6-100-fr.vec -d data/datasets/eval_dicts/fr-en.txt --cuda`
   The bilingual dictionaries used for evaluation are the full sets provided in https://github.com/facebookresearch/MUSE.


### Transformer NN training (with pre-trained cross-lingual embeddings)

   - **NMT-Keras**
   - **OpenNMT**
   - **MarianMT**

### Transformer NN evaluation (with pre-trained cross-lingual embeddings)



### License
Copyright (C) 2021, Martín Quesada Zaragoza
Licensed under the terms of the GNU General Public License, either version 3 or (at your option) any later version. A full copy of the license can be found in LICENSE.txt.