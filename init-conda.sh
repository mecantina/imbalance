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