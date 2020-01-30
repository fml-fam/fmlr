#!/bin/sh

sudo docker build --gpus -t fmlr-dev-gpu . \
  && sudo docker run --gpus -i -t --rm fmlr-dev-gpu
