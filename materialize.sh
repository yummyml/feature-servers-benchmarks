#!/bin/bash

#docker network create -d bridge app_default
docker run --rm -d --name redis --network app_default redis

docker run --rm -it --name feast-serve -v $(pwd)/benchmark:/benchmark --network app_default qooba/feature-servers-benchmarks:feast-serve ./materialize.sh
