#!/usr/bin/env bash

CURRENT_DIR=$PWD
LIB=$CURRENT_DIR/third_party
mkdir -p $LIB

conda create --name sgb python==3.6.10
conda activate sgb
conda config --add channels conda-forge
conda config --add channels pytorch

conda install pytorch==1.5.1 torchvision==0.6.1 cudatoolkit=10.2 -c pytorch
conda install six scikit-learn stringcase ply slimit astunparse submitit
pip install transformers cython
pip install fairseq==0.10.2

cd $LIB
git clone https://github.com/tree-sitter/tree-sitter-cpp.git
git clone https://github.com/tree-sitter/tree-sitter-java.git
git clone https://github.com/tree-sitter/tree-sitter-python.git

# install apex
git clone https://github.com/NVIDIA/apex
cd apex
export CXX=g++
export CUDA_HOME=/usr/local/cuda-10.2
# https://github.com/NVIDIA/apex/issues/1043#issuecomment-773868833
git reset --hard 3fe10b5597ba14a748ebb271a6ab97c09c5701ac
pip install -v --disable-pip-version-check --no-cache-dir --global-option="--cpp_ext" --global-option="--cuda_ext" .
cd $CURRENT_DIR

pip install sacrebleu=="1.2.11" faiss-cpu=="1.6.1"
pip install javalang tree_sitter psutil fastBPE sentencepiece prettytable
