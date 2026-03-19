#!/bin/bash
set -e 
cd /opt

git clone --branch latest-stable --depth=1 https://github.com/root-project/root.git root_src

cd root_src
mkdir build 
cd build
cmake -DCMAKE_INSTALL_PREFIX=/opt/root -DCMAKE_CXX_STANDARD="17"  -DLLVM_BUILD_TYPE="Release"  -Dafdsmgrd:BOOL="OFF" -Dafs:BOOL="OFF" -Dalien:BOOL="OFF" -Dasimage:BOOL="ON" -Dastiff:BOOL="ON" -Dbuiltin_afterimage:BOOL="OFF" -Dbuiltin_cfitsio:BOOL="OFF" -Dbuiltin_clang:BOOL="ON" -Dbuiltin_davix:BOOL="OFF" -Dbuiltin_fftw3:BOOL="ON" -Dbuiltin_freetype:BOOL="OFF" -Dbuiltin_ftgl:BOOL="OFF" -Dbuiltin_gl2ps:BOOL="OFF" -Dbuiltin_glew:BOOL="OFF" -Dbuiltin_gsl:BOOL="OFF" -Dbuiltin_llvm:BOOL="ON" -Dbuiltin_lzma:BOOL="OFF" -Dbuiltin_openssl:BOOL="OFF" -Dbuiltin_pcre:BOOL="OFF" -Dbuiltin_tbb:BOOL="ON" -Dbuiltin_unuran:BOOL="OFF" -Dbuiltin_vc:BOOL="OFF" -Dbuiltin_vdt:BOOL="ON" -Dbuiltin_veccore:BOOL="OFF" -Dbuiltin_xrootd:BOOL="OFF" -Dbuiltin_zlib:BOOL="OFF" -Dcastor:BOOL="OFF" -Dccache:BOOL="OFF" -Dchirp:BOOL="OFF" -Dcling:BOOL="ON" -Dcocoa:BOOL="OFF" -Dcuda:BOOL="OFF" -Dcudnn:BOOL="OFF" -Dcxxmodules:BOOL="OFF" -Ddataframe:BOOL="ON" -Ddavix:BOOL="OFF" -Ddcache:BOOL="OFF" -Dfail-on-missing:BOOL="OFF" -Dfftw3:BOOL="ON" -Dfitsio:BOOL="OFF" -Dfortran:BOOL="ON" -Dgdml:BOOL="ON" -Dgenvector:BOOL="ON" -Dgfal:BOOL="OFF" -Dgl2ps:BOOL="ON" -Dglite:BOOL="OFF" -Dglobus:BOOL="OFF" -Dgnuinstall:BOOL="OFF" -Dgviz="BOOL=ON" -Dhdfs:BOOL="OFF" -Dhttp:BOOL="ON" -Dimt:BOOL="ON" -Djemalloc:BOOL="OFF" -Dlibcxx:BOOL="OFF" -Dmathmore:BOOL="ON" -Dmonalisa:BOOL="OFF"  -Dopengl:BOOL="ON" -Doracle:BOOL="OFF" -Dpch:BOOL="ON"  -Dpyroot:BOOL="ON"  -Dpythia8:BOOL="ON" -Dqt5web:BOOL="OFF" -Dr:BOOL="ON" -Drfio:BOOL="OFF" -Droofit:BOOL="ON" -Droot7:BOOL="ON" -Drpath:BOOL="OFF" -Druntime_cxxmodules:BOOL="ON" -Dshadowpw:BOOL="ON" -Dshared:BOOL="ON" -Dsoversion:BOOL="ON" -Dspectrum:BOOL="ON" -Dsqlite:BOOL="ON" -Dssl:BOOL="ON" -Dtbb:BOOL="ON" -Dtcmalloc:BOOL="OFF" -Dtesting:BOOL="OFF" -Dthread:BOOL="ON" -Dtmva:BOOL="ON" -Dunuran:BOOL="ON" -Dvc:BOOL="OFF" -Dvdt:BOOL="ON" -Dveccore:BOOL="OFF" -Dvecgeom:BOOL="OFF" -Dwebgui:BOOL="ON" -Dx11:BOOL="ON" -Dxml:BOOL="ON" -Dxrootd:BOOL="ON" /opt/root_src

njobs=30
ncpu=$(nproc)
if [[ ${ncpu} -lt ${njobs} ]]; then
	njobs=${cpu}
fi
cmake --build . -- install -j${njobs}
cd /opt
rm -rf root_src
echo /opt/root/lib >> /etc/ld.so.conf
ldconfig
