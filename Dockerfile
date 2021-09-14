# https://github.com/instrumentisto/rsync-ssh-docker-image
FROM instrumentisto/rsync-ssh

MAINTAINER Jolibrain <contact@jolibrain.com>

# Set UID and GUID to avoid permission issues
USER 1000:1000

RUN mkdir /tmp/data
WORKDIR /tmp/data

# Jupyter Notebook widgets / TODO: git clone from github
RUN mkdir code
RUN wget -O - https://www.deepdetect.com/downloads/platform/dd_widgets_latest.tar.gz | tar zxf - -C code

# Jupyter Notebooks examples and DeepDetect python client
RUN mkdir notebooks
RUN wget --no-check-certificate https://www.deepdetect.com/downloads/platform/notebooks/dd_examples.ipynb -P notebooks
RUN wget --no-check-certificate https://raw.githubusercontent.com/jolibrain/deepdetect/master/clients/python/dd_client/__init__.py -O notebooks/dd_client.py

# Examples data
RUN mkdir examples
RUN wget -O - https://www.deepdetect.com/downloads/platform/data_examples_latest.tar.gz | tar zxf - -C examples/

# Public Models
RUN mkdir -p models/public
RUN wget -O - https://www.deepdetect.com/downloads/platform/platform_desktop_models_latest.tar.gz | tar zxf - -C models/public

# Pretrained Models
RUN mkdir models/pretrained
RUN wget -O - https://www.deepdetect.com/downloads/platform/pretrained_latest.tar.gz | tar zxf - -C models/

# Private and Training Models folder
RUN mkdir models/private
RUN mkdir models/training

# Data folder
RUN mkdir data

CMD ["rsync", "-avz", "/tmp/data/", "/platform/"]
