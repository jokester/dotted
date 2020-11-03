#!/usr/bin/env bash

set -ue

DISK=$1

echo "proceeding will wipe $DISK"
echo "CTRL-c if you want to stop. enter to continue"
read

echo <<END
in fdisk:
create sda1 (256M) / sda2 (1G for swap) / sda3 (rest for rootfs)
END

fdisk $DISK

echo "CTRL-c if you want to stop. enter to continue"
read

set -x

BTRFS_MOUNT_OPTS="noatime,nodiratime,ssd,discard,compress=lzo"

# mkfs
mkfs.vfat ${DISK}1
mkswap ${DISK}2
mkfs.btrfs ${DISK}3

# prepare subvolumes
mount ${DISK}3 /mnt -o $BTRFS_MOUNT_OPTS
btrfs subvolume create /mnt/rootfs
btrfs subvolume create /mnt/home
mkdir /mnt/snapshots
umount /mnt

# mount disks and subvolumes
mount ${DISK}3 /mnt -o $BTRFS_MOUNT_OPTS,subvol=/rootfs
mkdir -pv /mnt/{boot,home,media/sdcard}
mount ${DISK}1 /mnt/boot
mount ${DISK}3 /mnt/home -o $BTRFS_MOUNT_OPTS,subvol=/home
mount ${DISK}3 /mnt/media/sdcard -o $BTRFS_MOUNT_OPTS,subvol=/
