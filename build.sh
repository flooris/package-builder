#!/usr/bin/env bash

node_version=$(head -n 1 .nvmrc | tr '[:upper:]' '[:lower:]'| sed 's:.*/::')
node_image="node:${node_version}-alpine"

docker run --rm -v "$PWD":/usr/src/app -w /usr/src/app "${node_image}" yarn
docker run --rm -v "$PWD":/usr/src/app -w /usr/src/app "${node_image}" yarn run build
