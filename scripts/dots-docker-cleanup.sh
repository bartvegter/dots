#!/usr/bin/env bash

# small script that stops and removes any docker containers and removes all images

# kill any running containers
killed=$(docker kill "$(docker ps -qa)" 2>/dev/null)
if [[ -n $killed ]]; then
  echo "Killed all running containers."
  no_action=false
else
  echo "No running containers found."
fi

# remove all existing containers
containers=$(docker rm "$(docker ps -qa)" 2>/dev/null)
if [[ -n $containers ]]; then
  echo "Removed all containers."
  no_action=false
else
  echo "No containers found."
fi

# remove all existing images
images=$(docker rmi "$(docker images -qa)" 2>/dev/null)
if [[ -n $images ]]; then
  echo "Removed all images."
  no_action=false
else
  echo "No images found."
fi
