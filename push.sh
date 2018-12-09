#!/bin/bash

source name.sh

# create version tag
docker tag $DOCKER_USER_NAME/$DOCKER_IMAGE_NAME:latest $DOCKER_USER_NAME/$DOCKER_IMAGE_NAME:$CURRENT_VERSION

echo "$DOCKERHUB_PASSWORD" | docker login -u "$DOCKERHUB_USER" --password-stdin
docker push $DOCKER_USER_NAME/$DOCKER_IMAGE_NAME:latest
docker push $DOCKER_USER_NAME/$DOCKER_IMAGE_NAME:$CURRENT_VERSION
