#!/bin/bash

##### Only for `DockerFile` docker command runner. #####

# Command below will only run once the container starts, else it will not run again.

CONTAINER_ALREADY_STARTED="CONTAINER_ALREADY_STARTED_PLACEHOLDER"
if [ ! -e $CONTAINER_ALREADY_STARTED ]; then
    touch $CONTAINER_ALREADY_STARTED
    echo "-- First container startup --"
    # YOUR_JUST_ONCE_LOGIC_HERE_BELOWb
    docker run -d --privileged --rm tonistiigi/binfmt --install all
    echo "-- Cross-platform emulator collection installed! --"
else
    echo "-- Not first container startup --"
fi