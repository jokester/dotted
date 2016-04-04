#!/bin/bash

set -e -u -o pipefail

message () {
  local msg="$1"
  local filename="$2"
  echo "$msg  $filename"
}

check_zip () {
  local archive="$1"
  if which unzip &>/dev/null; then
    if unzip -t -qq "$archive" &>/dev/null ; then
      message "- OK" "$archive"
    else
      message "! FAIL" "$archive"
    fi
  else
    message "? SKIP" "$archive"
  fi
}

check_7z () {
  : # TODO
}

check_rar () {
  local archive="$1"
  if which unrar &>/dev/null; then
    if unrar t -p- "$archive" &>/dev/null ; then
      message "- OK" "$archive"
    else
      message "! FAIL" "$archive"
    fi
  else
    message "? SKIP" "$archive"
  fi
}

check_archive () {
  while [[ "$#" -gt 0 ]]; do
    local filename=$1
    shift
    local basename=$(basename "$filename")
    local extension=${filename##*.}
    case $extension in
      zip)
        check_zip "$filename"
        ;;
      rar)
        check_rar "$filename"
        ;;
      *)
        message "Q undefined extension<$extension>" "$filename"
        ;;
    esac
  done
}

check_archive "$@"
