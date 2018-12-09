#!/bin/bash

source name

echo "$DOCKERHUB_PASSWORD" | docker login -u "$DOCKERHUB_USER" --password-stdin
docker push $DOCKER_USER_NAME/$DOCKER_IMAGE_NAME
