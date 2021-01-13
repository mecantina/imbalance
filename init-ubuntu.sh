#!/bin/bash
#
# Initialize an Ubuntu WLS 2 installation for the Imbalance project
#
downloadUrlBase="https://raw.githubusercontent.com/mecantina/imbalance-pub/main/"
#
# Get AE Root certificate and install
#
echo "Installing AE Root certificate to trust store without certificate check..."
wget --no-check-certificate "${downloadUrlBase}/aeroot.crt"
sudo cp aeroot.crt /usr/local/share/ca-certificates/
sudo update-ca-certificates
#
# Update installation
#
echo "Updating linux packages..."
sudo apt -y update 
sudo apt -y upgrade
#
# Install miniconda
#
echo "Installing Miniconda..."
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod +x Miniconda3-latest-Linux-x86_64.sh
./Miniconda3-latest-Linux-x86_64.sh
#
# Installing python libraries
#
wget "${downloadUrlBase}/python-libraries.txt"
~/miniconda/bin/pip install -r requirements.txt
