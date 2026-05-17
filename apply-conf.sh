#!/usr/bin/env bash
set -ue
cd "$(dirname "$0")"

# fix dir discarded by git
fix-permission () {
  chmod 0700 DOTssh DOT__me DOTconfig DOTgnupg DOTweechat
  chmod 0600 DOTssh/config
}

link-dotfile () {
  for dotfile in "$@"; do
    # Strip 'DOT' prefix; also strip a trailing '.override' so that
    # 'DOTzshrc.override' links to '~/.zshrc'.
    local target="${dotfile:3}"
    target="${target%.override}"
    local newfile="$HOME/.$target"

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

fix-permission

# Build the link set: skip *.template, and prefer DOTfoo.override over DOTfoo
# when both exist (the .override entry will be linked in as ~/.foo).
files=()
for f in DOT*; do
  case "$f" in
    *.template) continue ;;
  esac
  if [[ "$f" != *.override && -e "$f.override" ]]; then
    continue
  fi
  files+=("$f")
done

if [[ ${#files[@]} -gt 0 ]]; then
  link-dotfile "${files[@]}"
fi
