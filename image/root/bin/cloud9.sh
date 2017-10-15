#!/bin/sh

CIDFILE=$(tcid.sh) &&
    docker \
        container \
        create \
        --cidfile ${CIDFILE} \
        --detach \
        --env WORKSPACE_NAME=${1} \
        --env USER_NAME \
        --env USER_EMAIL \
        slidingtombstone/developer:4c2ba7914649969517a2fa35417a7b78e9aff678 &&
    docker network connect --alias ${1} $(cat ${HOME}/docker/networks/system) $(cat ${CIDFILE}) &&
    docker container start $(cat ${CIDFILE})