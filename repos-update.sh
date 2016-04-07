#!/bin/bash

if [ $# -ne 2 ]; then
    echo "usage: $0 <rootpath> <version>"
    exit 1
fi

root=$1
version=$2

repos=" \
    poky \
    meta-openembedded \
    meta-raspberrypi \
    "

for repo in $repos; do
    echo "[INFO] Updating $repo to HEAD of $version..."
    if [ ! -d $root/$repo ]; then
        echo "[ERROR] No such repo."
        exit 1
    fi
    pushd $root/$repo &> /dev/null
    git fetch origin
    git checkout origin/$version -B $version
    popd &> /dev/null
    echo "[INFO] Updated $repo"
done