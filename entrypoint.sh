#!/bin/bash
set -e

PATH=$1

GIT_PREVIOUS_COMMIT=$(git rev-parse --short "HEAD^")
GIT_COMMIT=$(git rev-parse --short HEAD)

DIR_PATH=$PATH

if [ ! -d "$DIR_PATH" ]; then
    exit 1
fi

if [ -z "$GIT_COMMIT" ]; then
    exit 1
fi

if [ -z "$GIT_PREVIOUS_COMMIT" ]; then
    exit 0
fi

CHANGED=`git diff --name-only $GIT_PREVIOUS_COMMIT $GIT_COMMIT $DIR_PATH`

OUTPUT="0"
if [ -z "$CHANGED" ]; then
    OUTPUT="0"
else
    OUTPUT="1"
fi

echo ::set-output name=changed::$(echo $OUTPUT)
