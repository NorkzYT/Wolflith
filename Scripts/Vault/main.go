package main

import (
	"flag"
	"fmt"
	"os"

	vaultpull "github.com/NorkzYT/Wolflith/Scripts/Vault/vaultPull"
	vaultpush "github.com/NorkzYT/Wolflith/Scripts/Vault/vaultPush"
)

func main() {
	// Define a flag to specify the action
	action := flag.String("action", "", "Specify 'pull' to pull secrets, or 'push' to push secrets to Hashicorp Vault.")
	flag.Parse() // Parse the flags

	// Check if an action was provided
	if *action == "" {
		fmt.Println("You must specify an action using the -action flag.")
		os.Exit(1)
	}

	// Assume repoLocation is the path where your Docker configs or .env files are located.
	repoLocation := "/opt/Wolflith"

	switch *action {
	case "pull":
		fmt.Println("Pulling secrets...")
		vaultpull.PullSecrets(repoLocation)
	case "push":
		fmt.Println("Pushing secrets...")
		vaultpush.PushSecrets(repoLocation)
	default:
		fmt.Printf("Invalid action: %s. Use 'pull' or 'push'.\n", *action)
		os.Exit(1)
	}
}
