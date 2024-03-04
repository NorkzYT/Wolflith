package vaultpush

import (
	"fmt"
	"log"
	"os"
	"path/filepath"
	"strings"

	vaultcommon "github.com/NorkzYT/Wolflith/Scripts/Vault/vaultCommon"
	vault "github.com/hashicorp/vault/api"
)

// PushSecrets reads .env files and pushes their contents as secrets to Vault.
func PushSecrets(repoLocation string) {
	// Load environment variables from the specified .env file
	envPath := "/opt/Wolflith/.env" // Specify the path to your .env file
	vaultcommon.LoadEnv(envPath)    // Call LoadEnv from vaultcommon

	// Initialize the Vault client using the InitVaultClient function from vaultcommon
	client := vaultcommon.InitVaultClient()

	secretData := make(map[string]interface{})
	dockerPath := filepath.Join(repoLocation, "Docker")

	err := filepath.Walk(dockerPath, func(path string, info os.FileInfo, err error) error {
		if err != nil {
			log.Printf("Prevent panic by handling failure accessing a path %q: %v\n", path, err)
			return err
		}

		if !info.IsDir() && strings.HasSuffix(info.Name(), ".env") {
			pushSecrets(path, client, secretData)
		}

		return nil
	})
	if err != nil {
		log.Printf("Error walking the path %v: %v\n", dockerPath, err)
	}

	_, err = client.Logical().Write("kv/data/Wolflith", map[string]interface{}{"data": secretData})
	if err != nil {
		log.Fatalf("Unable to push secret: %v", err)
	}

	fmt.Println("\nFinished pushing secrets to Vault.")
}

// pushSecrets processes a single .env file, adding its contents to a map for later pushing to Vault.
func pushSecrets(filename string, client *vault.Client, secretData map[string]interface{}) {
	data, err := os.ReadFile(filename)
	if err != nil {
		log.Printf("Failed to open file: %v", err)
		return
	}

	lines := strings.Split(string(data), "\n")
	for _, line := range lines {
		if !strings.HasPrefix(line, "#") && strings.Contains(line, "=") {
			parts := strings.SplitN(line, "=", 2)
			if len(parts) != 2 {
				log.Printf("Invalid line format: %s", line)
				continue
			}

			key := strings.TrimSpace(parts[0])
			value := strings.TrimSpace(parts[1])

			secretData[key] = value

			fmt.Println(strings.Repeat("-", 100))
			log.Printf("Key %s will be pushed to Vault.", key)
			fmt.Println(strings.Repeat("-", 100))
		}
	}
}
