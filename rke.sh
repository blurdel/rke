#!/bin/bash

me=$(basename $0)
# echo "me=${me} $@"

if [[ $# -ne 1 ]]; then
    echo "usage ${me} <up|down>"
    sudo systemctl status rke2-server
    exit
fi

arg="${1}"

if [[ "${arg}" == "up" ]]; then
    echo "Starting rke2-server ..."
    sudo systemctl start rke2-server
elif [[ "${arg}" == "down" ]]; then
    echo "Stopping rke2-server ..."
    sudo systemctl stop rke2-server
else
    echo "Error: unknown arg: ${arg}"
fi
