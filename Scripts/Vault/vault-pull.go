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
		log.Fatal("Repository location not provided. Usage: go run main.go <repository location>")
	}

	repoLocation := os.Args[1] // Get the repository location

	config := vault.DefaultConfig()
	config.Address = "https://hashicorp-vault.domain.com"

	client, err := vault.NewClient(config)
	if err != nil {
		log.Fatalf("Unable to initialize Vault client: %v", err)
	}

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

	dockerPath := filepath.Join(repoLocation, "Launchpad/Docker")

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
		log.Fatalf("Failed to open file: %v", err)
	}

	lines := strings.Split(string(data), "\n")

	for i, line := range lines {
		if strings.Contains(line, "${") && strings.Contains(line, "}") {
			start := strings.Index(line, "${") + 2
			end := strings.Index(line, "}")
			secretName := line[start:end]

			secretValues, err := client.Logical().Read(fmt.Sprintf("kv/data/NAME"))
			if err != nil {
				log.Fatalf("Unable to get secret: %v", err)
			}

			if secretValues != nil && secretValues.Data != nil {
				secretData, ok := secretValues.Data["data"].(map[string]interface{})
				if !ok {
					log.Fatalf("Unable to convert secret data to map")
				}

				value, ok := secretData[secretName].(string)
				if ok {
					lines[i] = secretName + "=" + value

					// Print the secret key
					fmt.Println(strings.Repeat("-", 100))
					log.Println(secretName+" has been pulled.")
					fmt.Println(strings.Repeat("-", 100))
				} else {
					log.Fatalf("Value type assertion failed: %T %#v", secretData[secretName], secretData[secretName])
				}
			} else {
				log.Fatalf("Secret not found at the specified path: %s", secretName)
			}
		}
	}

	output := strings.Join(lines, "\n")
	err = ioutil.WriteFile(filename, []byte(output), 0644)
	if err != nil {
		log.Fatalf("Failed to write to file: %v", err)
	}

}