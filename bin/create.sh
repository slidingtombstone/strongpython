#!/bin/sh

docker \
    container \
    create \
    --name strongpython \
    --tty \
    --volume /var/run/docker.sock:/var/run/docker.sock:ro \
    --env USER_NAME \
    --env USER_EMAIL \
    --restart always \
    slidingtombstone/strongpython:$(git rev-parse --verify HEAD) &&
    docker container start strongpython