#!/bin/bash

#docker network create -d bridge app_default
docker run --rm -d --name redis --network app_default redis

NUM_SERVERS=1
NAME="yummy-serve"
TARGET=http://$NAME


echo "##################"
echo "### INITIALIZE ###"
echo "##################"
for i in $(seq 0 1 $NUM_SERVERS); do
  echo "running: $NAME-$i"

  docker run --rm -d --name $NAME-$i \
	  -v $(pwd)/benchmark:/benchmark \
	  --network app_default \
	  qooba/feature-servers-benchmarks:yummy-serve
done


echo "##########################"
echo "### RUNNING BENCHMARK ###"
echo "##########################"
mkdir $(pwd)/output-$NAME
docker run --rm -it --name vegeta \
	  -v $(pwd)/benchmark:/benchmark \
	  -v $(pwd)/output-$NAME:/output \
	  --network app_default \
	  -e NUM_SERVERS=$NUM_SERVERS \
	  -e TARGET=$TARGET \
	  qooba/feature-servers-benchmarks:vegeta \
	  ./run-benchmark.sh


echo "################"
echo "### CLEAN UP ###"
echo "################"
for i in $(seq 0 1 $NUM_SERVERS); do
  echo "shutting down: $NAME-$i"

  docker stop $NAME-$i
done
