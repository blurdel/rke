#!/bin/bash

# Save server yaml to ~/Downloads/local.yaml
# Set: KUBECONFIG=~/Downloads/local.yaml
# Run this script

echo "KUBECONFIG=${KUBECONFIG}"
if [[ -z "${KUBECONFIG}" ]]; then
    echo "KUBECONFIG is not set, exiting..."
    exit
fi
echo "KUBECONFIG=${KUBECONFIG}"


# Print some config items
kubectl version --short
# kubectl config get-clusters
# kubectl config view

# Our rke2 #.dev clusters are named local
# kubectl config set-cluster local --insecure-skip-tls-verify=true

kubectl get nodes
