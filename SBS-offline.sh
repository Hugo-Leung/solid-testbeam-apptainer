#!/bin/bash
set -e 
cd /opt

if  [[ -z "$ROOTSYS" ]]; then
	source /opt/root/bin/thisroot.sh
fi

export ANALYZER="/opt/analyzer"
export PATH=/opt/analyzer/bin:$PATH
export LD_LIBRARY_PATH=/opt/analyzer/lib64:$LD_LIBRARY_PATH

git clone --depth=1 https://github.com/JeffersonLab/SBS-replay_SOLIDtestbeam.git SBS-replay_SOLIDtestbeam
export SBS_REPLAY="/opt/SBS-replay_SOLIDtestbeam"
git clone --depth=1 https://github.com/JeffersonLab/SBS-offline_SOLIDtestbeam.git SBS-offline_SOLIDtestbeam-src
cd SBS-offline_SOLIDtestbeam-src
mkdir build 

njobs=5
ncpu=$(nproc)
if [[ ${ncpu} -lt ${njobs} ]]; then
	njobs=${cpu}
fi

cmake -B build -S . -DCMAKE_INSTALL_PREFIX=/opt/SBS-offline_SOLIDtestbeam
cmake --build build -j${njobs}
cmake --install build

sed -i -E "s/Rint\.Logon:[[:space:]]+rootlogon\.C/Rint.Logon: \/opt\/SBS-offline_SOLIDtestbeam\/etc\/rootlogon.C/g" /opt/root/etc/system.rootrc
tail -n4 /opt/SBS-offline_SOLIDtestbeam/run_replay_here/.rootrc >>  /opt/root/etc/system.rootrc
