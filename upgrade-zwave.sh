#!/bin/bash

docker pull zwavejs/zwavejs2mqtt
docker stop zwavejs
docker rm zwavejs
./start-zwave.sh
