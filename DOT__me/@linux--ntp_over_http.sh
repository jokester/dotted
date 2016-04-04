#!/bin/bash

# usage:
#   1. set date of localhost:
#     % $0
#   2. set date of remote host:
#     % $0 ssh HOST

httpdate="$(wget --no-cache -S -O /dev/null google.com 2>&1 \
  | perl -ne 's/^ +Date: // && print && exit 0 ;' )"

echo $httpdate
if [ -n "$httpdate" ] ; then
  echo Successfully fetched DATE=$httpdate
  if [ $# -gt 0 ] ;then
    # ssh whatever and set date
    "$@" "sudo date -s '$httpdate'"
  else
    # set local date
    sudo date -s "$httpdate"
  fi
fi
