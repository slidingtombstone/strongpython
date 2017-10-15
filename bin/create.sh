#!/bin/sh

docker \
    container \
    create \
    slidingtombstone/strongpython:$(git rev-parse --verify HEAD)