#!/bin/zsh

emulate -L zsh

set -e

cd $0:h

myTag=my-yatt-test1

if ! podman image exists $myTag; then
    podman build -f Dockerfile -t $myTag
fi

podman run -it --rm -p 5000:5000 \
       -v $PWD/public:/myapp/public:O \
       -v $PWD/ytmpl:/myapp/ytmpl:O \
       $myTag
