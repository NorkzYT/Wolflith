# Steps to add SSH key to any Linux machine with 1password

First make your 1password ssh key and then download both the `public` and `private` key.

![Imgur](https://i.imgur.com/SWjr1OW.png)

Install and run WinSCP to copy both the public and private key into any folder on your Linux machine. I put my keys in `/home/norkz` and move the files with the following commands to the `/root/ .ssh` folder.

```
mv /home/USER/id_ed25519.pub /root/.ssh/
mv /home/USER/id_ed25519 /root/.ssh/
```

Now use the following command

```
ssh-copy-id your-user@your-server-dns-name-or-ipv4-here
```

Now you are able to use the 