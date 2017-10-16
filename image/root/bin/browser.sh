#!/bin/sh

create-system-network &&
    docker \
        container \
        create \
        --cidfile ${HOME}/docker/containers/browser \
        --env DISPLAY=${DISPLAY} \
        --volume /tmp/.X11-unix:/tmp/.X11-unix:ro \
        slidingtombstone/browser:29d10b97bdde3a2b2d505474f51d97b2830b6120 &&
    docker network connect $(cat ${HOME}/docker/networks/system) $(cat ${HOME}/docker/containers/browser) &&
    docker container start $(cat ${HOME}/docker/containers/browser)