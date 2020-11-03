#!/usr/bin/env bash

set -ue
echo "install packages"
pacstrap              \
  -G -M -c            \
  -C /etc/pacman.conf \
  /mnt                \
  $(grep -v '^#' "$1")

cp pkglist_* /mnt/root -v
