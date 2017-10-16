#!/bin/sh

docker \
    container \
    create \
    --cidfile ${HOME}/docker/containers/browser \
    --env DISPLAY=${DISPLAY} \
    --volume /tmp/.X11-unix:/tmp/.X11-unix:ro \
    slidingtombstone/browser:976e5f4d1a95113ae2afcaf5adc733d89728e4d8 &&
    docker network connect $(cat ${HOME}/docker/networks/system) $(cat ${HOME}/docker/containers/browser) &&
    docker container start ${HOME}/docker/containers/browser