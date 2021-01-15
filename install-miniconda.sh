#!/bin/bash
#
# Install miniconda
#
cd ~
if [ ! -f ~/Miniconda3-latest-Linux-x86_64.sh ]; then
    echo "*****************************************************************************************"
    echo "* Installing Miniconda...                                                               *"
    echo "*****************************************************************************************"
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    chmod +x Miniconda3-latest-Linux-x86_64.sh
    #./Miniconda3-latest-Linux-x86_64.sh
fi
rm conda-python-libraries.txt 2>/dev/null
wget "${downloadUrlBase}/conda-python-libraries.txt"
~/miniconda3/condabin/conda install -c conda-forge --file conda-python-libraries.txt