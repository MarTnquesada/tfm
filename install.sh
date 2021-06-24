#!/usr/bin/env bash

# Set up docker installations and local paths for their execution
docker build -t moses dockerfiles/moses/.
docker build -t nmt-keras dockerfiles/nmt-keras/.
mkdir data
mkdir data/datasets
mkdir data/trained_models


# Set up conda environment
/usr/local/anaconda3/bin/conda init
conda create -y --no-default-packages --prefix env python=3.7
conda activate env
pip install -r requirements.txt
