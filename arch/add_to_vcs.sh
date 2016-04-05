#!/bin/bash
while [ $# -gt 0 ];do
  ln -sfv "$1" this_root/"$1"
  cp -fv "$1" template/"$1"
  shift
done
