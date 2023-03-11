#!/bin/bash
set -e

PATH=$1

function check() {
    GIT_PREVIOUS_COMMIT=$(git rev-parse --short "HEAD^")
    GIT_COMMIT=$(git rev-parse --short HEAD)

    DIR_PATH=$PATH
    if [ ! -d "$DIR_PATH" ]; then
        ##echo "Directory '$DIR_PATH' not exists"
        echo "0"
    fi

    if [ -z "$GIT_COMMIT" ]; then
        ##echo "No current commit... fail"
        echo "0"
    fi

    if [ -z "$GIT_PREVIOUS_COMMIT" ]; then
        ##echo "No previous commit, files are changed!"
        echo "0"
    fi

    CHANGED=`git diff --name-only $GIT_PREVIOUS_COMMIT $GIT_COMMIT $DIR_PATH`

    if [ -z "$CHANGED" ]; then
            echo "0"
    else
            echo "1"
    fi
}

echo ::set-output name=changed::$(check)