#!/bin/bash
set -e

# Stop the running container (if any)
co=docker ps | awk '{print $1}'
docker rm -f $co



