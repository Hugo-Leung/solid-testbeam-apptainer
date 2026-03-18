#!/bin/bash
set -e 
cd /opt

if  [[ -z "$ROOTSYS" ]]; then
	source /opt/root/bin/thisroot.sh
fi
export ANALYZER="/opt/analyzer"
export PATH=/opt/analyzer/bin:$PATH
export LD_LIBRARY_PATH=/opt/analyzer/lib64:$LD_LIBRARY_PATH

VERSION="main"

git clone --depth=1  --branch ${VERSION} https://github.com/JeffersonLab/panguin.git 

cd panguin
mkdir build 
cd build
cmake ../

njobs=5
ncpu=$(nproc)
if [[ ${ncpu} -lt ${njobs} ]]; then
	njobs=${cpu}
fi
cmake --build . -j${njobs}
make install
