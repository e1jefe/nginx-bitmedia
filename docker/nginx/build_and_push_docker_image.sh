#!/bin/bash

# Build Docker image
docker build . -t nginx-bitmedia

docker login --username ${DOCKERHUB_USERNAME} --password ${DOCKERHUB_ACCESS_TOKEN}
# Tag the image
docker tag nginx-bitmedia ${DOCKERHUB_USERNAME}/nginx-bitmedia

# Push the image to Docker Hub
docker push ${DOCKERHUB_USERNAME}/nginx-bitmedia