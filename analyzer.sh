#!/bin/bash
set -e 
cd /opt

if  [[ -z "$ROOTSYS" ]]; then
	source /opt/root/bin/thisroot.sh
fi

VERSION="Release-1718"

git clone --depth=1  --branch ${VERSION} https://github.com/JeffersonLab/analyzer.git analyzer-src

cd analyzer-src

njobs=5
ncpu=$(nproc)
if [[ ${ncpu} -lt ${njobs} ]]; then
	njobs=${cpu}
fi
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/opt/analyzer ..
make -j${njobs} install


echo /opt/analyzer/lib64 >> /etc/ld.so.conf
ldconfig
