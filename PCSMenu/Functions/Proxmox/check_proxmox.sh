#!/bin/bash

if ! pveversion &>/dev/null; then
    echo "This script needs to be run on a Proxmox VE system."
    exit 1
fi
