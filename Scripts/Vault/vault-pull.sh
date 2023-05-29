#!/bin/bash

# This script does the following:

#Prompts the user for a username and password and uses them to authenticate to Hashicorp Vault.
#Finds all .env.example files in the current directory and its subdirectories and creates a copy of each file with the name .env. If a .env file with the same name already exists, it will skip it and move on to the next file.
#Finds all .env files in the current directory and its subdirectories and reads their contents into an array, filtering out comments and empty lines.
#Loops through the array of environment variables and splits each one into a name and value field using the "=" character as a delimiter.
#For each name and value, the script checks if the variable is in Hashicorp Vault and retrieves its corresponding secret value.
#If the secret value is not "null" and the value field of the environment variable is an empty string, the script replaces the line in the .env file with the secret value from Vault. Otherwise, it does nothing.

# ------------------------------------------------------------------------------------------------------ #

# Ask for the repository location
echo "Please enter the Launchpad repository location: (E.g. /home/user/github)"
read repo_location

# Change to the repository location
cd $repo_location/Launchpad/Docker

# This command will find all .env.example files in the current directory and its subdirectories,
# and for each file it will check if a .env file with the same name already exists. If it doesn't,
# it will copy the contents of the .env.example file into a new .env file in the same folder.
# If the .env file does exist, it will ask if you want to overwrite it with the .env.example file.
# It also includes an 'A' option to overwrite all existing .env files without asking,
# and a 'S' option to skip all existing .env files without asking.
overwrite_all=''
find . -name "*.env.example" -exec sh -c 'for file; do
  env_file="${file%.env.example}.env"
  if [ ! -e "$env_file" ]; then
    cp "$file" "$env_file"
  else
    if [ -z "$overwrite_all" ]; then
      echo "\nDo you want to copy the contents of the $file to the existing $env_file? (y/n/A/S)\n"
      read answer
      if [ "$answer" = "A" ] || [ "$answer" = "a" ]; then
        echo "\nCopying contents of the .env.example files to all existing .env files\n"
        overwrite_all='y'
      elif [ "$answer" = "N" ] || [ "$answer" = "n" ]; then
        echo "\nSkipping the existing $env_file\n"
      elif [ "$answer" = "S" ] || [ "$answer" = "s" ]; then
        echo "\nSkipping all existing .env files\n"
        overwrite_all='n'
      fi
    fi
    if [ "$answer" = "Y" ] || [ "$answer" = "y" ]; then
        echo "\nCopied the contents to the .env file\n"
      cp "$file" "$env_file"
    fi
  fi
done' sh {} +

cd $repo_location/Launchpad/Scripts/Vault

go run main.go $repo_location

# ------------------------------------------------------------------------------------------------------ #
