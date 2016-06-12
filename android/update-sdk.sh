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

# --filter: Accepted values are: [add-on, doc, extra, platform, platform-tool, sample, source, system-image, tool]
exec tools/android update sdk --no-ui --all --filter extra,platform,platform-tool,tool,add-on

