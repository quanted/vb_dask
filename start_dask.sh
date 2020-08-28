#!/bin/bash
# vb_django must be mounted as a volume to /app
# pip install from /app/vb_django/requirements.txt
dask-worker dask_scheduler:8786