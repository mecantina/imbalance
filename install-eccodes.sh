#!/bin/bash
#
# Script to download and install latest build of eccodes
#
VERSION=$1
if [ -z "$VERSION" ]; then
    echo "Usage: install-eccodes.sh <version>"
    exit
fi
if [ ! "$VERSION" == "2.20.0" ]; then
    echo "Supported versions: 2.20.0"
    exit
fi
ECCODES=eccodes-${VERSION}

# Check if already installed; remove if needed
if [ -d ~/${ECCODES} ]; then
    echo "Removing existing installation of ${ECCODES}..."
    rm -Rf ~/${ECCODES}
fi

# Download and expand the library
echo "Downloading eccodes..."
cd ~; wget https://raw.githubusercontent.com/mecantina/imbalance-pub/main/eccodes/dist/${ECCODES}.tar
cd ~; tar -xvf ~/eccodes-2.20.0.tar
rm ~/eccodes-2.20.0.tar

# Add library location and PATH if needed
COUNT=$(cat ~/.bashrc | grep "eccodes-2.20.0 support added by imbalance" | wc -l)
if [ $COUNT -eq 0 ]; then
    echo "Adding config to .bashrc..."
    if [ -f ~/bashrc-add-${VERSION}.sh ]; then
        rm ~/bashrc-add-${VERSION}.sh
    fi
    cd ~; wget https://raw.githubusercontent.com/mecantina/imbalance-pub/main/eccodes/bashrc-add-${VERSION}.sh
    cat ~/bashrc-add-${VERSION}.sh >>~/.bashrc
    rm ~/bashrc-add-${VERSION}.sh
fi

