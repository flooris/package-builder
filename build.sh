#!/usr/bin/env bash

node_version=$(head -n 1 .nvmrc | tr '[:upper:]' '[:lower:]'| sed 's:.*/::')
node_image="node:${node_version}-alpine"

docker run --rm \
  --user "$(id -u):$(id -g)" \
  -e HOME=/tmp \
  -v "$PWD":/usr/src/app \
  -w /usr/src/app \
  "${node_image}" \
  sh -c "mkdir -p /tmp/bin && corepack enable --install-directory /tmp/bin && export PATH=\"/tmp/bin:\$PATH\" && yarn && yarn run \"$1\""
