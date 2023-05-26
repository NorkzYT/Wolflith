#!/bin/bash

#####################################################################################################################################################################

### Docker Container Total Memory Allocation ###

#####################################################################################################################################################################

# Exit immediately if a command exits with a non-zero status.
# Treat unset variables as an error when substituting.
# Any command in a pipeline that fails will cause the whole pipeline to fail.
set -euoC pipefail

server_name=$(hostname)

# Function to display a waiting message
wait() {
    i=0
    spinner='1234567890'
    while true; do
        printf "\r${spinner:$i:1}"
        i=$((i + 1))
        if ((i == ${#spinner})); then
            i=0
        fi
        sleep 0.5
    done
}

# Start the waiting message
wait &

# Save the PID of the waiting function
WAIT_PID=$!

# Get the total memory amount
mem_amount_total_with_unit=$(docker system info |
    grep 'Total Memory: ' |
    tr -d 'Total Memory: ')

# Get the unit of the total memory amount
unit=$(echo ${mem_amount_total_with_unit} |
    sed 's/[0-9\.]*//g')

# Get the total memory amount without the unit
mem_amount_total=$(echo ${mem_amount_total_with_unit} |
    sed 's/[^0-9\.]*//g')

# Get the total memory usage percentage
mem_percent_used=$(docker stats --no-stream --format '{{.MemPerc}}' |
    tr -d '%' |
    paste -s -d '+' - |
    bc)

# Set the default value of mem_percent_used to 0
mem_percent_used=${mem_percent_used:-0}

# Get the total memory usage
mem_amount_used=$(echo "scale=2; ${mem_amount_total} * ${mem_percent_used} / 100" |
    bc)

difference=$(echo "scale=2; ${mem_amount_total} - ${mem_amount_used}" | bc)

# Stop the waiting message
kill $WAIT_PID

printf "\n"
printf "\n--------------------------------------------------------------------------------\n"
echo "                                                                     |||"
echo "Printing the total memory usage of all Docker containers of ${server_name}. vvv"
printf "\n"

# Print the total memory usage
echo "Total Memory amount on ${server_name} is: ${mem_amount_total}${unit}"
echo "Total Docker Memory usage on ${server_name} is: ${mem_amount_used}${unit}"
echo "Total Percent Used on ${server_name} is: ${mem_percent_used}%"
echo "There is ${difference}${unit} of memory left on ${server_name}."
