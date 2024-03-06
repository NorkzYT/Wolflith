#!/bin/bash
######################################################################
# Title   : PCSMenu
# By      : NorkzYT
# License : General Public License GPL-3.0-or-later
######################################################################

source /opt/Wolflith/PCSRustMenu/src/PersonalizationFunc.sh

DOCKER_FOLDER="/opt/Wolflith/Docker"

blueprint "Scanning for Docker services in $DOCKER_FOLDER..."

# Initialize arrays for different architectures
declare -a amd64_services
declare -a arm64_services
declare -a both_services

# Populate arrays based on architecture
while IFS= read -r -d '' file; do
    relative_path="${file#"$DOCKER_FOLDER"/}" # Get the relative path from DOCKER_FOLDER
    relative_dir=$(dirname "$relative_path")  # Get the directory path without the filename
    if [[ "$file" == *"/AMD64/"* ]]; then
        amd64_services+=("$relative_dir")
    elif [[ "$file" == *"/ARM64/"* ]]; then
        arm64_services+=("$relative_dir")
    elif [[ "$file" == *"/Both/"* ]]; then
        both_services+=("$relative_dir")
    fi
done < <(find "$DOCKER_FOLDER" -mindepth 3 -type f -name 'docker-compose.yml' -print0)

# Sort the arrays alphabetically and remove duplicates
mapfile -t amd64_services < <(printf '%s\n' "${amd64_services[@]}" | sort -u)
mapfile -t arm64_services < <(printf '%s\n' "${arm64_services[@]}" | sort -u)
mapfile -t both_services < <(printf '%s\n' "${both_services[@]}" | sort -u)

# Combine arrays
services=("${amd64_services[@]}" "${arm64_services[@]}" "${both_services[@]}")

if [ ${#services[@]} -eq 0 ]; then
    redprint "No Docker services found."
    exit 1
fi

echo ""
blueprint "Available Docker services:"

# Define maximum columns
max_columns=4
current_column=0

for i in "${!services[@]}"; do
    # Prepare the service name with its index
    service_display="$((i + 1))) ${services[$i]}"

    # Print the service name, padded to ensure alignment
    printf "%-40s" "$service_display"

    # Increment the current column count
    ((current_column++))

    # Check if we need to move to a new line
    if [ "$current_column" -eq $max_columns ]; then
        echo ""          # Move to a new line
        current_column=0 # Reset column count
    fi
done

# If the last line was not completed, add a newline for clean prompt display
if [ $current_column -ne 0 ]; then
    echo ""
fi

echo ""
cyanprint "Select the Docker service to install (number): "
read -rp "" selection
if ! [[ "$selection" =~ ^[0-9]+$ ]] || [ "$selection" -lt 1 ] || [ "$selection" -gt ${#services[@]} ]; then
    redprint "Invalid selection. Exiting."
    exit 2
fi

selected_service="${services[$selection - 1]}"
selected_service_basename=$(basename "$selected_service")
selected_service_path="$DOCKER_FOLDER/${selected_service}"
greenprint "You selected: $selected_service"
echo "$selected_service_basename" >/opt/Wolflith/Temp/selected_docker_service.txt
echo "$selected_service_path" >/opt/Wolflith/Temp/selected_docker_service_path.txt
