#!/bin/bash

# Extract sensitive outputs if not already done
if [ ! -f talosconfig ]; then
    echo "Extracting talosconfig..."
    terraform output -raw talosconfig > talosconfig
fi

if [ ! -f kubeconfig ]; then
    echo "Extracting kubeconfig..."
    terraform output -raw kubeconfig > kubeconfig
fi

# Set environment variables
export TALOSCONFIG=$(pwd)/talosconfig
export KUBECONFIG=$(pwd)/kubeconfig

# Verify talosctl configuration
echo "Verifying talosctl configuration..."
talosctl config info

# Verify kubectl configuration
echo "Verifying kubectl configuration..."
kubectl get nodes
