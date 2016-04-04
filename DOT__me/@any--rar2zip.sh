#!/bin/bash

set -ue

convert () {
  local rar="$1"
  local zip="${rar%.*}.zip"
  local ret=1
  local tempdir=$(mktemp -d)
  rm -rf "$zip"
  if unrar x -p- "$rar" "$tempdir/" &>/dev/null ; then
    if zip -0 -r -j "$zip" "$tempdir"/* &>/dev/null ; then
      echo "- OK $rar -> $zip"
      rm -rf "$tempdir"
      return 0
    else
      echo "X error creating $zip"
      rm -rf "$tempdir"
      return 1
    fi
  else
    echo "X error inflating $rar"
    rm -rf "$tempdir"
    return 2
  fi
}

for file in "$@"; do
  convert "$file" && rm -f "$file"
done
