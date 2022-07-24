#!/bin/bash
source config.sh

if [ -z "$1" ]
  then
    echo -e "${RED}Please supply the name of the Dockerfile to be built${NC}"
    echo -e "${YELLOW}Usage: "
    echo "./build.sh Dockerfile"
    echo "OR"
    echo -e "./build.sh Dockerfile.dep${NC}\n"
fi

docker build -t $IMAGE_NAME:$IMAGE_TAG -f $1 .

if [ $? -eq 0 ]; then
    echo -e "${GREEN}Image was built successfully! ${NC}"
else
    echo -e "${RED}Image was not built successfully! ${NC}"
fi