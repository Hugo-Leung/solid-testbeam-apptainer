#!/bin/bash
set -e 
cd /opt

git clone --branch latest-stable --depth=1 https://github.com/root-project/root.git root_src

cd root_src
mkdir build 
cd build
cmake  -S /opt/root_src -DCMAKE_INSTALL_PREFIX=/opt/root \
       -DLLVM_BUILD_TYPE="Release" \
       -DCMAKE_CXX_STANDARD="20" \
       -Dgnuinstall:BOOL=OFF \
       -Dbuiltin_cfitsio:BOOL=OFF \
       -Dbuiltin_davix:BOOL=OFF \
       -Dbuiltin_fftw3:BOOL=OFF \
       -Dbuiltin_freetype:BOOL=OFF \
       -Dbuiltin_ftgl:BOOL=OFF \
       -Dbuiltin_gl2ps:BOOL=OFF \
       -Dbuiltin_glew:BOOL=OFF \
       -Dbuiltin_gsl:BOOL=OFF \
       -Dbuiltin_clang:BOOL=ON \
       -Dbuiltin_llvm:BOOL=ON \
       -Dbuiltin_lzma:BOOL=OFF \
       -Dbuiltin_nlohmannjson:BOOL=ON \
       -Dbuiltin_openssl:BOOL=OFF \
       -Dbuiltin_openui5:BOOL=ON \
       -Dbuiltin_pcre:BOOL=OFF \
       -Dbuiltin_tbb:BOOL=OFF \
       -Dbuiltin_unuran:BOOL=OFF \
       -Dbuiltin_vc:BOOL=OFF \
       -Dbuiltin_vdt:BOOL=ON \
       -Dbuiltin_veccore:BOOL=OFF \
       -Dbuiltin_xrootd:BOOL=OFF \
       -Dbuiltin_xxhash:BOOL=OFF \
       -Dbuiltin_zeromq:BOOL=OFF \
       -Dbuiltin_zlib:BOOL=OFF \
       -Dbuiltin_zstd:BOOL=OFF \
       -Dafdsmgrd:BOOL=OFF \
       -Dasimage:BOOL=ON \
       -Dastiff:BOOL=ON \
       -Dccache:BOOL=OFF \
       -Dcling:BOOL=ON \
       -Dcocoa:BOOL=OFF \
       -Droot7:BOOL=ON \
       -Dcuda:BOOL=OFF \
       -Dcudnn:BOOL=OFF \
       -Ddataframe:BOOL=ON \
       -Ddavix:BOOL=OFF \
       -Ddcache:BOOL=OFF \
       -Dfcgi:BOOL=OFF \
       -Dfftw3:BOOL=ON \
       -Dfitsio:BOOL=OFF \
       -Dfortran:BOOL=ON \
       -Dgdml:BOOL=ON \
       -Dgenvector:BOOL=ON \
       -Dgfal:BOOL=OFF \
       -Dgl2ps:BOOL=ON \
       -Dgviz=BOOL=ON \
       -Dhttp:BOOL=ON \
       -Dimt:BOOL=ON \
       -Dlibcxx:BOOL=OFF \
       -Dmathmore:BOOL=ON \
       -Dmlp:BOOL=ON \
       -Dopengl:BOOL=ON \
       -Doracle:BOOL=OFF \
       -Dpch:BOOL=ON \
       -Dpythia8:BOOL=OFF \
       -Dpyroot:BOOL=ON \
       -Dqt6web:BOOL=ON \
       -Dr:BOOL=OFF \
       -Drfio:BOOL=OFF \
       -Droofit:BOOL=ON \
       -Druntime_cxxmodules:BOOL=OFF \
       -Dshadowpw:BOOL=ON \
       -Dshared:BOOL=ON \
       -Dsoversion:BOOL=ON \
       -Dspectrum:BOOL=ON \
       -Dsqlite:BOOL=ON \
       -Dssl:BOOL=ON \
       -Dtbb:BOOL=ON \
       -Dtcmalloc:BOOL=OFF \
       -Dthread:BOOL=ON \
       -Dtmva:BOOL=ON \
       -Dunfold:BOOL=ON \
       -Dunuran:BOOL=ON \
       -Dvc:BOOL=OFF \
       -Dvdt:BOOL=ON \
       -Dveccore:BOOL=OFF \
       -Dvecgeom:BOOL=OFF \
       -Dwebgui:BOOL=ON \
       -Dx11:BOOL=ON \
       -Dxml:BOOL=ON \
       -Dxrootd:BOOL=ON \
       -Dfail-on-missing:BOOL=OFF \
       -Dtesting:BOOL=OFF \
       -DPython3_EXECUTABLE=/usr/bin/python3.14 \





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
