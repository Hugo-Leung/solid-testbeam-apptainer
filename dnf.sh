#! /bin/bash
set -e 
microdnf update -y 
microdnf --enablerepo=crb install -y epel-release
/usr/bin/crb enable
microdnf --enablerepo=crb install -y $(cat /opt/packages)

microdnf clean all


