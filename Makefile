.DEFAULT_GOAL := help

# const
IMAGE_NAME=jlab
CONTAINER_NAME=jlab
JUPYTER_PORT=8888

## build docker image
.PHONY: build
build:
	docker build -t ${IMAGE_NAME} --force-rm=true --no-cache -f docker/Dockerfile ./docker

## run docker container
.PHONY: run
run:
	docker run --gpus all --rm --name ${CONTAINER_NAME} --shm-size=2g -p ${JUPYTER_PORT}:8888 -v ${PWD}/src:/workspace -w /workspace -dit -e GRANT_SUDO=yes -e JUPYTER_ENABLE_LAB=yes -e NB_UID="$(id -u)" -e NB_GID="$(id -g)"  --user root ${IMAGE_NAME} jupyter-lab --allow-root --ip=0.0.0.0 --port=8888 --no-browser --NotebookApp.token='' --NotebookApp.password='' --notebook-dir=/workspace

## run bash in container
.PHONY: exec
exec:
	docker exec -w /workspace -it ${CONTAINER_NAME} bash

## help
.PHONY: help
help:
	@printf "\nusage : make <commands> \n\nthe following commands are available : \n\n"
	@cat $(MAKEFILE_LIST) | awk '1;/help:/{exit}' | awk '!/^.PHONY:.*/' | awk '/##/ { print; getline; print; }' | awk '{ getline x; print x; }1' | awk '{ key=$$0; getline; printf "\033[36m%-30s\033[0m %s\n", key, $$0;}' | sed -e 's/##//' | sed -e 's/://'
	@printf "\n"