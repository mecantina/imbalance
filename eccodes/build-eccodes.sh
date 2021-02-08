#!/bin/bash
#
# Script to download source, build and install latest build of eccodes
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

rm -Rf ~/${ECCODES}-source
rm -Rf ~/${ECCODES}
mkdir ~/${ECCODES}-source
mkdir ~/${ECCODES}
cd ~/${ECCODES}-source
wget  https://confluence.ecmwf.int/download/attachments/45757960/eccodes-${VERSION}-Source.tar.gz
tar -xvf eccodes-${VERSION}-Source.tar.gz
mkdir build ; cd build
cmake -DBUILD_SHARED_LIBS=ON -DCMAKE_INSTALL_PREFIX=~/${ECCODES} ../eccodes-${VERSION}-Source
make 
make install

