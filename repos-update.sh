#!/bin/bash

if [ $# -ne 2 ]; then
    echo "usage: $0 <rootpath> <branch>"
    exit 1
fi

root=$1
branch=$2

repos=" \
    poky \
    meta-openembedded \
    "

for repo in $repos; do
    echo "[INFO] Updating $repo to HEAD of $branch..."
    if [ ! -d $root/$repo ]; then
        echo "[ERROR] No such repo."
        exit 1
    fi
    pushd $root/$repo &> /dev/null
    git fetch origin
    git checkout origin/$branch -B $branch
    popd &> /dev/null
    echo "[INFO] Updated $repo"
done
