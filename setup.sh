#!/bin/bash

set -eu

set -x

realScriptFn=$(readlink -f $0)

cd $(dirname $realScriptFn)

if ! which cpm; then
    curl -fsSL --compressed https://git.io/cpm > cpm; chmod +x cpm;
fi

PATH=.:$PATH cpm install
