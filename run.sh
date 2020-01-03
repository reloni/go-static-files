#!/bin/bash
set -e

docker container rm -f $(docker container ps -a --filter "name=go-static-files" -q) >> /dev/null 2>&1 || true && \
    docker run -d --rm --name go-static-files -p 8080:8080 reloni/go-static-files