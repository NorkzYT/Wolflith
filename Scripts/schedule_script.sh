#!/bin/bash

# Run the command
echo "Running Schedule Script"

# Set the time when the script should be run
time="05:00" # (5:00 GMT | 21:00 PST | 24:00 EST)

# Set the path to the script that should be run
script_path="/home/user/Launchpad/example.sh"

# Schedule the script to be run at the specified time
echo "$script_path" | at "$time"

# ----------------------------------------------------------------------------------- #

# Use `atq` to see the jobs in the queue. Use `atrm` to remove a job from the queue.

# Example: use `at -c 3` to see the contents of job 3. Use `atrm 3` to remove job 3.

# Set the time when the script should be run
#time="12:23"                                  # Test time

# ----------------------------------------------------------------------------------- #
