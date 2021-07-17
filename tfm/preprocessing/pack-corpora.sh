#!/usr/bin/env bash

# Instead of using this script to pack all the original corpora, you can also download the ready-to-go version from __

### BUILD MONOLINGUAL CORPUS ###
mkdir ././../../data/datasets/monolingual
echo "Building monolingual corpus..."

# News Crawl 2011-2013 for EN
lang=en
for file in ././../../data/datasets/monolingual_sources/newscrawl/news.201[1-3].${lang}.shuffled; do
  echo "Appending NewsCrawl file ${file} to ${lang} monolingual corpus"
  cat ${file} >> ././../../data/datasets/monolingual/monolingual.${lang}
done

# News Crawl 2007-2013 for FR
lang=fr
for file in ././../../data/datasets/monolingual_sources/newscrawl/*.${lang}.shuffled; do
  echo "Appending NewsCrawl file ${file} to ${lang} monolingual corpus"
  cat ${file} >> ././../../data/datasets/monolingual/monolingual.${lang}
done

# News Crawl 2012-2013 for DE
lang=de
for file in ././../../data/datasets/monolingual_sources/newscrawl/news.201[2-3].${lang}.shuffled; do
  echo "Appending NewsCrawl file ${file} to ${lang} monolingual corpus"
  cat ${file} >> ././../../data/datasets/monolingual/monolingual.${lang}
done

# News Crawl 2007-2013 for RU
lang=ru
for file in ././../../data/datasets/monolingual_sources/newscrawl/*.${lang}.shuffled; do
  echo "Appending NewsCrawl file ${file} to ${lang} monolingual corpus"
  cat ${file} >> ././../../data/datasets/monolingual/monolingual.${lang}
done

# News Crawl 2007-2013 for HI
lang=hi
for file in ././../../data/datasets/monolingual_sources/newscrawl/*.${lang}.shuffled; do
  echo "Appending NewsCrawl file ${file} to ${lang} monolingual corpus"
  cat ${file} >> ././../../data/datasets/monolingual/monolingual.${lang}
done

# HindMonoCorp 0.5 for HI
echo "Appending HindMonoCorp to hi monolingual corpus"
cut -f3 ././../../data/datasets/monolingual_sources/hindmonocorp05/hindmonocorp05.plaintext >> ././../../data/datasets/monolingual/monolingual.hi
# cut -f3 ././../../data/datasets/monolingual_sources/hindmonocorp05/hindmonocorp05.plaintext | head -n 30000000  >> ././../../data/datasets/monolingual/monolingual.hi
echo "Finished building monolingual corpora"


### BUILD PARALLEL CORPUS ###
mkdir ././../../data/datasets/parallel
echo "Building parallel corpus train set..."

# CommonCrawl for {FR,DE,RU}-EN
for lang in fr de ru; do
    file1="././../../data/datasets/parallel_sources/commoncrawl/*.${lang}-en.${lang}"
    echo "Appending file ${file1} to ${lang}-en parallel corpus"
    cat ${file1} >> ././../../data/datasets/parallel/${lang}-en.train.${lang}
    file2="././../../data/datasets/parallel_sources/commoncrawl/*.${lang}-en.en"
    echo "Appending file ${file2} to ${lang}-en parallel corpus"
    cat ${file2} >> ././../../data/datasets/parallel/${lang}-en.train.en
done

# Europarlv7 for {FR,DE}-EN
for lang in fr de; do
    file1="././../../data/datasets/parallel_sources/europarl-v7/*.${lang}-en.${lang}"
    echo "Appending file ${file1} to ${lang}-en parallel corpus"
    cat ${file1} >> ././../../data/datasets/parallel/${lang}-en.train.${lang}
    file2="././../../data/datasets/parallel_sources/europarl-v7/*.${lang}-en.en"
    echo "Appending file ${file2} to ${lang}-en parallel corpus"
    cat ${file2} >> ././../../data/datasets/parallel/${lang}-en.train.en
done

# Yandex1Mcorpus
echo "Appending Yandex1MCorpus to en-ru parallel corpus"
cat ././../../data/datasets/parallel_sources/yandex1mcorpus/corpus.en_ru.1m.ru >> ././../../data/datasets/parallel/ru-en.train.ru
cat ././../../data/datasets/parallel_sources/yandex1mcorpus/corpus.en_ru.1m.en >> ././../../data/datasets/parallel/ru-en.train.en

# HindEnCorp 0.5 for HI-EN
echo "Appending HindEnCorp file ${file} to hi parallel corpus"
cut -f5 ././../../data/datasets/parallel_sources/hindencorp05/hindencorp05.plaintext >> ././../../data/datasets/parallel/hi-en.train.hi
cut -f4 ././../../data/datasets/parallel_sources/hindencorp05/hindencorp05.plaintext >> ././../../data/datasets/parallel/hi-en.train.en

echo "Finished building parallel corpora train set"

# dev set
echo "Building parallel corpus dev set..."
for lang in fr de ru; do
    for file in ././../../data/datasets/parallel_sources/dev/*.${lang}; do
        echo "Appending file ${file} to ${lang}-en dev parallel corpus"
        cat ${file} >> ././../../data/datasets/parallel/${lang}-en.dev.${lang}
        echo "Appending file ${file%.*}.en  to ${lang}-en dev parallel corpus"
        cat ${file%.*}.en >> ././../../data/datasets/parallel/${lang}-en.dev.en
    done
done
# HI
cat ././../../data/datasets/parallel_sources/dev/enhi_v1/newsdev2014.hi >> ././../../data/datasets/parallel/hi-en.dev.hi
cat ././../../data/datasets/parallel_sources/dev/enhi_v1/newsdev2014.en >> ././../../data/datasets/parallel/hi-en.dev.en
echo "Finished building parallel corpora dev set"

# test set
echo "Building parallel corpus test set..."
for lang in fr de ru hi; do
    python parse-sgm-lines.py --ifile1 ././../../data/datasets/parallel_sources/test/newstest2014-${lang}en-src.${lang}.sgm --ifile2 ././../../data/datasets/parallel_sources/test/newstest2014-${lang}en-ref.en.sgm --ofile1 ././../../data/datasets/parallel/${lang}-en.test.${lang} --ofile2 ././../../data/datasets/parallel/${lang}-en.test.en
done
echo "Finished building parallel corpora test set"