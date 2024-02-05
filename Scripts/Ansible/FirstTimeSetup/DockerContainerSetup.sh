#!/bin/bash

# ------------------------------------------------------------------------------------------------------------------------ #

# Runs the the following commands that will install and/or setup Docker Containers on each new machine.

# ------------------------------------------------------------------------------------------------------------------------ #

directory_location="$1"

scripts_path="$2"

# ------------------------------------------------------------------------------------------------------------------------ #

# WatchTower folder path

docker compose -f /$directory_location/Wolflith/Docker/Containers/WatchTower/docker-compose.yml up -d --force-recreate

# ----------------------------------------------------------------------------------------- #

# Allow the following TailscaleHostname.sh file to be executed.
chmod +x "$scripts_path/TailscaleHostname.sh"

# Bash script to get the hostname of the machine and replace the "hostname: VPS" line in docker-compose.yml with the actual hostname.
"$scripts_path/TailscaleHostname.sh" "$directory_location"

docker compose -f /$directory_location/Wolflith/Docker/Containers/Tailscale/docker-compose.yml up -d --force-recreate

# ----------------------------------------------------------------------------------------- #

# Compose the Syncthing container
docker compose -f /$directory_location/Wolflith/Docker/Containers/Syncthing/docker-compose.yml up -d --force-recreate

# Syncthing API
# https://docs.syncthing.net/dev/rest.html

# ----------------------------------------------------------------------------------------- #

# Compose the Portainer container
docker compose -f /$directory_location/Wolflith/Docker/Containers/Portainer/docker-compose.yml up -d --force-recreate

# ----------------------------------------------------------------------------------------- #

# Compose the Vscode container
docker compose -f /$directory_location/Wolflith/Docker/Containers/Vscode/docker-compose.yml up -d --force-recreate

# ----------------------------------------------------------------------------------------- #

# Compose the Authentik container
docker compose -f /$directory_location/Wolflith/Docker/Containers/Authentik/docker-compose.yml up -d --force-recreate

# ----------------------------------------------------------------------------------------- #

# Compose the Traefik container
docker compose -f /$directory_location/Wolflith/Docker/Containers/Traefik/docker-compose.yml up -d --force-recreate

# ----------------------------------------------------------------------------------------- #

# Compose the GitLab container
docker compose -f /$directory_location/Wolflith/Docker/Containers/GitLab/docker-compose.yml up -d --force-recreate

# ----------------------------------------------------------------------------------------- #

# Example
# docker compose -f /$directory_location/Wolflith/Docker/Containers/WireGuard/docker-compose.yml up -d --force-recreate

# # ...

# ----------------------------------------------------------------------------------------- #

# ------------------------------------------------------------------------------------------------------------------------ #
# ------------------------------------------------------------------------------------------------------------------------ #
