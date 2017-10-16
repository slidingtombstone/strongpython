#!/bin/sh

docker \
    container \
    create \
    --name strongpython \
    --tty \
    --volume /var/run/docker.sock:/var/run/docker.sock:ro \
    --env USER_NAME \
    --env USER_EMAIL \
    --env GITHUB_ID_RSA="$(cat ${HOME}/.ssh/id_rsa)" \
    --env KNOWN_HOSTS="$(cat ${HOME}/.ssh/known_hosts)" \
    --restart always \
    slidingtombstone/strongpython:$(git rev-parse --verify HEAD) &&
    docker container start strongpython