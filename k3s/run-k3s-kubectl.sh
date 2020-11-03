#!/usr/bin/env bash
set -ue
set -x
cd $(dirname "$0")
exec ./k3s-bin kubectl --kubeconfig="$PWD/kubeconfig.yaml" "$@"

