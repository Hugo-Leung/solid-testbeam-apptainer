#!/bin/bash
set -e

BUILD_BASE=0
BUILD_REPLAY=0

while getopts "abrh" opt; do
	case "$opt" in
		a)
			echo "Build every thing"
			BUILD_BASE=1
			BUILD_REPLAY=1
			;;
		b)
			echo "Build base image"
			BUILD_BASE=1
			;;
		r)
			echo "Build replay image"
			BUILD_REPLAY=1
			;;
		?|h) 
			echo "Usage: $(basename $0) [-a] [-b] [-r]"
			exit 1
			;;
	esac
done

DEF_HASH=$(git rev-parse --short HEAD)

if [ "${BUILD_BASE}" -gt "0" ]; then
	apptainer build --build-arg DEF_HASH=${DEF_HASH} base.sif base.def
fi

if [ "${BUILD_REPLAY}" -gt "0" ]; then
	apptainer build --build-arg DEF_HASH=${DEF_HASH} testbeam.sif testbeam.def
fi

