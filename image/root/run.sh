#!/bin/sh

apk update &&
    apk upgrade &&
    apk add --no-cache bash sudo &&
    adduser -D user &&
    cp /opt/docker/sudo.txt /etc/sudoers.d/user &&
    chmod 0444 /etc/sudoers.d/user &&
    mkdir /home/user/bin &&
    ls -1 /opt/docker/bin | while read FILE
    do
        cp /opt/docker/bin/${FILE} /home/user/bin/${FILE%.*} &&
            chmod 0500 /home/user/bin/${FILE%.*}
    done &&
    cp /opt/docker/bashrc.txt /home/user/.bashrc &&
    chown -R user:user /home/user/bin /home/user/.bashrc &&
    rm -rf /var/cache/apk/*