#!/bin/sh

CIDFILE=$(mktemp ${HOME}/docker/containers/XXXXXXXX.tmp) &&
    rm -f ${CIDFILE} &&
    echo ${CIDFILE}