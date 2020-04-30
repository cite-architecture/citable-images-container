#!/bin/sh

# Must be logged in to docker before running this.
#

docker push ${IMAGE_NAME}:latest

docker tag ${IMAGE_NAME}:latest ${IMAGE_NAME}:${MAJOR_VERSION}
docker push ${IMAGE_NAME}:${MAJOR_VERSION}

docker tag ${IMAGE_NAME}:latest ${IMAGE_NAME}:${MAJOR_VERSION}.${MINOR_VERSION}
docker push ${IMAGE_NAME}:${MAJOR_VERSION}.${MINOR_VERSION}

docker tag ${IMAGE_NAME}:latest ${IMAGE_NAME}:${MAJOR_VERSION}.${MINOR_VERSION}.${PATCH_VERSION}
docker push ${IMAGE_NAME}:${MAJOR_VERSION}.${MINOR_VERSION}.${PATCH_VERSION}
