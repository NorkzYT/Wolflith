import os
from ruamel.yaml import YAML

# Ask for Launchpad repository location
repo_path = input("Enter Launchpad repository location: (e.g. /home/ubuntu/github)")

# Check if the location exists
if not os.path.isdir(repo_path):
    print(f"Directory {repo_path} does not exist.")
    exit(1)

# Append "/Launchpad" to the repo_path if not already present
if not repo_path.endswith("/Launchpad"):
    repo_path = os.path.join(repo_path, "Launchpad")

# Create a new ruamel.yaml instance
ruamel_instance = YAML()
ruamel_instance.indent(sequence=4, offset=2)

# Define the path for the output file
output_file = os.path.join(repo_path, "error_messages.txt")

# Find docker-compose.yml files in the 'Docker/Both/' location inside the repo
with open(output_file, "w") as output_f:
    for root, dirs, files in os.walk(os.path.join(repo_path, "Docker")):
        for file in files:
            if file == "docker-compose.yml":
                full_path = os.path.join(root, file)

                # Load YAML
                with open(full_path) as f:
                    data = ruamel_instance.load(f)

                for service, attributes in data["services"].items():
                    if "environment" in attributes:
                        new_env = []
                        env_example = []

                        # Check if .env.example exists and load the values
                        env_example_path = os.path.join(root, ".env.example")
                        env_example_dict = {}
                        env_example_lines = []
                        if os.path.exists(env_example_path):
                            with open(env_example_path, "r") as f:
                                env_example_lines = f.readlines()
                            env_example_lines = [line.strip() for line in env_example_lines]
                            env_example_dict = dict(line.split('=') for line in env_example_lines if '=' in line)

                        for env in attributes["environment"]:
                            # Check if environment variable follows KEY=VALUE format
                            if '=' not in env:
                                error_message = f"In {full_path}, environment variable in service '{service}' does not follow KEY=VALUE format: '{env}'. Please modify it.\n"
                                output_f.write(error_message)
                                continue

                            # Handle environment variables with multiple '=' signs
                            parts = env.split('=')
                            if len(parts) != 2:
                                error_message = f"In {full_path}, environment variable in service '{service}' does not follow KEY=VALUE format: '{env}'. Please modify it.\n"
                                output_f.write(error_message)
                                continue

                            key, value = parts

                            # Check if the key has the hostname prefix already
                            if f"{service.upper()}_" not in key:
                                new_key = f"{service.upper()}_{key}".replace("-", "_")
                            else:
                                new_key = key

                            new_env.append(f"{key}=${{{new_key}}}")

                            # Check if this key exists in the .env.example file already
                            if new_key in env_example_dict:
                                # Update the value in the .env.example file
                                env_example_dict[new_key] = value
                            else:
                                # Add a new entry to the .env.example file
                                env_example_dict[new_key] = value

                        # Only update 'environment' if we've added something to 'new_env'
                        if new_env:
                            attributes["environment"] = new_env

                        # Update the lines in the .env.example file
                        env_example_lines = [f"{key}={value}" if value else f"{key}=" for key, value in env_example_dict.items()]

                        # Write the updated .env.example content back to the file
                        with open(env_example_path, "w") as f:
                            f.write("\n".join(env_example_lines))

                # Save the new data back to the docker-compose.yml
                with open(full_path, "w") as f:
                    ruamel_instance.dump(data, f)

print("Environment variables have been extracted to .env.example files and replaced in docker-compose.yml files.")
print(f"Error messages have been saved to {output_file}.")
