#!/bin/bash
#
# Script to download source, build and install latest build of eccodes
#
VERSION=$1
if [ -z "$VERSION" ]; then
    echo "Usage: build-eccodes.sh <version>"
    exit
fi
if [ ! "$VERSION" == "2.20.0" ]; then
    echo "Supported versions: 2.20.0"
    exit
fi
ECCODES=eccodes-${VERSION}

# Make sure required tools are available
sudo apt-get install -y gcc make cmake gfortran

# Delete old installations and source, and create new empty folders
rm -Rf ~/${ECCODES}-source
rm -Rf ~/${ECCODES}
mkdir ~/${ECCODES}-source
mkdir ~/${ECCODES}

# Go to source folder
cd ~/${ECCODES}-source

# Download source
wget  https://confluence.ecmwf.int/download/attachments/45757960/eccodes-${VERSION}-Source.tar.gz
tar -xvf eccodes-${VERSION}-Source.tar.gz

# Build and install
mkdir build ; cd build
cmake -DBUILD_SHARED_LIBS=ON -DCMAKE_INSTALL_PREFIX=~/${ECCODES} ../eccodes-${VERSION}-Source
make 
make install

# Setup environment in .bashrc if not found
COUNT=$(cat ~/.bashrc | grep "eccodes-${VERSION} support added by imbalance" | wc -l)
if [ $COUNT -eq 0 ]; then
    echo "Adding config to .bashrc..."
    echo "# eccodes-${VERSION} support added by imbalance" >>~/.bashrc
    echo "if [ -d ~/eccodes-${VERSION} ]; then" >>~/.bashrc
    echo "export PATH=~/eccodes-${VERSION}/bin:$PATH  # Make sure the tools are first in path" >>~/.bashrc
    echo "export ECCODES_DIR=~/eccodes-${VERSION} # Make Python use the latest build"
    echo "fi" >>~/.bashrc
    # Do it right now too:-)
    export PATH=~/eccodes-${VERSION}/bin:$PATH
    export ECCODES_DIR=~/eccodes-${VERSION}
fi
echo "Install done!"