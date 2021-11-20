#!/bin/bash
echo "See ceremcem/brightness-control-gui#1"
set -x

sudo ln -s /usr/lib/x86_64-linux-gnu/libxcb-util.so.0 /usr/lib/x86_64-linux-gnu/libxcb-util.so.1 \
    && echo "Problem should be fixed now."

