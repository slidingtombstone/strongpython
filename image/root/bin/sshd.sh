#!/bin/sh

if [ ! -f /home/user/docker/networks/system ]
then
    docker network create $(uuidgen) > /home/user/docker/networks/system
fi &&
if [ ! -f ${HOME}/docker/volumes/sshd_config ]
    then
        docker volume create > ${HOME}/docker/volumes/sshd_config &&
            cat \
                /opt/docker/etc/sshd_config.txt | docker \
                container \
                run \
                --interactive \
                --rm \
                --mount type=volume,source=$(cat ${HOME}/docker/volumes/sshd_config),destination=/etc/ssh \
                --workdir /etc/ssh \
                alpine:3.4 \
                    tee sshd_config
    fi &&
    if [ ! -f ${HOME}/docker/volumes/sshd_dot_ssh ]
    then
        docker volume create > ${HOME}/docker/volumes/sshd_dot_ssh &&
            docker \
                container \
                run \
                --interactive \
                --tty \
                --rm \
                --mount type=volume,source=$(cat ${HOME}/docker/volumes/sshd_dot_ssh),destination=/root/.ssh \
                --workdir /root/.ssh \
                alpine:3.4 \
                    touch \
                    authorized_keys &&
            docker \
                container \
                run \
                --interactive \
                --tty \
                --rm \
                --mount type=volume,source=$(cat ${HOME}/docker/volumes/sshd_dot_ssh),destination=/root/.ssh \
                --workdir /root/.ssh \
                alpine:3.4 \
                    chmod \
                    0600 \
                    authorized_keys
    fi &&
    if [ ! -f ${HOME}/docker/containers/sshd ]
    then
        docker \
            container \
            create \
            --restart always \
            --cidfile ${HOME}/docker/containers/sshd \
            --mount type=volume,source=$(cat ${HOME}/docker/volumes/sshd_config),destination=/etc/ssh \
            --mount type=volume,source=$(cat ${HOME}/docker/volumes/sshd_dot_ssh),destination=/root/.ssh \
            rastasheep/ubuntu-sshd:14.04 \
                sshd \
                -D \
                -f /etc/ssh/sshd_config &&
            docker network connect --alias sshd $(cat ${HOME}/docker/networks/system) $(cat ${HOME}/docker/containers/sshd) &&
            docker container start $(cat ${HOME}/docker/containers/sshd)
    fi