#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "usage: $0 </path/kubeconfig.yaml>"
    exit
fi

export KUBECONFIG="${1}"
echo "${KUBECONFIG}"

# Print config
kubectl version --short
# kubectl config view

# Set cluster
kubectl config set-cluster local --insecure-skip-tls-verify=true

kubectl get nodes
