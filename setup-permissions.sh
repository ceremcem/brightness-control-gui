#!/bin/bash 

echo "Changing brightness file permissions:"
for f in /sys/class/backlight/*; do 
    brightness_file="$f/brightness"
    echo "+ chmod 666 $brightness_file"
    sudo chmod 666 $brightness_file
done
echo "Done."

# You can directly write to the brightness file to change the brightness: 
#
#     echo 100 > $brightness_file
#
