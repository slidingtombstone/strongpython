#!/bin/sh

docker \
    container \
    create \
    --interactive \
    --tty \
    slidingtombstone/strongpython:$(git rev-parse --verify HEAD)