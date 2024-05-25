#!/bin/bash

set -euo pipefail

#IMAGE_NAME=homeassistant/home-assistant
IMAGE_NAME=home-assistant-dev

# NOTE: may need `docker exec [container] pip install pyst2` to install pyst2
docker start home-assistant || docker run -d --name="home-assistant" --restart unless-stopped -v /home/hendrix/home-assistant/config:/config -v /etc/localtime:/etc/localtime:ro --device=/dev/serial/by-id/usb-0658_0200-if00:/zwaveusbstick:rw --net=host "$IMAGE_NAME"
docker logs home-assistant --since 1m --follow 2>&1 | grep -i -B4 -A10 -e bluesound 
