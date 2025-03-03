#!/bin/bash

# List of packages to install
PACKAGES="
    git
    curl
    build-essential
    nano
    unzip
    wget
    gcc
    g++
    libffi-dev
    libelf-dev
    clang
    bison
    software-properties-common
    zlib1g-dev
    neofetch
    dbus
    dbus-x11
    cmake 
"

# Function to check and use the appropriate package manager
install_packages() {
    if command -v apt &> /dev/null; then
        # Debian/Ubuntu
        apt update -y
        apt upgrade -y
        apt install -y apt-utils $PACKAGES
        apt clean
        rm -rf /var/lib/apt/lists/*
    elif command -v yum &> /dev/null; then
        # RHEL/CentOS
        yum update -y
        yum install -y $PACKAGES
        yum clean all
    elif command -v dnf &> /dev/null; then
        # Fedora
        dnf update -y
        dnf install -y $PACKAGES
        dnf clean all
    elif command -v pacman &> /dev/null; then
        # Arch Linux
        pacman -Syu --noconfirm
        pacman -S --noconfirm $PACKAGES
        pacman -Sc --noconfirm
    else
        echo "No supported package manager found."
        exit 1
    fi
}

# Run the function
install_packages