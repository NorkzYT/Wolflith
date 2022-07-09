If compose way then after you `docker-compose up -d` do the following:
```
 docker exec tailscale tailscale up --advertise-exit-node  ( Don't run )
 echo 'net.ipv4.ip_forward = 1' | sudo tee -a /etc/sysctl.conf
 echo 'net.ipv6.conf.all.forwarding = 1' | sudo tee -a /etc/sysctl.conf
 sudo sysctl -p /etc/sysctl.conf
```

Proxmox LXC issue:mknod: /dev/net/tun: Operation not permitted LXC:
I **fixed** this issue by allowing the LXC access to `/dev/tun` by the following:
```
On the proxmox HOST look in `/etc/pve/lxc/`, for the ID of the LXC you want to use Tailscale in. For example in my case LXC ID=100.
I would then edit `/etc/pve/lxc/100.conf` and add the following under what is already there:
```

```
lxc.cgroup.devices.allow: c 10:200 rwm
lxc.mount.entry: /dev/net/tun dev/net/tun none bind,create=file
```

This allows the container to have access to `/dev/tun`. In my case at least, this allows even an unprivileged LXC to run Tailscale.

( P.S. = The solutions were in my face but I thought you would run the command in the LXC Container and not in the actual `NODE` that is under the `DataCenter`. LOL )

To **Deploy Tailscale** run the following:
```
docker run -d --name=tailscaled -v /var/lib:/var/lib -v /dev/net/tun:/dev/net/tun --network=host --privileged --cap-add=net_admin --advertise-exit-node --hostname=tailscale tailscale/tailscale:latest tailscaled
```

To **LOGIN** run the following:
```
docker exec tailscaled tailscale up
```

To **CHECK STATUS** run the following:
```
docker exec tailscaled tailscale status
```

We recommend you use an auth key for an ephemeral node when using Tailscale in a container:
```
docker exec tailscaled tailscale up --authkey=$KEY
```

Oracle VPS:

```
Command: tailscale up --advertise-routes=10.0.0.0/16,169.254.169.254/32 --accept-dns=false --accept-routes
```

For Proxmox:
```
Command: tailscale up --advertise-routes=192.168.1.0/24 --accept-dns=true  --accept-routes
```

Configure tailscale with MagicDNS on the Proxmox host with
```
tailscale up --accept-dns=true.
```

https://tailscale.com/kb/1019/subnets/
https://tailscale.com/kb/1133/proxmox/installing-tailscale-within-an-lxc
https://tailscale.com/kb/1018/acls/auto-approvers-for-routes-and-exit-nodes
