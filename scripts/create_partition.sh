#!/bin/bash

# The hard disk used for storage is (hopefully) on /dev/sdb
# TODO: use /dev/disk/by-id

if [ ! -e /dev/sdb1 ]; then
    # Create a label
    sudo parted /dev/sdb --script -- mklabel msdos
    # create partition (it takes the whole disk)
    sudo parted /dev/sdb --script -- mkpart primary 0 -1
    # set type lvm
    sudo parted /dev/sdb --script -- set 1 lvm on
    sudo parted /dev/sdb --script print

    # Create logical volume
    sudo pvcreate /dev/sdb1
    sudo vgcreate storage_vg /dev/sdb1
    sudo lvcreate -l 100%FREE -n storage_lv storage_vg
fi
