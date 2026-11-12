# usage
```shell
curl -o- https://raw.githubusercontent.com/flooris/package-builder/main/build.sh | bash -s build
```
The last parameter ``build`` is the run script you want yarn to execute.

The Node version is taken from the `.nvmrc` of the project (for example `lts/krypton` becomes the `node:krypton-alpine` image).
Node 25 and newer no longer ship Corepack, so the script installs it first when it is missing.

See: [KB Hosting - Docker rootless](https://www.notion.so/flooris/f06d6d4005124123827f392357275d6e?v=7ee5278a6ab64caa9e67174ccb1c97de&p=6ce1373fb3c64e44b258cbc558e1a2f8&pm=s)
