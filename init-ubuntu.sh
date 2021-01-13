#!/bin/bash
#
# Initialize an Ubuntu WLS 2 installation for the Imbalance project
#
downloadUrlBase="https://raw.githubusercontent.com/mecantina/imbalance-pub/main/"
#
# Get AE Root certificate and install
wget "${downloadUrlBase}/aeroot.crt"
