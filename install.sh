#!/usr/bin/env bash

# Create data folders
mkdir data
mkdir data/datasets
mkdir data/models
cp tfm/tfm/train-nmt-opennmt-py/configs/ data/models/
mkdir data/models/trained/
mkdir data/embeddings

# Set up docker installations and local paths for their execution
docker build -t moses dockerfiles/moses/.

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

# Install fastBPE Python API
cd tfm/preprocessing/fastBPE/
python setup.py install
cd ../../../

# Install MUSE dependencies
cd tfm/embeddings/muse
git clone https://github.com/facebookresearch/MUSE
cd ../../../
pip install torch
conda install -c pytorch faiss-gpu --force
pip install scipy

# Install XLM
cd ././tfm/crossmapping/xlm/XLM/
pip install -e .
cd ../../../../

# Install OpenNMT-py
pip install OpenNMT-py

