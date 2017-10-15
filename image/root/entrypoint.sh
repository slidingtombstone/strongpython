#!/bin/sh

if [ ! -f /home/user/docker/networks/system ]
then
    docker volume create $(uuidgen) > /home/user/docker/networks/system
fi &&
bash