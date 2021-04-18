#!/bin/bash

echo "Stopping containers... "
docker-compose -f ../config/docker-compose.yaml down --volumes --remove-orphans
rm -r ../crypto-config
rm -r ../channel-artifacts
