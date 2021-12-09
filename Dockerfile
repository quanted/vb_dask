FROM daskdev/dask:2021.10.0-py3.9

RUN apt-get update --allow-releaseinfo-change -y
RUN apt-get upgrade --fix-missing -y
RUN apt-get install --no-install-recommends git build-essential python3-dev libpq-dev -y --fix-missing && \
    pip install -U pip

RUN mkdir /app/
WORKDIR /app/vb_django

RUN conda create --name pyenv python=3.9

RUN cd /app && git clone -b main https://github.com/quanted/vb_django.git && \
    conda run -n pyenv --no-capture-output pip install -r vb_django/requirements.txt

ENV PYTHONPATH="/app:/app/vb_django:/app/vb_django/vb_django:${PYTHONPATH}"
ENV PATH="/app:/app/vb_django:/app/vb_django/vb_django:${PATH}"
ENV DJANGO_SETTINGS_MODULE=vb_django.settings
COPY dask_configuration.yaml /etc/dask
CMD ["conda", "run", "-n", "pyenv", "--no-capture-output", "dask-worker", "vb-dask-scheduler:8786"]
