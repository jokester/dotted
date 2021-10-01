#!/bin/bash

pkgpath=/var/cache/pacman/pkg

usage () {

  echo "
  usage:

  $0 <new_root> [ u | m | c | s ]+

  m > mount pacman package cache in current root into new_root
  u > umount cache
  c > arch-chroot into new_root
    # will fail unless you installed packages into it
  s > sync package cache into new_root${pkgpath_synced}
    # so you can rename it to new_root${pkgpath} afterwards
    # will use hardlink when possible
  "

  exit
}

if [ 2 -gt "$#" ];then
  usage
else
  root=$1
  [ -d "$root" ] || usage
  shift
  pkg_in_newroot=${root}${pkgpath}
  pkgsync_in_newroot=${pkg_in_newroot}2
  while [ "0" != $# ];do
    case $1 in
      u)
        umount $pkg_in_newroot -v
        ;;
      m)
        mkdir -p $pkg_in_newroot -v
        mount -o bind $pkgpath $pkg_in_newroot -v
        ;;
      c)
        arch-chroot $root
        ;;
      s)
        rm -rvf $pkgsync_in_newroot
        cp -lrT $pkg_in_newroot $pkgsync_in_newroot || cp -rvT $pkg_in_newroot $pkgsync_in_newroot
        ;;
    esac
    shift
  done
fi
