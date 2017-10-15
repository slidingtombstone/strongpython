#!/bin/sh

clean(){
    ls -1 ${HOME}/docker/${1}s | while read FILE
    do
        if [ ${1} == "container" ]
        then
            docker ${1} stop $(cat ${HOME}/docker/${1}s/${FILE}) &&
                docker ${1} rm --volumes $(cat ${HOME}/docker/${1}s/${FILE})
        else
            docker ${1} rm $(cat ${HOME}/docker/${1}s/${FILE})
        fi &&
            rm -f ${HOME}/docker/${1}s/${FILE}
    done
} &&
    clean container &&
    clean volume &&
    clean network