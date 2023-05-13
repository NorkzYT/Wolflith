#!/bin/bash

# Get the total memory usage of all Docker containers
total_memory_usage=$(docker container stats --no-stream --format '{{.MemUsage}}' | awk '{total += $1} END {print total}')

# Convert the total memory usage from bytes to megabytes
total_memory_usage_mb=$(echo "scale=2; $total_memory_usage / 1024 / 1024" | bc)

# Print the total memory usage
echo "Total memory usage: $total_memory_usage_mb MB"