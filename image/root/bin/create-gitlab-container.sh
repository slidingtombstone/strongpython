#!/bin/sh

create-system-network &&
    create-private-network &&
    create-gitlab-config-volume &&
    create-gitlab-backup-volume &&
    if [ ! -f ${HOME}/docker/containers/gitlab ]
    then
        docker \
            container \
            create \
            --cidfile ${HOME}/docker/containers/gitlab \
            --restart always \
            gitlab/gitlab-ce:latest &&
            docker network connect --alias gitlab $(cat ${HOME}/docker/networks/system) $(cat ${HOME}/docker/containers/gitlab)
    fi