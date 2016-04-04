#!/bin/bash
set -u
cd "$(dirname "$0")"

link-dotfile () {
  for dotfile in "$@"; do
    local newfile="$HOME/.${dotfile:3}"
    if [[ ! -e "$newfile" ]]; then
      ln -svf "$PWD/$dotfile" "$newfile"
    elif [[ -h "$newfile" ]]; then
      if rm -v "$newfile" ; then
        ln -svf "$PWD/$dotfile" "$newfile"
      fi
    else
      echo "'$newfile' already exists"
    fi
  done
}

link-dotfile DOT*
