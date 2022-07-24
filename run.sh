#!/bin/bash
source config.sh

docker run -it --rm \
--name $CONTAINER_NAME \
-p 3000:3000 \
--env-file .env \
-v "$(pwd)"/app:/home/node/app \
$IMAGE_NAME:$IMAGE_TAG /bin/sh

# This flag is added during development with mounting
# Note: if APP_NAME arg was used in Dockerfile, the folder name can also be changed
# -v "$(pwd)"/app:/home/node/app \ 