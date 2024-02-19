package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"path/filepath"
	"strings"

	"github.com/joho/godotenv"

	vault "github.com/hashicorp/vault/api"
)

func main() {

	envPath := "/opt/wolflith/.env"
	if err := godotenv.Load(envPath); err != nil {
		log.Fatalf("Error loading .env file: %v", err)
	}
	
    vaultAddress := os.Getenv("HASHICORP_VAULT_ADDRESS")
    if vaultAddress == "" {
        log.Fatal("HASHICORP_VAULT_ADDRESS not set in .env file")
    }

    username := os.Getenv("HASHICORP_USER_NAME")
    if username == "" {
        log.Fatal("HASHICORP_USER_NAME not set in .env file")
    }

    password := os.Getenv("HASHICORP_PASSWORD")
    if password == "" {
        log.Fatal("HASHICORP_PASSWORD not set in .env file")
    } 

	// Setting the repository location to '/opt/wolflith' directly
	repoLocation := "/opt/wolflith"

    config := vault.DefaultConfig()
    config.Address = vaultAddress  

    client, err := vault.NewClient(config)
    if err != nil {
        log.Fatalf("Unable to initialize Vault client: %v", err)
    }

    fmt.Println("\nAttempting to log in...")

    options := map[string]interface{}{
        "password": password,
    }

	path := fmt.Sprintf("auth/userpass/login/%s", username)

	secret, err := client.Logical().Write(path, options)
	if err != nil {
		log.Fatalf("Unable to login with username and password: %v", err)
	}

	client.SetToken(secret.Auth.ClientToken)

	// Check if the client is authenticated
	if client.Token() == "" {
		log.Fatalf("Failed to authenticate with Vault")
	}

	fmt.Println("\nLogged in!")
	fmt.Println("")

	dockerPath := filepath.Join(repoLocation, "Docker")

	err = filepath.Walk(dockerPath, func(path string, info os.FileInfo, err error) error {
		if err != nil {
			log.Printf("Prevent panic by handling failure accessing a path %q: %v\n", path, err)
			return err
		}

		if !info.IsDir() && strings.HasSuffix(info.Name(), ".env") {
			replaceSecrets(path, client)
		}

		return nil
	})
	if err != nil {
		log.Printf("Error walking the path %v: %v\n", dockerPath, err)
	}

	fmt.Println("")
	fmt.Println("Finished pulling all secrets from Vault.")
}

func replaceSecrets(filename string, client *vault.Client) {
	data, err := ioutil.ReadFile(filename)
	if err != nil {
		log.Printf("Failed to open file: %v", err)
		return
	}

	lines := strings.Split(string(data), "\n")
	for i, line := range lines {
		parts := strings.SplitN(line, "=", 2)
		if len(parts) == 2 {
			varName := strings.TrimSpace(parts[0])

			secretValues, err := client.Logical().Read("kv/data/wolflith")
			if err != nil {
				log.Printf("Unable to get secret for %v: %v", varName, err)
				continue
			}

			if secretValues != nil && secretValues.Data != nil {
				secretData, ok := secretValues.Data["data"].(map[string]interface{})
				if !ok {
					log.Printf("Invalid secret data format for: %s", varName)
					continue
				}

				if value, ok := secretData[varName]; ok {
					valueStr, ok := value.(string)
					if !ok {
						log.Printf("Invalid type for %s: got %T, want string", varName, value)
						continue
					}

					lines[i] = varName + "=" + valueStr
					fmt.Println(strings.Repeat("-", 100))
					log.Println(varName + " has been pulled.")
					fmt.Println(strings.Repeat("-", 100))
				}
			}
		}
	}

	output := strings.Join(lines, "\n")
	err = ioutil.WriteFile(filename, []byte(output), 0644)
	if err != nil {
		log.Printf("Failed to write to file: %v", err)
	}
}
