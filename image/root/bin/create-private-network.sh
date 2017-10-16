#!/bin/sh

if [ ! -f ${HOME}/docker/networks/private ]
then
    docker network create $(uuidgen) > ${HOME}/docker/networks/private
fi