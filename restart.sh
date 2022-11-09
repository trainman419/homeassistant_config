#!/bin/bash

set -euo pipefail

docker restart home-assistant
docker logs home-assistant --since 1m --follow
