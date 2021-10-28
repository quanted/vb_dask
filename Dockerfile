FROM daskdev/dask:2021.10.0-py3.9

RUN apt update -y && \
    apt upgrade -y && \
    apt install git build-essential python3-dev libpq-dev -y && \
    pip install -U pip

RUN cd /tmp && \
    git clone -b main https://github.com/quanted/vb_django.git && \
    pip install --ignore-installed -r vb_django/requirements.txt  && \
    rm -rf vb_django

ENV PYTHONPATH="/app:/app/vb_django:${PYTHONPATH}"
ENV DJANGO_SETTINGS_MODULE=vb_django.settings
COPY dask_configuration.yaml /etc/dask
