#!/bin/bash

set -euo pipefail

docker stop home-assistant
docker rm home-assistant
