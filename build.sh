#!/usr/bin/env bash

set -e

node_version=$(head -n 1 .nvmrc | tr '[:upper:]' '[:lower:]'| sed 's:.*/::')
node_image="node:${node_version}-alpine"

# Check if the Docker engine is running in rootless mode
if docker info --format '{{.SecurityOptions}}' | grep -iq "rootless"; then
    echo "[flooris-package-builder] Docker is running in ROOTLESS mode."
    IS_ROOTLESS=true
else
    echo "[flooris-package-builder] Docker is running in STANDARD mode."
    IS_ROOTLESS=false
fi

user_flag=()
if [ "$IS_ROOTLESS" = false ]; then
  # We are not running in rootless mode, use the user and group ID of the current user instead
  # This should prevent us from writing the node_modules and compiled assets as the Docker/root user
  user_flag=(--user "$(id -u):$(id -g)")
fi

docker run --rm \
  "${user_flag[@]}" \
  -e HOME=/tmp \
  -v "$PWD":/usr/src/app \
  -w /usr/src/app \
  "${node_image}" \
  sh -c "echo \"[flooris-package-builder] User ID: \$(id -u), Group ID: \$(id -g)\" && mkdir -p /tmp/bin && corepack enable --install-directory /tmp/bin && export PATH=\"/tmp/bin:\$PATH\" && yarn && yarn run \"$1\" && echo \"[flooris-package-builder] Build completed successfully.\""
