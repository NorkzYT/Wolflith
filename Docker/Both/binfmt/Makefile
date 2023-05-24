DOCKER_USERNAME ?= norkz
APPLICATION_NAME ?= binfmt
GIT_HASH ?= $(shell git log --format="%h" -n 1)

### Comments ###

# To run this makefile, you need to have docker installed on your machine.
# Then you can run the following commands like the following:
# make $COMMAND

# Command names are listed below:

# --------------------------------------------------------------------------------------

docker-compose-build:
	docker-compose up -d --force-recreate

docker-build-binfmt:
	docker build -t norkz/binfmt-command-runner:1.0 -f Dockerfile .

# docker-hub-push:
# 	docker push ${DOCKER_USERNAME}/${APPLICATION_NAME}

# docker-hub-release:
# 	docker pull ${DOCKER_USERNAME}/${APPLICATION_NAME}:${GIT_HASH}
# 	docker tag  ${DOCKER_USERNAME}/${APPLICATION_NAME}:${GIT_HASH} ${DOCKER_USERNAME}/${APPLICATION_NAME}:latest
# 	docker push ${DOCKER_USERNAME}/${APPLICATION_NAME}:latest

# --------------------------------------------------------------------------------------
