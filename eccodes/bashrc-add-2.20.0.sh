# eccodes-2.20.0 support added by imbalance
if [ -d ~/eccodes-2.20.0 ]; then
        # Make sure the tools are first in path 
        export PATH=~/eccodes-2.20.0/bin:$PATH
        # Make Python use the latest build
        export ECCODES_DIR=~/eccodes-2.20.0
fi