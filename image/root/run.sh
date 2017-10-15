#!/bin/sh

apk update &&
    apk upgrade &&
    apk add --no-cache bash sudo &&
    adduser -D user &&
    cp /opt/docker/user.sudo /etc/sudoers.d/user &&
    chmod 0444 /etc/sudoers.d/user &&
    rm -rf /var/cache/apk/*