#!/bin/bash
set -e 
cd /opt


VERSION="v6.36.10.Linux-almalinux9.7-x86_64-gcc11.5"

wget https://root.cern/download/root_${VERSION}.tar.gz

tar -xzf root_${VERSION}.tar.gz
rm root_${VERSION}.tar.gz

echo /opt/root/lib >> /etc/ld.so.conf
ldconfig
