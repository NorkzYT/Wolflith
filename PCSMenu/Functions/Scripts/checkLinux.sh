#!/bin/bash

if ! [[ "$(uname -s)" == "Linux" ]]; then
    echo "This script needs to be run on a Linux system."
    exit 1
fi
