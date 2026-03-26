#!/bin/bash

if [[ $# -lt 1 ]]; then
  echo "USAGE: $0 <dir>+"
  exit 1
fi

for d in "$@"; do
  if [[ -d "$d" ]] && ! [[ -e "$d.zip" ]]; then
    zip -rm0 "$d.zip" "$d"
  else
    echo "ERROR: $d"
  fi
done
