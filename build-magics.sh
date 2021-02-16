#!/bin/bash
#
# Script to download source, build and install latest build of Magics
#
VERSION=$1
if [ -z "$VERSION" ]; then
    echo "Usage: build-magics.sh <version>"
    exit
fi
if [ ! "$VERSION" == "4.5.3" ]; then
    echo "Supported versions: 4.5.3"
    exit
fi
MAGICS=Metview-${VERSION}

# Make sure required tools are available
sudo apt-get install -y gcc make cmake gfortran  libnetcdf-dev proj proj-bin proj-bin-dbgsym proj-data libproj-dev libproj19 libproj19-dbgsym libsdl-pango-dev expat






# Delete old installations and source, and create new empty folders
rm -Rf ~/${MAGICS}-source
rm -Rf ~/${MAGICS}
mkdir ~/${MAGICS}-source
mkdir ~/${MAGICS}

# Go to source folder
cd ~/${MAGICS}-source


# Download source
wget --no-check-certificate https://confluence.ecmwf.int/download/attachments/3473464/Magics-${VERSION}-Source.tar.gz
tar -xvf Magics-${VERSION}-Source.tar.gz

# Build and install
mkdir build ; cd build
cmake ../Magics-${VERSION}-Source
make 
make install

# Setup environment in .bashrc if not found
COUNT=$(cat ~/.bashrc | grep "Magics-${VERSION} support added by imbalance" | wc -l)
if [ $COUNT -eq 0 ]; then
    echo "Adding config to .bashrc..."
    echo "# Magics-${VERSION} support added by imbalance" >>~/.bashrc
    echo "if [ -d ~/Metview-${VERSION} ]; then" >>~/.bashrc
    echo "export PATH=~/Magics-${VERSION}/bin:\$PATH  # Make sure the tools are first in path" >>~/.bashrc
    echo "fi" >>~/.bashrc
fi
echo "Deleting source..."
#rm -Rf ~/${MAGICS}-source
echo "Install done!"