#!/bin/bash

# Build Docker image
docker build -t nginx-bitmedia .

# Tag the image
docker tag nginx-bitmedia ${DOCKERHUB_USERNAME}/nginx-bitmedia

# Push the image to Docker Hub
docker push ${DOCKERHUB_USERNAME}/nginx-bitmedia