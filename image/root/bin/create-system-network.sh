#!/bin/sh

if [ ! -f ${HOME}/docker/networks/system ]
then
    docker network create $(uuidgen) > ${HOME}/docker/networks/system
fi