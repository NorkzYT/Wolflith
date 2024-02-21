package vaultpull

import (
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"path/filepath"
	"strings"

	vaultcommon "github.com/NorkzYT/Wolflith/Scripts/Vault/vaultCommon"
	vault "github.com/hashicorp/vault/api"
)

// PullSecrets pulls secrets from Vault and updates .env files within the Docker directory.
func PullSecrets(repoLocation string) {
	envPath := "/opt/Wolflith/.env" // Specify the path to your .env file
	vaultcommon.LoadEnv(envPath)    // Call LoadEnv from vaultcommon

	// Initialize the Vault client using the InitVaultClient function from vaultcommon
	client := vaultcommon.InitVaultClient()

	dockerPath := filepath.Join(repoLocation, "Docker")

	err := filepath.Walk(dockerPath, func(path string, info os.FileInfo, err error) error {
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

	fmt.Println("\nFinished pulling all secrets from Vault.")
}

// replaceSecrets reads a .env file, replaces secrets with values from Vault, and writes the changes back to the file.
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

			secretValues, err := client.Logical().Read("kv/data/Wolflith")
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
					log.Printf("%s has been updated with a new secret value.", varName)
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
