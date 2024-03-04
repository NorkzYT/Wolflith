#!/bin/sh

current_time=$(date +%H:%M)
start_time="00:00"
end_time="08:00"

if [ "$current_time" ] <"$start_time" || [ "$current_time" ] >"$end_time"; then
  echo "Current time is outside the desired range. Stopping container."
  cd /opt/wolflith/Docker/Both/discordchatexporter/docker-compose.yml && docker compose down
else
  echo "Current time is within the desired range. Starting container."
  cd /opt/wolflith/Docker/Both/discordchatexporter/docker-compose.yml && docker compose up -d --force-recreate
fi
