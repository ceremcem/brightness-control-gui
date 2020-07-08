#!/bin/bash 

brightness_file="/sys/class/backlight/intel_backlight/brightness"
# You can use any group name you are already included.
# see `id` output.
group="${1:-brightness}"
 
echo "Using group name: $group"
# Create the new group if it doesn't exist:
if ! grep -q "^${group}:" /etc/group; then
    echo "Adding new group: $group"
    sudo addgroup $group
    sudo usermod -a -G $group `whoami`
    echo "Please do not logout and login to make this take effect."
fi

sudo chgrp $group "$brightness_file"
sudo chmod g+w "$brightness_file"

echo "Now you can directly write to the brightness file: "
echo
echo "    echo 100 > $brightness_file"
echo
