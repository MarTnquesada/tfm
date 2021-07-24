#!/usr/bin/env bash

# Set up docker installations and local paths for their execution
docker build -t moses dockerfiles/moses/.
docker build -t nmt-keras dockerfiles/nmt-keras/.
mkdir data
mkdir data/datasets
mkdir data/trained_models

# Install fastBPE
git clone https://github.com/glample/fastBPE.git tfm/preprocessing/fastBPE/
cd tfm/preprocessing/fastBPE/
g++ -std=c++11 -pthread -O3 fastBPE/main.cc -IfastBPE -o fast
cd ../../../

# Set up conda environment
/usr/local/anaconda3/bin/conda init
conda create -y --no-default-packages --prefix env python=3.7
conda activate env/
pip install -r requirements.txt
