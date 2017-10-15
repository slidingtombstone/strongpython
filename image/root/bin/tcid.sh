#!/bin/sh

CIDFILE=$(mktemp ${HOME}/docker/containers/temp-XXXXXXXX) &&
    rm -f ${CIDFILE} &&
    echo ${CIDFILE}