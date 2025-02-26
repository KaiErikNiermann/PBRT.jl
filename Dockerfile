FROM nvidia/cuda:12.3.2-runtime-ubuntu22.04

ARG PYTHON_VERSION=3.12.0
ARG JULIA_VERSION=1.10.2

ENV container docker 
ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.utf8
ENV MAKEFLAGS -j4

# necessary deps 
RUN apt-get update -y && \ 
    apt-get install -y gcc make wget cmake curl git zlib1g-dev libffi-dev libssl-dev python-pip bash tar g++-10

# python 
RUN wget https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz && \
    tar -zxf Python-$PYTHON_VERSION.tgz && \
    cd Python-$PYTHON_VERSION && \
    ./configure --with-ensurepip=install --enable-shared --enable-loadable-sqlite-extensions --enable-optimizations && make && make install && \
    ldconfig && \
    ln -sf python3 /usr/local/bin/python

# poetry 
RUN curl -sSL https://install.python-poetry.org | python -
ENV PATH=$PATH:/root/.local/bin
RUN poetry config virtualenvs.create true

# julia
RUN wget https://julialang-s3.julialang.org/bin/linux/x64/${JULIA_VERSION%.*}/julia-$JULIA_VERSION-linux-x86_64.tar.gz && \
    tar -xvzf julia-$JULIA_VERSION-linux-x86_64.tar.gz -C /usr/local/ && \
    ln -s /usr/local/julia-$JULIA_VERSION/bin/julia /usr/local/bin/julia && \ 
    mkdir -p /usr/local/include/julia && \
    cp -r /usr/local/julia-$JULIA_VERSION/include/julia /usr/local/include/ && \
    ln -s /usr/local/lib /usr/local/julia-$JULIA_VERSION/lib 

RUN ls -la /usr/local/include/julia
RUN ls -la /usr/local/

# # install py deps 
# RUN cd py_src && \
#     poetry lock && \
#     poetry install && \
#     cd .. 

# # setup cpp 
# RUN cd cpp_src && \
#     rm -rf CMakeFiles && \
#     rm -f cmake_install.cmake && \
#     rm -f CMakeCache.txt && \
#     rm -f Makefile && \
#     bash install_deps.sh 

# setup ctest 
RUN apt-get update && apt-get install -y libgtest-dev cmake && \
    cd /usr/src/gtest && \
    cmake . && \
    make && \
    cp lib/*.a /usr/lib

# setup latex 
RUN apt-get install -y texlive-latex-base texlive-fonts-recommended texlive-fonts-extra texlive-latex-extra

# install sudo 
RUN apt-get install -y sudo

# remove install files 
RUN rm -rf Python-$PYTHON_VERSION.tgz Python-$PYTHON_VERSION julia-1.10.2-linux-x86_64.tar.gz cuda-*

# enter vm 
CMD ["/bin/bash"]
