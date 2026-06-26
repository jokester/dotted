#!/usr/bin/env bash
set -ue
cd "$(dirname "$0")"

# Default to a dry run; only mutate the filesystem when the 'apply'
# subcommand is given.
DRY_RUN=1
if [[ "${1:-}" == "apply" ]]; then
  DRY_RUN=0
fi

if [[ "$DRY_RUN" -eq 1 ]]; then
  echo "##### DRY RUN: no changes will be made. Re-run with 'apply' to link. #####"
fi

# Canonicalise a directory path portably (BSD/macOS lacks `realpath -m`).
# Returns empty if the directory does not exist.
abspath () {
  ( cd "$1" 2>/dev/null && pwd -P )
}

# Run a mutating command, or just print it when in dry-run mode.
run () {
  if [[ "$DRY_RUN" -eq 1 ]]; then
    echo "[dry-run] $*"
  else
    "$@"
  fi
}

# fix dir discarded by git
fix-permission () {
  run chmod 0700 DOTssh DOT__me DOTconfig DOTgnupg
  run chmod 0600 DOTssh/config
}

link-dotfile () {
  for dotfile in "$@"; do
    # Strip 'DOT' prefix; also strip a trailing '.override' so that
    # 'DOTzshrc.override' links to '~/.zshrc'.
    local target="${dotfile:3}"
    target="${target%.override}"
    local newfile="$HOME/.$target"

    local src="$PWD/$dotfile"

    # when $newfile not exist: just link it
    if [[ ! -e "$newfile" ]]; then
      run ln -svf "$src" "$newfile"

    # when a symlink existed at $newfile, overwrite it -- unless it already
    # points where we want, in which case leave it untouched.
    elif [[ -h "$newfile" ]]; then
      if [[ "$(readlink "$newfile")" == "$src" ]]; then
        : # already correct, nothing to do
      elif run rm "$newfile" ; then
        run ln -svf "$src" "$newfile"
      else
        echo -e "##### FAILED to remove symlink at $newfile \t\t#####"
      fi

    # otherwise, just report
    else
      echo -e "##### '$newfile' already exists and is not touched \t\t#####"
    fi
  done
}

unlink-removed () {
  for dotfile in __removed/DOT*; do
    [[ -e "$dotfile" || -h "$dotfile" ]] || continue
    local base="${dotfile##*/}"
    local target="${base:3}"
    target="${target%.override}"
    local newfile="$HOME/.$target"

    # only touch a symlink that points back into this repo (i.e. one an
    # earlier version of this script created). Canonicalise both sides so
    # that e.g. /home/mono -> /media/.../home-mono symlinks still match.
    if [[ -h "$newfile" ]]; then
      local destdir
      destdir="$(abspath "$(dirname "$(readlink "$newfile")")")"
      if [[ -n "$destdir" && "$destdir" == "$(abspath "$PWD")" ]]; then
        run rm -v "$newfile"
      fi
    fi
  done
}

fix-permission
unlink-removed

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
