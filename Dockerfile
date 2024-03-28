FROM nvidia/cuda:12.3.2-runtime-ubuntu22.04

ARG PYTHON_VERSION=3.12.0
ARG JULIA_VERSION=1.10.2

ENV container docker 
ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.utf8
ENV MAKEFLAGS -j4

RUN mkdir /app
WORKDIR /app

# deps 
RUN apt-get update -y && \ 
    apt-get install -y gcc make wget curl git zlib1g-dev libffi-dev libssl-dev python-pip 

# poetry 
RUN curl -sSL https://install.python-poetry.org | python -
ENV PATH=$PATH:/root/.local/bin
RUN poetry config virtualenvs.create true

# python 
RUN wget https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz && \
    tar -zxf Python-$PYTHON_VERSION.tgz && \
    cd Python-$PYTHON_VERSION && \
    ./configure --with-ensurepip=install --enable-shared && make && make install && \
    ldconfig && \
    ln -sf python3 /usr/local/bin/python
