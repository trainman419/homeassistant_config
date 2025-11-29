#!/bin/bash

set -euo pipefail

IMAGE_NAME=homeassistant/home-assistant
#IMAGE_NAME=home-assistant-dev

#docker run -d --name="home-assistant" --restart unless-stopped -v /home/hendrix/home-assistant/config:/config -v /etc/localtime:/etc/localtime:ro --device=/dev/serial/by-id/usb-0658_0200-if00:/zwaveusbstick:rw --net=host "$IMAGE_NAME"
docker run -d --name="home-assistant" --restart unless-stopped -v /home/hendrix/home-assistant/config:/config -v /etc/localtime:/etc/localtime:ro --net=host "$IMAGE_NAME"
docker exec -it home-assistant bash -c "wget -O - https://get.hacs.xyz | bash -"
docker restart home-assistant
