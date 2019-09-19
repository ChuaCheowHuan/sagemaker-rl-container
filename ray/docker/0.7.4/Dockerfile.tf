ARG processor
#FROM 520713654638.dkr.ecr.us-west-2.amazonaws.com/sagemaker-tensorflow-scriptmode:1.14.0-$processor-py3
FROM 520713654638.dkr.ecr.us-west-2.amazonaws.com/sagemaker-tensorflow-scriptmode:1.12.0-$processor-py3
#FROM tensorflow/tensorflow:1.14.0-py3

RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        jq \
        libav-tools \
        libjpeg-dev \
        libxrender1 \
        python3.6-dev \
        python3-opengl \
        wget \
        xvfb && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir \
    Cython==0.29.7 \
    gym==0.14.0 \
    lz4==2.1.10 \
    opencv-python-headless==4.1.0.25 \
    PyOpenGL==3.1.0 \
    pyyaml==5.1.1 \
    redis>=3.2.2 \
    ray==0.7.4 \
    ray[rllib]==0.7.4 \
    scipy==1.3.0 \
    requests \ 
    sortedcontainers

# https://click.palletsprojects.com/en/7.x/python3/
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

# Copy workaround script for incorrect hostname
COPY lib/changehostname.c /

COPY lib/start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

# Starts framework
ENTRYPOINT ["bash", "-m", "start.sh"]

