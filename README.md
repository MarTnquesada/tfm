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


No truecasing since it seems kind of inconsecuential for this application, given that it applies capital letters to the beginning of sentences (check this file:///Users/martin/Downloads/information-10-00161.pdf) and we want to modify as little as possible the given dev and test sets

HEY WHAT YOU HAVE DONE IS GOOD BUT CHECK THIS, LOOKS INTERESTING https://github.com/rsennrich/wmt16-scripts/blob/master/sample/preprocess.sh


### Monolingual embedding training


### Cross-lingual embedding evaluation
**Word translation (BLI)**

For both L2-distance and cosine similarity evaluations, the script `tfm/evaluation/evaluate_embedding_word_translation`, taken from the VecMap repository, is used.
In the case of L2-distance, use the option --dot. For cosine similarity, omit this parameter.


### Transformer NN training (with pre-trained cross-lingual embeddings)

**NMT-Keras**
xd

### Transformer NN evaluation (with pre-trained cross-lingual embeddings)



### License
Copyright (C) 2021, Martín Quesada Zaragoza
Licensed under the terms of the GNU General Public License, either version 3 or (at your option) any later version. A full copy of the license can be found in LICENSE.txt.