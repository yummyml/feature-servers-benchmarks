#!/bin/bash

rm registry.db
python3 data_generator.py
feast apply 

start_date=$(date '+2020-%m-%dT%H:%M:%S')
end_date=$(date '+%Y-%m-%dT%H:%M:%S')
feast materialize $start_date $end_date
