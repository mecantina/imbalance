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
apt-get install -y libeccodes-dev gcc x11-apps
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
# Set X DISPLAY variable
#
cnt=$(cat ~/.bashrc | grep DISPLAY | wc -l)
if [ $cnt -eq 0 ]; then
    echo "*****************************************************************************************"
    echo "* Setting DISPLAY variable in .bashrc                                                   *"
    echo "*****************************************************************************************"
    wget "${downloadUrlBase}/export-display.sh"
    cat export-display.sh >>~/.bashrc
fi
#
# Installing python libraries
#
echo "*****************************************************************************************"
echo "* Installing python libraries...                                                        *"
echo "*****************************************************************************************"
wget "${downloadUrlBase}/python-libraries.txt"
~/miniconda3/bin/pip install -r python-libraries.txt
#
# Install the Azure CLI
#
if [ ! -f "/usr/bin/az" ]; then
    echo "*****************************************************************************************"
    echo "* Installing the Azure CLI...                                                           *"
    echo "*****************************************************************************************"
    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
fi