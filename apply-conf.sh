#!/bin/bash
set -u
cd "$(dirname "$0")"

link-dotfile () {
  for dotfile in "$@"; do
    local newfile="$HOME/.${dotfile:3}"

    # when $newfile not exist: just link it
    if [[ ! -e "$newfile" ]]; then
      ln -svf "$PWD/$dotfile" "$newfile"

    # when a symlink existed at $newfile, overwrite it
    elif [[ -h "$newfile" ]]; then
      if rm -v "$newfile" ; then
        ln -svf "$PWD/$dotfile" "$newfile"
      fi

    # otherwise, just report
    else
      echo "#########################################################"
      echo "##### '$newfile' already exists and is not touched"
      echo "#########################################################"
    fi
  done
}

link-dotfile DOT*
