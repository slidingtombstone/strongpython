#!/bin/sh

sshd &&
    export USER_NAME &&
    export USER_EMAIL &&
    if [ ! -f ${HOME}/data/sshd.counter ]
    then
        echo $((${RANDOM}%10000+20000)) > ${HOME}/data/sshd.counter
    fi &&
    CIDFILE=$(tcid) &&
    export SSHD_PORT=$(cat ${HOME}/data/sshd.counter) &&
    echo $((${SSHD_PORT}+1)) > ${HOME}/data/sshd.counter &&
    docker \
        container \
        create \
        --cidfile ${CIDFILE} \
        --env WORKSPACE_NAME=${1} \
        --env SSHD_CONTAINER=$(cat ${HOME}/docker/containers/sshd) \
        --env SSHD_PORT \
        --env USER_NAME \
        --env USER_EMAIL \
        slidingtombstone/developer:4c2ba7914649969517a2fa35417a7b78e9aff678 &&
    docker network connect --alias ${1} $(cat ${HOME}/docker/networks/system) $(cat ${CIDFILE}) &&
    docker network connect --alias ${1} entrypoint_default $(cat ${CIDFILE}) &&
    docker container start $(cat ${CIDFILE}) &&
    docker container exec --interactive --tty --user root $(cat ${CIDFILE}) ssh-keygen -f /root/.ssh/id_rsa -P "" -C "autogenerated" &&
    docker container exec --interactive --tty --user root $(cat ${CIDFILE}) cat /root/.ssh/id_rsa.pub | docker container exec --interactive $(cat ${HOME}/docker/containers/sshd) tee --append /root/.ssh/authorized_keys &&
    docker container exec --detach --user root $(cat ${CIDFILE}) ssh -i /root/.ssh/id_rsa -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -fN -R 127.0.0.1:${SSHD_PORT}:127.0.0.1:8181 sshd &&
    docker container exec --detach --user root $(cat ${CIDFILE}) nohup ssh -i /root/.ssh/id_rsa -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -fN -L 0.0.0.0:80:0.0.0.0:${SSHD_PORT} sshd