#!/bin/bash
#
# Initialize an Ubuntu WLS 2 installation for the Imbalance project
# Script written to be rerunnable
#
downloadUrlBase="https://raw.githubusercontent.com/mecantina/imbalance-pub/main/"
#
# Get AE Root certificate and install
#
if [ ! -f /usr/local/share/ca-certificates/aeroot.crt ]; then
    echo "*****************************************************************************************"
    echo "* Installing AE Root certificate to trust store without certificate check...            *"
    echo "*****************************************************************************************"
    wget --no-check-certificate "${downloadUrlBase}/aeroot.crt"
    sudo cp aeroot.crt /usr/local/share/ca-certificates/
    sudo update-ca-certificates
fi
#
# Make python requests use the system ca-certificates bundle 
#
cnt=$(cat ~/.bashrc | grep REQUESTS_CA_BUNDLE | wc -l)
if [ $cnt -eq 0 ]; then
    echo "export REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt" >>~/.bashrc
    export REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
fi
#
# Update installation
#
echo "*****************************************************************************************"
echo "* Updating linux packages...                                                            *"
echo "*****************************************************************************************"
sudo apt -y update 
sudo apt -y upgrade
#
# Install eccodes, x11-apps
#
sudo apt-get install -y libeccodes-dev gcc x11-apps make
#
# Config GIT
#
if [ ! -f ~/.my-credentials ]; then
    echo "*****************************************************************************************"
    echo "* Configuring git...                                                                    *"
    echo "*****************************************************************************************"
    git config --global user.name "Imbalance Developer"
    git config --global user.email imbalance.developer@ae.no
    git config --global credential.helper 'store --file ~/.my-credentials'
fi
#
# Create source folder
#
if [ ! -d ~/source ]; then
    echo "*****************************************************************************************"
    echo "* Creating source folder...                                                             *"
    echo "*****************************************************************************************"
    mkdir ~/source
fi
#
# Install the Azure CLI
#
if [ ! -f "/usr/bin/az" ]; then
    echo "*****************************************************************************************"
    echo "* Installing the Azure CLI...                                                           *"
    echo "*****************************************************************************************"
    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
fi
#
# Set X DISPLAY variable
#
cnt=$(cat ~/.bashrc | grep DISPLAY | wc -l)
if [ $cnt -eq 0 ]; then
    echo "*****************************************************************************************"
    echo "* Setting DISPLAY variable in .bashrc                                                   *"
    echo "*****************************************************************************************"
    wget "${downloadUrlBase}/export-display.sh"
    cat export-display.sh >>~/.bashrc
    export DISPLAY="`grep nameserver /etc/resolv.conf | sed 's/nameserver //'`:0"
fi
#
# Install miniconda
#
if [ ! -d ~/miniconda3 ]; then
    echo "*****************************************************************************************"
    echo "* Installing Miniconda...                                                               *"
    echo "*****************************************************************************************"
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    chmod +x Miniconda3-latest-Linux-x86_64.sh
    ./Miniconda3-latest-Linux-x86_64.sh
fi
#
# Installing python libraries
#
echo "*****************************************************************************************"
echo "* Installing python libraries...                                                        *"
echo "*****************************************************************************************"
wget "${downloadUrlBase}/python-libraries.txt"
/home/haakon/miniconda3/condabin/conda install -c conda-forge --file python-libraries.txt
