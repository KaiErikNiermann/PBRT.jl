# apt get required utilities 
sudo apt-get update && sudo apt-get install -y \
    pip wget cmake git tar g++-10 make 

# install poetry 
pip install poetry

# compile right python version
wget https://www.python.org/ftp/python/3.12.0/Python-3.12.0.tgz && \
    tar -zxf Python-3.12.0.tgz && \
    cd Python-3.12.0 && \
    ./configure --with-ensurepip=install --enable-shared && make && make install && \
    ldconfig && \
    ln -sf python3 /usr/local/bin/python

# install py deps 
cd py_src && \
    poetry install && \
    cd ..

# setup cpp 
cd cpp_src && /
    sudo bash install_deps.sh && \
    cmake . && \
    make && \
    cd ..