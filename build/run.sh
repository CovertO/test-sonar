#!/bin/bash

set -e

if [ -z "$1" ]; then 
    echo "ERR: First argument must be command to run.";
    exit 1; 
fi

docker build -t paypaltest_build ./build/

docker run \
    --rm \
    -e AZURE_PIPELINE="true" \
    -v ${PWD}:/src \
    --workdir="/src" \
    -v /var/run/docker.sock:/var/run/docker.sock \
    --entrypoint /bin/bash \
    paypaltest_build \
    $1

HOST_UID=$(id -u)
docker run --rm -v $(pwd):/src busybox:stable chown -R $HOST_UID:$HOST_UID src
