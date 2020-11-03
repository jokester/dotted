#!/usr/bin/env bash
set -ue
export K3S_URL='URL'
export K3S_TOKEN='TOKEN'
set -x
cd $(dirname "$0")
exec ./k3s-bin agent --data-dir="$PWD/k3s-data" --node-name="$HOSTNAME" --kubelet-arg=root-dir="$PWD/kubectl-data"

