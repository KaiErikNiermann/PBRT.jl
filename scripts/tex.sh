#!/bin/bash

script_dir="$(dirname "$0")"

# Source the utilities script to make its functions available
source "$script_dir/utilities.sh"

# Update the system
log_message "Updating the system..."
apt update && apt upgrade -y
    

# Install essential latex tools 
log_message "Installing essential LaTeX tools..."
apt install latexmk biber -y 

# Install Tex Live
log_message "Installing TeX Live..."
apt install -y texlive texlive-lang-all texlive-fonts-extra texlive-science

# Optionally, install additional TeX Live utilities
log_message "Installing TeX Live utilities..."
apt install -y texlive-bibtex-extra texlive-humanities

# Install apt-file to search for files in the TeX Live packages
log_message "Installing apt-file..."
apt install -y apt-file
apt-file update

# Verify the installation
log_message "Verifying the TeX Live installation..."
if command -v pdflatex &> /dev/null
then
    log_message "TeX Live installed successfully!"
else
    log_message "TeX Live installation failed."
fi
