apt-get update && apt-get install -y libgtest-dev cmake && \
    cd /usr/src/gtest && \
    cmake . && \
    make && \
    cp lib/*.a /usr/lib