#!/bin/bash
set -ue
snapshot_path=/snapshots/
date="$(date '+%Y%m%d-%H%M%S-%N')"
btrfs subvolume snapshot -r /     "$snapshot_path/root-$date"
btrfs subvolume snapshot -r /home "$snapshot_path/home-$date"
