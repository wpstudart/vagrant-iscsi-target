#!/bin/bash

# The hard disk used for storage is (hopefully) on /dev/sdb
# TODO: use /dev/disk/by-id

if [ ! -e /dev/sdb1 ]; then
    # Create a label
    /sbin/parted /dev/sdb --script -- mklabel msdos
    # create partition (it takes the whole disk)
    /sbin/parted /dev/sdb --script -- mkpart primary 0 -1
    # set type lvm
    /sbin/parted /dev/sdb --script -- set 1 lvm on
    /sbin/parted /dev/sdb --script print

    # Create logical volume
    /sbin/pvcreate /dev/sdb1
    /sbin/vgcreate storage_vg /dev/sdb1
    /sbin/lvcreate -l 100%FREE -n storage_lv storage_vg
fi
