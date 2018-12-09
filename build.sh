#!/bin/bash

source name

docker build -t $DOCKER_USER_NAME/$DOCKER_IMAGE_NAME:latest .
