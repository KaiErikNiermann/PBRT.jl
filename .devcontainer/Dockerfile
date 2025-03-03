ARG CUDA_VERSION
ARG UBUNTU_VERSION
ARG PYTHON_COMPILE_FLAGS
ARG PYTHON_VERSION
ARG IMAGE_TYPE

# Base image
FROM nvidia/cuda:${CUDA_VERSION}-${IMAGE_TYPE}-ubuntu${UBUNTU_VERSION}

ENV DEBIAN_FRONTEND=noninteractive

# Copy scripts and prepare
COPY scripts/*.sh /tmp/
RUN chmod a+x -R /tmp/*.sh

# Basic setup and language installations
RUN /tmp/basics.sh
RUN /tmp/zsh.sh

# Install languages
# RUN /tmp/coq.sh
# RUN /tmp/tex.sh
# RUN /tmp/poetry.sh