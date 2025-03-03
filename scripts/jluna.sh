#!/bin/bash

# Default values
JLUNA_REPO="https://github.com/KaiErikNiermann/jluna.git"
JLUNA_BRANCH="testing"
BUILD_DIR="build"
CXX_COMPILER="g++-10"
INSTALL_PREFIX="/usr/local"  # Change this if you want to install elsewhere

# Help message
usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -clone       Clone the jluna repository"
    echo "  -build       Build jluna"
    echo "  -install     Install jluna"
    echo "  -all         Clone, build, and install jluna"
    echo "  -compiler=<path/to/compiler>  Specify C++ compiler (default: g++-10)"
    echo "  -prefix=<path>                Specify installation prefix (default: /usr/local)"
    echo "  -help        Show this help message"
    exit 0
}

# Clone the jluna repository
clone_jluna() {
    echo "INFO: Cloning jluna repository..."
    git clone --branch $JLUNA_BRANCH $JLUNA_REPO 
}

build_jluna() {
    echo "INFO: Building jluna..."
    mkdir -p $BUILD_DIR
    cd $BUILD_DIR
    cmake -DCMAKE_CXX_COMPILER=$CXX_COMPILER ..
    make -j
    cd ..
}

install_jluna() {
    echo "INFO: Installing jluna..."
    cd $BUILD_DIR
    sudo make install
    cd ..
}


# Parse command-line arguments
while getopts "clone:build:install:all:compiler:prefix:help" opt; do
    case $opt in
        clone)
            clone_jluna
            ;;
        build)
            build_jluna
            ;;
        install)
            install_jluna
            ;;
        all)
            clone_jluna
            build_jluna
            install_jluna
            ;;
        compiler)
            CXX_COMPILER=$OPTARG
            ;;
        prefix)
            INSTALL_PREFIX=$OPTARG
            ;;
        help)
            usage
            ;;
        *)
            usage
            ;;
    esac
done