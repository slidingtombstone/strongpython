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
    if [ ! -f ${HOME}/docker/containers/sshd ]
    then
        docker \
            container \
            create \
            --restart always \
            --cidfile ${HOME}/docker/containers/sshd \
            --mount type=volume,source=$(cat ${HOME}/docker/volumes/sshd_config),destination=/etc/ssh \
            panubo/sshd \
                /usr/sbin/sshd \
                -D \
                -f /etc/ssh/sshd_config &&
            docker network connect --alias sshd $(cat ${HOME}/docker/networks/system) $(cat ${HOME}/docker/containers/sshd) &&
            docker container start $(cat ${HOME}/docker/containers/sshd) &&
            sleep 3s &&
            docker \
                container \
                exec \
                --interactive \
                --tty \
                --user root \
                $(cat ${HOME}/docker/containers/sshd) touch /root/.ssh/authorized_keys &&
            docker \
                container \
                exec \
                --interactive \
                --tty \
                --user root \
                $(cat ${HOME}/docker/containers/sshd) chmod 0600 /root/.ssh/authorized_keys
    fi