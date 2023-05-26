#!/bin/sh

current_time=$(date +%H:%M)
start_time="00:00"
end_time="08:00"

if [ "$current_time" \< "$start_time" ] || [ "$current_time" \> "$end_time" ]; then
  echo "Current time is outside the desired range. Stopping container."
  cd /location/of/docker-compose.yml-file && docker compose down
else
  echo "Current time is within the desired range. Starting container."
  cd /location/of/docker-compose.yml-file && docker compose up -d --force-recreate
fi
