#!/bin/bash

docker start matter-server || docker run -d --name="matter-server" --restart unless-stopped -it --network=host  --security-opt apparmor=unconfined \
-v $(pwd)/matter-store:/data -v /run/dbus:/run/dbus:ro ghcr.io/home-assistant-libs/python-matter-server:stable
