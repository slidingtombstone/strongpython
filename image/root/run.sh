#!/bin/sh

apk update &&
    apk upgrade &&
    adduser -D user &&
    rm -rf /var/cache/apk/*