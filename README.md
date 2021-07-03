# Limitations and challenges of unsupervised cross-lingual pre-training

This repository contains code, data and links that can be used to reproduce the results of this master's thesis.


### Corpora
This work used mostly corpora released in the WMT14 translation task (see https://www.statmt.org/wmt14/translation-task.html).
*Monolingual data:* News Crawl 2007-2013 for English, French, German, Russian and Hindi (for all the years where the language is available).
    
*Parallel data:* Since none of the parallel data sources are available for all of the 4 languages considered, the following options are chosen:
   - *FR-EN*: Europarlv7, Common Crawl corpus, News commentary.
   - *DE-EN*: Europarlv7, Common Crawl corpus, News commentary.
   - *RU-EN*: Common Crawl corpus, News commentary, Yandex 1M corpus.
   - *HI-EN*: Wiki Headlines, HindiEnCorp
   
   
### Pre-processing


### Monolingual embedding training


### Cross-lingual embedding evaluation
*Word translation (BLI)*
For both L2-distance and cosine similarity evaluations, the script `tfm/evaluation/evaluate_embedding_word_translation` is used.
In the case of L2-distance, use the option --dot. For cosine similarity, omit this parameter.


### Cross-lingual embedding + Transformer NN training


### Cross-lingual embedding + Transformer NN evaluation


### License
Copyright (C) 2021, Martín Quesada Zaragoza
Licensed under the terms of the GNU General Public License, either version 3 or (at your option) any later version. A full copy of the license can be found in LICENSE.txt.