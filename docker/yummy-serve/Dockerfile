FROM python:3.9.13
RUN pip3 install yummy-rs~=0.0.5
WORKDIR /benchmark
CMD python3 -c "import yummy_rs; yummy_rs.serve('./feature_store.yaml','0.0.0.0',6566,'error')"
