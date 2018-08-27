#!/bin/bash
DOCKER_ID_USER="blablalines"
DOCKER_IMAGE_NAME="dotnet-runtime"

tag="$1"

[[ x"${tag}" == x ]] && {
    echo "Please give a tag for the new docker image built"
    exit 255
}

# Login to docker account
echo Fill-in pasword for $DOCKER_ID_USER docker user
docker login -u $DOCKER_ID_USER
if [ $? -ne 0 ]; then
	echo Login failed!
	exit
fi

# Build docker image
docker build -t $DOCKER_IMAGE_NAME .

# Tag docker image
docker tag $DOCKER_IMAGE_NAME:latest $DOCKER_ID_USER/$DOCKER_IMAGE_NAME:${tag}

# Push docker image to docker hub
docker push $DOCKER_ID_USER/$DOCKER_IMAGE_NAME:latest
docker push $DOCKER_ID_USER/$DOCKER_IMAGE_NAME:${tag}
