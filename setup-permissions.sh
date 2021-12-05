#!/bin/bash 

brightness_file="/sys/class/backlight/intel_backlight/brightness"
set -x
sudo chmod 666 $brightness_file
set +x

echo "Now you can directly write to the brightness file: "
echo
echo "    echo 100 > $brightness_file"
echo
