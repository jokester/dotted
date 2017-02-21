#!/bin/bash

set -ue

if [[ $# -eq 0 ]]; then
  echo "$0: generate md5 / sha1 / sha256 / sha512 sum of specified files"
  echo "USAGE: $0 [FILE]+"
  exit 1
fi

gen-checksums () {
  md5sum    "$@" > MD5SUM
  sha1sum   "$@" > SHA1SUM
  sha256sum "$@" > SHA256SUM
  sha512sum "$@" > SHA512SUM
}

time gen-checksums "$@"
