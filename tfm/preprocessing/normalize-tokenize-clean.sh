#!/usr/bin/env bash
# Check out http://www.statmt.org/wmt07/baseline.html

# Normalize encoding, clean and tokenize monolingual corpus
file=/data/datasets/monolingual/monolingual
for lang in en fr de ru hi; do
    docker container run -it --rm -v ${PWD}/data/:/data moses /bin/bash -c "scripts/tokenizer/normalize-punctuation.perl -l ${lang} < ${file}.${lang} > ${file}.norm.${lang}"
    docker container run -it --rm -v ${PWD}/data/:/data moses /bin/bash -c "scripts/tokenizer/tokenizer.perl -l ${lang} < ${file}.norm.${lang} > ${file}.tok.${lang}"
    docker container run -it --rm -v ${PWD}/data/:/data moses /bin/bash -c "scripts/training/clean-corpus-n.perl ${file}.tok ${lang} ${lang} ${file}.clean 1 60"
    docker container run -it --rm -v ${PWD}/data/:/data moses /bin/bash -c "rm ${file}.norm.${lang}"
    docker container run -it --rm -v ${PWD}/data/:/data moses /bin/bash -c "rm ${file}.tok.${lang}"
done


# Normalize encoding, clean and tokenize parallel corpus
for lang in fr de ru hi; do
    for set in train dev test; do
        file=/data/datasets/parallel/${lang}-en.${set}
        docker container run -it --rm -v ${PWD}/data/:/data moses /bin/bash -c "scripts/tokenizer/normalize-punctuation.perl -l ${lang} < ${file}.${lang} > ${file}.norm.${lang}"
        docker container run -it --rm -v ${PWD}/data/:/data moses /bin/bash -c "scripts/tokenizer/normalize-punctuation.perl -l en < ${file}.en > ${file}.norm.en"
        docker container run -it --rm -v ${PWD}/data/:/data moses /bin/bash -c "scripts/tokenizer/tokenizer.perl -l ${lang} < ${file}.norm.${lang} > ${file}.tok.${lang}"
        docker container run -it --rm -v ${PWD}/data/:/data moses /bin/bash -c "scripts/tokenizer/tokenizer.perl -l en < ${file}.norm.en > ${file}.tok.en"
        docker container run -it --rm -v ${PWD}/data/:/data moses /bin/bash -c "scripts/training/clean-corpus-n.perl ${file}.tok ${lang} en ${file}.clean 1 60"
        docker container run -it --rm -v ${PWD}/data/:/data moses /bin/bash -c "rm ${file}.norm.${lang}"
        docker container run -it --rm -v ${PWD}/data/:/data moses /bin/bash -c "rm ${file}.norm.en"
        docker container run -it --rm -v ${PWD}/data/:/data moses /bin/bash -c "rm ${file}.tok.${lang}"
        docker container run -it --rm -v ${PWD}/data/:/data moses /bin/bash -c "rm ${file}.tok.en"
    done
done
