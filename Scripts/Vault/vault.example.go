package main

import (
	"context"
	"fmt"
	"log"

	vault "github.com/hashicorp/vault/api"
)

func main() {
	config := vault.DefaultConfig()

	config.Address = "https://hashicorp-vault.domain.com"

	client, err := vault.NewClient(config)
	if err != nil {
		log.Fatalf("unable to initialize Vault client: %v", err)
	}

	// Authenticate
	// WARNING: This quickstart uses the root token for our Vault dev server.
	// Don't do this in production!
	client.SetToken("xxx")

	secretData := map[string]interface{}{
		"password": "Hashi123",
	}

	ctx := context.Background()

	// Write a secret
	_, err = client.KVv2("kv").Put(ctx, "testt", secretData)
	if err != nil {
		log.Fatalf("unable to write secret: %v", err)
	}

	log.Println("Secret written successfully.")

	// Read a secret
	secret, err := client.Logical().Read("kv/data/test")
	if err != nil {
		log.Fatalf("unable to read secret: %v", err)
	}

	if secret == nil || secret.Data == nil || secret.Data["data"] == nil {
		log.Fatalf("secret not found at the specified path")
	}

	secretDataMap, ok := secret.Data["data"].(map[string]interface{})
	if !ok {
		log.Fatalf("unable to convert secret data to map")
	}

	value, ok := secretDataMap["password"].(string)
	if !ok {
		log.Fatalf("value type assertion failed: %T %#v", secretDataMap["password"], secretDataMap["password"])
	}

	if value != "Hashi123" {
		log.Fatalf("unexpected password value %q retrieved from vault", value)
	}

	log.Println("Access granted!")

	// Print the secret value
	log.Println("Secret value:", value)

	// Print the full address
	secretPath := "kv/data/testt"
	fullAddress := fmt.Sprintf("%s/%s", config.Address, secretPath)
	log.Println("Full address:", fullAddress)
}
