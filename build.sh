#!/bin/sh

CONTAINER_IMAGE=${CONTAINER_IMAGE:-nextthingco/chiptainer_wifi_access_point}

docker build --no-cache=true -t "${CONTAINER_IMAGE}" .
