#!/bin/zsh

emulate -L zsh

set -e

cd $0:h

myTag=my-yatt-test1

podman build -f Dockerfile -t $myTag

podman run -it --rm -p 5000:5000 \
       -v $PWD/public:/myapp/public:O \
       $myTag
