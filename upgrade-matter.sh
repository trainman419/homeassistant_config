#!/bin/bash

docker pull ghcr.io/matter-js/python-matter-server:stable
docker stop matter-server
docker rm matter-server
./start-matter.sh
