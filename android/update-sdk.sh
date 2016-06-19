#!/bin/bash
set -e

if [[ -d "$ANDROID_HOME" ]]; then
  cd "$ANDROID_HOME"
elif [[ -x "$(dirname "$0")/tools/android" ]]; then
  cd "$(dirname "$0")"
else
  echo "FAILED: Cannot find ANDROID_HOME/tools/android"
  exit 1
fi

android () {
  "$(dirname $0)/tools/android" "$@"
}

function install_sdk {
  android update sdk -u -s -a -t "$1"
}

function fetch_package_indices {
  android list sdk -u -s -e         \
    | grep '^id:'                   \
    | cut -d'"' -f2                 \
    | grep -v 'source'              \
    | grep -v 'sys-img'             \
    | grep -v 'doc'                 \
    | paste -d, -s -
}

main () {
  (while : ; do
  echo 'y'
  sleep 1
  done) | android update sdk -u -s -a -t "$(fetch_package_indices)"
}

main
