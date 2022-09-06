# Shell info

List all shells available on your system:

```bash
cat /etc/shells
```

You can change your default shell using the chsh (“change shell” ) command as follows. The syntax is:

```bash
chsh
chsh -s {shell-name-here}
sudo chsh -s {shell-name-here} {user-name-here}
chsh -s /bin/bash
chsh -s /bin/bash vivek
```

More info here:

[Change Shell to Bash](https://www.cyberciti.biz/faq/how-to-change-shell-to-bash/)