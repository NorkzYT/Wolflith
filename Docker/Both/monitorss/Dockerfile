FROM ubuntu

# User will be root
USER root

# Runs the following installation commads
RUN apt-get update && apt-get install -y lsb-release && apt-get -y install curl

# Install docker 
# --------------------------------------------------------------------------------------

RUN apt-get -y install \
  ca-certificates \
  curl \
  gnupg \
  lsb-release

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

RUN echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list >/dev/null

RUN apt-get update
RUN apt-get -y --no-install-recommends install docker-ce docker-ce-cli containerd.io

# --------------------------------------------------------------------------------------

ADD binfmt-starter.sh /opt/app/binfmt-starter.sh
RUN mkdir -p /opt/app && chmod +x /opt/app/binfmt-starter.sh
WORKDIR /opt/app

# Forces the command to be executed during docker run. Read more here: https://shisho.dev/blog/posts/docker-cmd-entrypoint/
ENTRYPOINT ["./binfmt-starter.sh"]

# --------------------------------------------------------------------------------------
# https://github.com/prisma/prisma/issues/8478#issuecomment-1335444581
#
# Best DockerFile Practice:
# http://bitjudo.com/blog/2014/03/13/building-efficient-dockerfiles-node-dot-js/
# https://docs.docker.com/develop/develop-images/dockerfile_best-practices/
# https://docs.bitnami.com/tutorials/best-practices-writing-a-dockerfile
