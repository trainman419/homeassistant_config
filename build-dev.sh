#!/bin/bash

set -euo pipefail

#docker pull homeassistant/amd64-base-python

pushd home-assistant
docker build -t home-assistant-dev . --build-arg BUILD_FROM=homeassistant/amd64-base-python
popd
