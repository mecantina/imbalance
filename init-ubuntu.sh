#!/bin/bash
#
# Initialize an Ubuntu WLS 2 installation for the Imbalance project
#
downloadUrlBase="https://raw.githubusercontent.com/mecantina/imbalance-pub/main/"
#
# Get AE Root certificate and install
#
if [ ! -f /usr/local/share/ca-certificates/aeroot.crt ]; then
    echo "Installing AE Root certificate to trust store without certificate check..."
    wget --no-check-certificate "${downloadUrlBase}/aeroot.crt"
    sudo cp aeroot.crt /usr/local/share/ca-certificates/
    sudo update-ca-certificates
fi
#
# Update installation
#
echo "Updating linux packages..."
sudo apt -y update 
sudo apt -y upgrade
#
# Install eccodes
#
apt-get install -y libeccodes-dev gcc
#
# Install miniconda
#
if [ ! -d ~/miniconda3 ]; then
    echo "Installing Miniconda..."
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    chmod +x Miniconda3-latest-Linux-x86_64.sh
    ./Miniconda3-latest-Linux-x86_64.sh
fi
#
# Set X DISPLAY variable
#
cnt=$(cat ~/.bashrc | grep DISPLAY | wc -l)
if [ $cnt -eq 0 ]; then
    wget "${downloadUrlBase}/export-display.sh"
    cat export-display.sh >>~/.bashrc
fi
#
# Install X11 apps
#
sudo apt install x11-apps
#
# Installing python libraries
#
wget "${downloadUrlBase}/python-libraries.txt"
~/miniconda3/bin/pip install -r python-libraries.txt

