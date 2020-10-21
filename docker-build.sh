#!/bin/bash

set -ex

IMAGE_NAME="jolibrain/platform_data"
TAG=$(git rev-parse --verify --short HEAD)

docker build -t ${IMAGE_NAME}:${TAG} -t ${IMAGE_NAME}:latest .
docker push ${IMAGE_NAME}
