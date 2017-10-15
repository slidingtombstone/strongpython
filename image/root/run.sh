#!/bin/sh

apk update &&
    apk upgrade &&
    apk add --no-cache bash sudo &&
    adduser -D user &&
    cp /opt/docker/user.sudo /etc/sudoers.d/user &&
    chmod 0444 /etc/sudoers.d/user &&
    mkdir /home/user/bin &&
    cp /opt/docker/docker.sh /home/user/bin/docker &&
    chmod 0500 /home/user/bin/docker &&
    cp /opt/docker/bash_profile.txt /home/user/.profile &&
    chown -R user:user /home/user/bin /home/user/.profile &&
    rm -rf /var/cache/apk/*