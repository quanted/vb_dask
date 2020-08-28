#!/bin/bash
docker build -t vb_dask:0.2 .
echo Enter absolute path to vb_django repo:
read VPATH
echo Enter your machine IP address:
read IP
docker rm -f dask-scheduler dask-worker
docker run -d --name dask-scheduler -p 8786:8786 -p 8787:8787 vb_dask:0.2 dask-scheduler
docker run -d --name dask-worker -v $VPATH:/app vb_dask:0.2 dask-worker tcp://$IP:8786