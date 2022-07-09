# **FIX TO ORACLE CLOUD VPS Permission denied (publickey).**

The user changed the permissions for the `ubuntu` user to be open for all, which this not allowed.

If you did the following:

```
chmod -R 777 /home/ubuntu
```

Then you need to change it back to the following so you can sign in again to the VPS before you close the terminal and if you already closed it then you will need to restart a new instance with a new block of storage sadly. 

```
chmod -R 775 /home/ubuntu
```

Look at the following examples:

When you added the following:

![1](https://cdn.discordapp.com/attachments/979776565820932158/980856143872155738/unknown.png)

The main user, which is `ubuntu` is now open to all and that breaks the ability to SSH into the VPS, even if you try with another user you created.

Then when you try to log-into the VPS it will deny the private key immediately no matter what you do.

![2](https://user-images.githubusercontent.com/53381649/171026404-678aef28-c0d7-462f-86fe-5acc1e7cc9fa.png)

When you change it back to the correct permissions then the private key will be accepted and will let you SSH into the VPS again.
