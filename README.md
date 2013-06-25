# iSCSI Target

The purpose of this virtual machine is presenting a iSCSI LUN that can be from the host or from other virtual machines. 

## Pre-requisites
- Vagrant
- Virtualbox

## VM Details
Details of the virtual machine that will be installed after running `vagrant up`:
- OS: CentOS 6.4 x86\_64.
- CPU: 1 (1 core).
- RAM: 480 MB.
- Disks:
    + Root disk: 8GB.
    + Storage disk: 10GB (used as iSCSI backing storage).
- Private IP: 192.168.56.10
- LUN info:

```
LUN: 1
    Type: disk
    SCSI ID: IET     00010001
    SCSI SN: beaf11
    Size: 10733 MB, Block size: 512
    Online: Yes
    Removable media: No
    Prevent removal: No
    Readonly: No
    Backing store type: rdwr
    Backing store path: /dev/storage_vg/storage_lv
    Backing store flags:
```

## Usage
### Create the virtual machine:
```
$ cd vagrant-jumble/iscsi-target
$ vagrant up
```
### iSCSI Initiator
To connect a client (an *initiator*) to a iSCSI target:
1. The following packages need to be installed:
- RedHat/CentOS/Suse: iscsi-initiator-utils 
- Ubuntu/Debian: open-iscsi
2. Make sure that the `iscsi` service is running.
3. Before using a target you must discover it:

```
   $ iscsiadm -m discovery -t sendtargets -p 192.168.56.10
   192.168.56.10:3260,1 iqn.2013-06.lan.iscsi-storage:storage
```

4. Log in to the new iSCSI target:

```
   $ iscsiadm -m node -T iqn.2013-06.lan.iscsi-storage:storage -p 192.168.56.10 -l
   Logging in to [iface: default, target: iqn.2013-06.lan.iscsi-storage:storage, portal: 192.168.56.10,3260] (multiple)
   Login to [iface: default, target: iqn.2013-06.lan.iscsi-storage:storage, portal: 192.168.56.10,3260] successful.
```

5. To see the known targets run:

```
   $ sudo iscsiadm -m node
   192.168.56.10:3260,1 iqn.2013-06.lan.iscsi-storage:storage
```


