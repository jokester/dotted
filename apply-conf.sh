#!/bin/bash
set -ue
cd "$(dirname "$0")"

link-dotfile () {
  for dotfile in "$@"; do
    local newfile="$HOME/.${dotfile:3}"

    # when $newfile not exist: just link it
    if [[ ! -e "$newfile" ]]; then
      ln -svf "$PWD/$dotfile" "$newfile"

    # when a symlink existed at $newfile, overwrite it
    elif [[ -h "$newfile" ]]; then
      if rm "$newfile" ; then
        ln -svf "$PWD/$dotfile" "$newfile"
      else
        echo -e "##### FAILED to remove symlink at $newfile \t\t#####"
      fi

    # otherwise, just report
    else
      echo -e "##### '$newfile' already exists and is not touched \t\t#####"
    fi
  done
}

link-dotfile DOT*
