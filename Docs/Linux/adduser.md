# **To create a new user account named username using the adduser command you would run:**

```
sudo adduser username
```

###### Output:

```
Adding user `username' ...
Adding new group `username' (1001) ...
Adding new user `username' (1001) with group `username' ...
Creating home directory `/home/username' ...
Copying files from `/etc/skel' ...
```

You will be asked a series of questions. The password is required, and all other fields are optional.

###### Output:

```
Enter new UNIX password:
Retype new UNIX password:
passwd: password updated successfully
Changing the user information for username
Enter the new value, or press ENTER for the default
	Full Name []:
	Room Number []:
	Work Phone []:
	Home Phone []:
	Other []:
Is the information correct? [Y/n]
```

Finally, confirm that the information is correct by entering Y.

The command will create the new user’s home directory, and copy files from /etc/skel directory to the user’s home directory.

Within the home directory, the user can write, edit, and delete files and directories.

By default on Ubuntu, members of the group sudo are granted with sudo access.

If you want the newly created user to have administrative rights, add the user to the sudo group :

```
sudo usermod -aG sudo username
```
