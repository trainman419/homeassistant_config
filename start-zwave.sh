#!/bin/bash

docker start zwavejs || docker run -d --name="zwavejs" --restart unless-stopped -it -p 8091:8091 -p 3001:3000 --device=/dev/serial/by-id/usb-0658_0200-if00:/dev/zwave \
-v $(pwd)/zwave-store:/usr/src/app/store zwavejs/zwavejs2mqtt:latest
