package vaultcommon

import (
	"fmt"
	"log"
	"os"

	"github.com/hashicorp/vault/api"
	"github.com/joho/godotenv"
)

// LoadEnv loads environment variables from a specified .env file.
func LoadEnv(envPath string) {
	if err := godotenv.Load(envPath); err != nil {
		log.Fatalf("Error loading .env file: %v", err)
	}
}

// InitVaultClient initializes and returns a new Vault client, including logging in.
func InitVaultClient() *api.Client {
	vaultAddress := os.Getenv("HASHICORP_VAULT_ADDRESS")
	username := os.Getenv("HASHICORP_USER_NAME")
	password := os.Getenv("HASHICORP_PASSWORD")

	if vaultAddress == "" || username == "" || password == "" {
		log.Fatal("One or more required environment variables (HASHICORP_VAULT_ADDRESS, HASHICORP_USER_NAME, HASHICORP_PASSWORD) are not set")
	}

	config := api.DefaultConfig()
	config.Address = vaultAddress

	client, err := api.NewClient(config)
	if err != nil {
		log.Fatalf("Unable to initialize Vault client: %v", err)
	}

	fmt.Println("\nAttempting to log in...")

	// Perform userpass login
	path := fmt.Sprintf("auth/userpass/login/%s", username)
	options := map[string]interface{}{
		"password": password,
	}

	secret, err := client.Logical().Write(path, options)
	if err != nil {
		log.Fatalf("Unable to login with username and password: %v", err)
	}

	client.SetToken(secret.Auth.ClientToken)

	// Check if the client is authenticated
	if client.Token() == "" {
		log.Fatalf("Failed to authenticate with Vault")
	}

	fmt.Println("Successfully logged in to Vault.")

	return client
}
