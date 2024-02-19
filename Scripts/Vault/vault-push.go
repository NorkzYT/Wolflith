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

	secretData := make(map[string]interface{})

	dockerPath := filepath.Join(repoLocation, "Docker")

	err = filepath.Walk(dockerPath, func(path string, info os.FileInfo, err error) error {
		if err != nil {
			log.Printf("Prevent panic by handling failure accessing a path %q: %v\n", path, err)
			return err
		}

		if !info.IsDir() && strings.HasSuffix(info.Name(), ".env") {
			pushSecrets(path, client, secretData) // Pass the map by reference
		}

		return nil
	})
	if err != nil {
		log.Printf("Error walking the path %v: %v\n", dockerPath, err)
	}

	_, err = client.Logical().Write("kv/data/wolflith", map[string]interface{}{"data": secretData})
	if err != nil {
		log.Fatalf("Unable to push secret: %v", err)
	}

	fmt.Println("")
	fmt.Println("Finished pushing secrets to Vault.")
}

func pushSecrets(filename string, client *vault.Client, secretData map[string]interface{}) {
	data, err := ioutil.ReadFile(filename)
	if err != nil {
		log.Fatalf("Failed to open file: %v", err)
	}

	lines := strings.Split(string(data), "\n")

	for _, line := range lines {
		if !strings.HasPrefix(line, "#") && strings.Contains(line, "=") {
			parts := strings.SplitN(line, "=", 2)
			if len(parts) != 2 {
				log.Printf("Invalid line format: %s\n", line)
				continue
			}

			key := strings.TrimSpace(parts[0])
			value := strings.TrimSpace(parts[1])

			secretData[key] = value

			// Print the secret key without the value
			fmt.Println(strings.Repeat("-", 100))
			fmt.Printf("Added key: %s\n", key)
			fmt.Println(strings.Repeat("-", 100))
		}
	}
}
