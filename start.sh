#!/bin/bash

set -euo pipefail

# NOTE: may need `docker exec [container] pip install pyst2` to install pyst2
docker start home-assistant || ./create-homeassistant.sh
#docker logs home-assistant --since 1m --follow 2>&1 | grep -i -B4 -A10 -e bluesound 
docker logs home-assistant --since 1m --follow 2>&1 
