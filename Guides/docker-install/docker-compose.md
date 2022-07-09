# Docker and Compose installation

```
sudo -i

apt-get update && apt-get upgrade

apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
    
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  
apt-get update

apt-get install docker-ce docker-ce-cli containerd.io

apt-cache madison docker-ce

sudo curl -L "https://github.com/docker/compose/releases/download/v2.5.1/docker-compose-linux-aarch64" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

sudo usermod -aG docker $USER                       # Add myself to the docker group.

sudo chgrp docker /usr/local/bin/docker-compose     # Give docker-compose to docker group.

sudo chmod 750 /usr/local/bin/docker-compose        # Allows docker group users to execute it.

docker version

docker-compose version
```

## To make a docker network

```
docker network create $NAME
```

### Docker/compose releases:

https://docs.docker.com/release-notes/

https://github.com/docker/compose/releases