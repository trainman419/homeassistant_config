#!/bin/bash

docker start esphome || \
docker run -d --name="esphome" \
--restart unless-stopped \
-it --net=host \
-v $(pwd)/esphome-config:/config \
esphome/esphome
