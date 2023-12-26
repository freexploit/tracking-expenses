#!/bin/bash 

export MANIFEST_NAME="tracking_expenses"

# Set the required variables
export BUILD_PATH="./"
export REGISTRY="registry.gitlab.com"
export USER="m0lok"
export IMAGE_NAME="tracking_expenses"
export IMAGE_TAG=$(git rev-parse --short HEAD)
#export IMAGE_TAG="root"

#buildah manifest create ${MANIFEST_NAME}

DOCKER_BUILDKIT=1 podman  build -f Dockerfile \
  --arch aarch64 \
  --manifest "${REGISTRY}/${USER}/${IMAGE_NAME}:${IMAGE_TAG}" 
  #--platform linux/aarch64 .

#podman manifest push "${REGISTRY}/${USER}/${IMAGE_NAME}:${IMAGE_TAG}" --format docker \
    #docker://"${REGISTRY}/${USER}/${IMAGE_NAME}:${IMAGE_TAG}" 



#amd64
#buildah bud \
    #--tag "${REGISTRY}/${USER}/${IMAGE_NAME}:${IMAGE_TAG}" \
    #--manifest ${MANIFEST_NAME} \
    #--arch amd64 \
    #${BUILD_PATH}

#arm64
#buildah bud \
    #--tag "${REGISTRY}/${USER}/${IMAGE_NAME}:${IMAGE_TAG}" \
    #--manifest ${MANIFEST_NAME} \
    #--arch aarch64 \
    #${BUILD_PATH}

#buildah manifest push --all \
    #${MANIFEST_NAME} \
    #"docker://${REGISTRY}/${USER}/${IMAGE_NAME}:${IMAGE_TAG}"
