#!/bin/sh

sudo docker build -t fmlr-dev . \
  && sudo docker run -i -t --rm fmlr-dev
