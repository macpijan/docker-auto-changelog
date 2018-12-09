#!/bin/bash

source name.sh

docker build -t $DOCKER_USER_NAME/$DOCKER_IMAGE_NAME:latest .
