#!/usr/bin/env bash
set -ue
set -x
cd $(dirname "$0")
exec ./k3s-bin server --disable-agent --data-dir="$PWD/k3s-data" --write-kubeconfig="$PWD/kubeconfig.yaml"
