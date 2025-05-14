#!/bin/zsh

emulate -L zsh

set -e

cd $0:h

code public/ &

exec google-chrome-stable http://localhost:5000/ -incognito &
