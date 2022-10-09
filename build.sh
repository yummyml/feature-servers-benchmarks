#!/bin/bash

base_path=$(pwd)
cd $base_path/docker/vegeta
docker build -t qooba/feature-servers-benchmarks:vegeta .

cd $base_path/docker/feast-serve
docker build -t qooba/feature-servers-benchmarks:feast-serve .

cd $base_path/docker/yummy-serve
docker build -t qooba/feature-servers-benchmarks:yummy-serve .

cd $base_path
