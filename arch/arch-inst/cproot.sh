#!/bin/bash

shopt -s extglob

echo "usage:
\$ $0 <root> <mountpoint>
will copy <root_base>/usr/<minimul files> to mountpoint
and compress <root>/usr as usr.sfs"
if [ "$1" -a -d "$1" ] && [ "$2" -a -d "$2" ] ;then
  root=$1
  mountpoint=$2
  cd $mountpoint
  mountpoint_abs=`pwd`
  cd -
  cp -av $root/!(usr) $mountpoint
  mkdir $mountpoint_abs/usr
  cd $root
  mksquashfs usr $mountpoint_abs/usr/usr.sfs -b 1048576 -processors 2 -comp xz

  echo "/usr/usr.sfs  /usr squashfs  defaults  0 0" >> $mountpoint_abs/etc/fstab
  cd -
else
  echo check ur args
fi
