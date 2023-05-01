# Auto Execute Commands/Scripts During Reboot or Startup

- From the article: [How to Auto Execute Commands/Scripts During Reboot or Startup](https://www.tecmint.com/auto-execute-linux-scripts-during-reboot-or-startup/)

## Use /etc/rc.d/rc.local

This method is valid even for systemd-based distributions. In order for this method to work, you must grant execute permissions to `/etc/rc.d/rc.local` as follows:

```bash
chmod +x /etc/rc.d/rc.local
```

and add your script at the bottom of the file.

The following image shows how to run two sample scripts `(/home/gacanepa/script1.sh` and `/home/gacanepa/script2.sh)` using a cron job and rc.local, respectively, and their respective results.

script1.sh:

```bash
#!/bin/bash
DATE=$(date +'%F %H:%M:%S')
DIR=/home/gacanepa
echo "Current date and time: $DATE" > $DIR/file1.txt
```

script2.sh:

```bash
#!/bin/bash
SITE="Tecmint.com"
DIR=/home/gacanepa
echo "$SITE rocks... add us to your bookmarks." > $DIR/file2.txt
```

![rc.local](https://www.tecmint.com/wp-content/uploads/2017/02/Run-Linux-Commands-at-Startup.png)

Run Linux Scripts at Startup

Keep in mind that both scripts must be granted execute permissions previously:

```bash
chmod +x /home/gacanepa/script1.sh
chmod +x /home/gacanepa/script2.sh
```

## Executing Linux Scripts at Logon and Logout

To execute a script at logon or logout, use `~.bash_profile` and `~.bash_logout`, respectively. Most likely, you will need to create the latter file manually. Just drop a line invoking your script at the bottom of each file in the same fashion as before and you are ready to go.
