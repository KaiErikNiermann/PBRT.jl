#!/bin/bash

# Default values
SWIFT_VERSION="6.0.3"
DISTRO_VERSION="ubuntu22.04"

# Function to display usage
usage() {
    echo "Usage: $0 [-sv swift_version] [-dv distro_version]"
    echo "  -sv    Specify the Swift version (default: 6.0.3)"
    echo "  -dv    Specify the distribution version (default: ubuntu22.04)"
    exit 1
}

# Parse command line options
while getopts "sv:dv:" opt; do
    case ${opt} in
        s)
            SWIFT_VERSION=$OPTARG
            ;;
        d)
            DISTRO_VERSION=$OPTARG
            ;;
        *)
            usage
            ;;
    esac
done

# Define the Swift URL
SWIFT_URL="https://download.swift.org/swift-$SWIFT_VERSION-release/${DISTRO_VERSION//./}/swift-$SWIFT_VERSION-RELEASE/swift-$SWIFT_VERSION-RELEASE-$DISTRO_VERSION.tar.gz"

COMMON_DEPS="
    binutils
    git
    gnupg2
    libedit2
    libsqlite3-0
    pkg-config
    tzdata
    zlib1g-dev
"

# Function to install dependencies
install_dependencies() {
    echo "Installing dependencies for $DISTRO_VERSION..."
    apt update
    if [[ "$DISTRO_VERSION" == "ubuntu20.04" ]]; then
        apt install -y \
            libc6-dev \
            libcurl4 \
            libgcc-9-dev \
            libpython2.7 \
            libstdc++-9-dev \
            libxml2 \
            libz3-dev \
            uuid-dev 
    elif [[ "$DISTRO_VERSION" == "ubuntu22.04" ]]; then
        apt install -y \
            libcurl4-openssl-dev \
            libgcc-11-dev \
            libpython3-dev \
            libstdc++-11-dev \
            libxml2-dev \
            libz3-dev \
            python3-lldb-13 \
            unzip 
    elif [[ "$DISTRO_VERSION" == "ubuntu24.04" ]]; then
        apt install -y \
            libc6-dev \
            libcurl4-openssl-dev \
            libgcc-13-dev \
            libncurses-dev \
            libpython3-dev \
            libstdc++-13-dev \
            libxml2-dev \
            libz3-dev \
            unzip 
    else
        echo "Unsupported distribution version: $DISTRO_VERSION"
        exit 1
    fi
}

# Function to download Swift
download_swift() {
    echo "Downloading Swift $SWIFT_VERSION..."
    wget $SWIFT_URL -O swift.tar.gz
}

# Function to verify PGP signature
verify_pgp_signature() {
    echo "Verifying PGP signature..."
    gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys 'A62A E125 BBBF BB96 A6E0 42EC 925C C1CC ED3D 1561' 'E813 C892 820A 6FA1 3755 B268 F167 DF1A CF9C E069'
    gpg --keyserver hkp://keyserver.ubuntu.com --refresh-keys Swift
    wget $SWIFT_URL.sig -O swift.tar.gz.sig
    gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys EF80A866B47A981F
    gpg --verify swift.tar.gz.sig swift.tar.gz
}

# Function to extract Swift
extract_swift() {
    echo "Extracting Swift..."
    tar -xvzf swift.tar.gz
}

# Function to install Swift
install_swift() {
    echo "Installing Swift..."
    mv swift-$SWIFT_VERSION-RELEASE-$DISTRO_VERSION /usr/local/swift
}

# Function to set environment variables
setup_swift_env() {
    echo "Setting up environment variables..."
    setup_environment "/usr/local/swift/usr/bin"
}

# Function to verify installation
verify_installation() {
    echo "Verifying Swift installation..."
    swift --version
}

# Main script execution
main() {
    script_dir="$(dirname "$0")"

    # Source the utilities script to make its functions available
    source "$script_dir/utilities.sh"

    # Exit on any error
    set -e

    install_dependencies
    download_swift
    verify_pgp_signature
    extract_swift
    install_swift
    setup_environment
    # verify_installation

    echo "Swift $SWIFT_VERSION installation complete!"
}

main "$@"
