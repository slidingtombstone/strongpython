#!/bin/sh

docker \
    container \
    create \
    --cidfile ${HOME}/docker/containers/browser \
    --env DISPLAY=${DISPLAY} \
    --volume /tmp/.X11-unix:/tmp/.X11-unix:ro \
    slidingtombstone/strongpython/browser:cdb42a97cc156918f8511953bac7e8f9b33de3bb &&
    docker network connect $(cat ${HOME}/docker/networks/system) $(cat ${HOME}/docker/containers/browser) &&
    docker container start ${HOME}/docker/containers/browser