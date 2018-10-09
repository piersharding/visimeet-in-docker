#!/bin/sh


X=`docker ps -a | grep visimeet`
if [ "$X" = "" ]; then
  echo "no container running..."
else
  echo "removing running container ..."
  docker stop visimeet
  docker rm -f visimeet
fi

X=`docker images | grep visimeet_img`
if [ "$X" = "" ]; then
  echo "no image ..."
else
  if [ -n "$1" ]; then
    echo "removing image ..."
    docker rmi visimeet_img
  else
    echo "leaving image..."
  fi
fi

docker build -t visimeet_img .
