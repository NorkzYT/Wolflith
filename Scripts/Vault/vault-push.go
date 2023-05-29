package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"path/filepath"
	"strings"
	"syscall"

	vault "github.com/hashicorp/vault/api"
	"golang.org/x/crypto/ssh/terminal"
)

func main() {
	// Check if repository location is passed as an argument
	if len(os.Args) < 2 {
		log.Fatal("Repository location not provided. Usage: go run vault-push.go <repository location>")
	}

	repoLocation := os.Args[1] // Get the repository location

	config := vault.DefaultConfig()
	config.Address = "https://hashicorp-vault.domain.com"

	client, err := vault.NewClient(config)
	if err != nil {
		log.Fatalf("Unable to initialize Vault client: %v", err)
	}

	fmt.Println("")
	fmt.Println("Input username and password of your Hashicorp Vault")
	fmt.Print("Enter Username: ")
	var username string
	fmt.Scanln(&username)

	fmt.Print("Enter Password: ")
	bytePassword, err := terminal.ReadPassword(int(syscall.Stdin))
	if err != nil {
		log.Fatalf("Error reading password: %v", err)
	}
	password := string(bytePassword)

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

	dockerPath := filepath.Join(repoLocation, "Launchpad/Docker")

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

	_, err = client.Logical().Write("kv/data/NAME", map[string]interface{}{"data": secretData})
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
