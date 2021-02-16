#!/bin/bash
#
# Script to download source, build and install latest build of Metview
#
VERSION=$1
if [ -z "$VERSION" ]; then
    echo "Usage: build-metview.sh <version>"
    exit
fi
if [ ! "$VERSION" == "5.10.1" ]; then
    echo "Supported versions: 5.10.1"
    exit
fi
METVIEW=Metview-${VERSION}

# Make sure required tools are available
sudo apt-get install -y gcc make cmake gfortran flex bison libgdbm-dev qt5-default libnetcdf-dev magic

# Download and install qt5





# Delete old installations and source, and create new empty folders
rm -Rf ~/${METVIEW}-source
rm -Rf ~/${METVIEW}
mkdir ~/${METVIEW}-source
mkdir ~/${METVIEW}

# Go to source folder
cd ~/${METVIEW}-source

# Download source
wget --no-check-certificate https://confluence.ecmwf.int/download/attachments/3964985/Metview-${VERSION}-Source.tar.gz
tar -xvf Metview-${VERSION}-Source.tar.gz

# Build and install
mkdir build ; cd build
cmake -DBUILD_SHARED_LIBS=ON -DCMAKE_INSTALL_PREFIX=~/${METVIEW} ../Metview-${VERSION}-Source
make 
make install

# Setup environment in .bashrc if not found
COUNT=$(cat ~/.bashrc | grep "Metview-${VERSION} support added by imbalance" | wc -l)
if [ $COUNT -eq 0 ]; then
    echo "Adding config to .bashrc..."
    echo "# Metview-${VERSION} support added by imbalance" >>~/.bashrc
    echo "if [ -d ~/Metview-${VERSION} ]; then" >>~/.bashrc
    echo "export PATH=~/Metview-${VERSION}/bin:\$PATH  # Make sure the tools are first in path" >>~/.bashrc
    echo "fi" >>~/.bashrc
fi
echo "Deleting source..."
#rm -Rf ~/${METVIEW}-source
echo "Install done!"