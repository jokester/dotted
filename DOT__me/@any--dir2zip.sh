#!/bin/bash

if [[ $# != 1 ]]; then
  echo "USAGE: $0 <dir>"
else
  exec zip -rm0 "$1.zip" "$1"
fi
