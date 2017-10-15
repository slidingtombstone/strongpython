#!/bin/sh

if ! git diff --exit-code
then
    echo There are local unstaged changes &&
        exit 64
elif ! git diff --cached --exit-code
then
    echo There are changes staged but not committed &&
        exit 65
elif [ ! -z "$(git ls-files --other --exclude-standard --directory)" ]
then
    echo There are untracked files that are not ignored &&
        exit 66
else
    docker image build --tag slidingtombstone/strongpython:git rev-parse --verify HEAD
fi