#!/bin/sh

clean(){
    ls -1 ${HOME}/docker/${1} | while read FILE
    do
        if [ ${1} == "container" ]
        then
            docker ${1} stop $(cat ${HOME}/docker/${1}s/${FILE})
        fi &&
            docker ${1} rm --volumes $(cat ${HOME}/docker/${1}s/${FILE}) &&
            rm -f ${HOME}/docker/${1}s/${FILE}
    done
} &&
    clean container &&
    clean volume &&
    clean network