# Guide to Automate Git in Vscode

We will be able to pull, commit/push/pull changes on save and do many more things.

First we need to create a bash script, luckly for you I already made one for you to use.

```
#!/bin/bash

#####################################################################################################################################################################


### Exit code after 4 seconds. ###

function exit_cmd() {
    
    printf "\n" ; echo "Exiting..." ; sleep 4 ; exit 0

}

#####################################################################################################################################################################

echo "________________________________________________________________________________________"

# Git repositories location

cd /Location/To/Git/Repositories                           # Change to folder where all github repositories are located at.

# store the current dir
CUR_DIR=$(pwd)

# Let the person running the script know what's going on.
echo "Pulling in latest changes for all repositories..."
printf "\n"

# Find all git repositories and update it to the master latest revision
for i in $(find . -name ".git" | cut -c 3-); do
    echo "";
    echo ""+$i+"";

    # We have to go to the .git parent directory to call the pull command
    cd "$i";
    cd ..;

    printf "\n"

    # finally pull, stage, commit and push.
                            
    # Have a file called: ".git-credentials" and it will contain the credentials of every Repository you have: "https://GITHUB-USERNAME:passwordORAccessToken@github.com/USERNAME/REPOSITORY.git"                         
    git config --global credential.helper store --file=/location/to/.git-credentials   

    # If necessary:
    #git config --global --add safe.directory /locations/to/repositories
    #git config user.name "github-user";     # Change to Github Username
    #git config user.email github@email.com; # Change to Github Email

    git pull origin;

    sleep 1;

    git stage .;

    sleep 1;

    git commit -m "Auto Commit";                    # "Auto Commit" is the message of the commit.

    sleep 1;

    git push origin;
    printf "\n\n"

    # lets get back to the CUR_DIR
    cd $CUR_DIR
done

echo "Complete!"

exit_cmd
```

After setting up the bash script, we now need to install the following extensions in Vscode:

[multi-Command](https://marketplace.visualstudio.com/items?itemName=ryuta46.multi-command),
[Save and Run Ext](https://marketplace.visualstudio.com/items?itemName=padjon.save-and-run-ext),
[Code Runner](https://marketplace.visualstudio.com/items?itemName=formulahendry.code-runner), &
[Command Runner](https://marketplace.visualstudio.com/items?itemName=edonet.vscode-command-runner).

Now let's go into the `settings.json` file of Vscode. To get there fast, you just need to click on `Ctrl+P` keys and then paste in `settings.json` and click on the file to open it.

Add the following in your `settings.json` file:

Remember to change the Locations and don't remove the `*`, it needs to be there.

```
"files.autoSaveDelay": 1000,
"code-runner.showExecutionMessage": true,                              // Shows [Running] $FILE -&- [Done] $ARG $TIME seconds.
"code-runner.customCommand": "/Location/To/File/Git-Automations.sh",  // Code-Runner customCommand that runs the Bash/Script.
"code-runner.preserveFocus": false,                                  // To preserve focus on code editor after code run is triggered.

"multiCommand.commands": [{
    "command": "$leep",												
    "label": "$leep",											   // Name of the command.
    "description":"Sleep/Delay of $SECONDS before script runs.", // Description.
    "interval": 30000,                  // Sleep only works with the following. Both the argument command and the interval need to be the same value or it won't work.
    "sequence": [ 
        {
            "command": "command-runner.run",      // Vscode runs command and then the argument that is listed.
            "args": { "command": "Sleep 30" }
        }
    ]
},
{
    "command": "killSleepTerminal",												
    "label": "killSleepTerminal",				 // Name of the command.
    "description":"Kills the sleep terminal.",	// Description.
    "sequence": [ 
        "workbench.action.terminal.kill"
    ]
},
{                 
    "command": "closeTerminal",             
    "label": "closeTerminal",						// Name of the command.
    "description":"Closes the terminal-panel.",    // Description.
    "sequence": [
        "workbench.action.closePanel"		
    ]
    
}
],
"saveAndRunExt": {

    "commands": [ 	// Commands run in order.
        {
            "match": "/Location/To/All/Github/Repositories*",
            "isShellCommand": false,
            "cmd": "$leep"
        },
        {
            "match": "/Location/To/All/Github/Repositories*",
            "isShellCommand": false,
            "cmd": "killSleepTerminal"	
        },
        {
            "match": "/Location/To/All/Github/Repositories*",
            "isShellCommand": false,
            "cmd": "code-runner.runCustomCommand"

        },
        {
            "match": "/Location/To/All/Github/Repositories*",
            "isShellCommand": false,
            "cmd": "closeTerminal"
        }
    ]
},
"command-runner.terminal.name": "runCommand(s)",
"command-runner.terminal.autoClear": false,		  // Auto-clear the terminal once command is finished.
"command-runner.terminal.autoFocus": false,		// Auto-focus of terminal.
"command-runner.commands": {
    "Sleep 15": "sleep 15",					 // "$NAME": "$COMMAND",
    "Sleep 30": "sleep 30"				   // "$NAME": "$COMMAND"

},
"command-runner.terminal.cwd": "/Location/Path/To/Where/Terminal/Will/Be/Executed/At"  // Terminal path the command will run in.
```

If the `saveAndRunExt` is off then just click `Ctrl+P` and type in the following:

`>extension.saveAndRunExt.enable` and click `Enter`.

That is all.