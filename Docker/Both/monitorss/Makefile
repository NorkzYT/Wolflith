DOCKER_USERNAME ?= norkz
APPLICATION_NAME ?= Binfmt
GIT_HASH ?= $(shell git log --format="%h" -n 1)

### Comments ###

# To run this makefile, you need to have docker installed on your machine.
# Then you can run the following commands like the following:
# make $COMMAND

# Command names are listed below:

# --------------------------------------------------------------------------------------

help:
	@echo "\SCRIPTS\n"
	@echo "make github.contributors  	# pull a list of all contributors"
	@echo "make github.issues			# pull a list of all issue creators"
	@echo "make github.repos			# pull a list of our repos"
	@echo "make github.traction			# get a history of stargazers for our individual repos"

docker-compose-build:
	docker-compose up -d --force-recreate
 
docker-build-binfmt:
	DOCKER_BUILDKIT=1 docker build -t norkz/binfmt-command-runner:1.0 -f Dockerfile .


# docker-hub-release:
# 	docker pull ${DOCKER_USERNAME}/${APPLICATION_NAME}:${GIT_HASH}
# 	docker tag  ${DOCKER_USERNAME}/${APPLICATION_NAME}:${GIT_HASH} ${DOCKER_USERNAME}/${APPLICATION_NAME}:latest
# 	docker push ${DOCKER_USERNAME}/${APPLICATION_NAME}:latest

# --------------------------------------------------------------------------------------