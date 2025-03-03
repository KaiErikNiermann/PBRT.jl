#!/bin/bash

log_message () {
  echo "[$(date --rfc-3339=seconds)] $1" >> install_log.txt
}

secure_download() {
  url=$1
  output_file=$2
  if curl --proto '=https' --tlsv1.2 -fSL "$url" -o "$output_file"; then
    log_message "Downloaded $url successfully."
    return 0
  else
    log_message "Error downloading $url."
    return 1
  fi
}

setup_environment() {
  export_path=$1
  echo "Setting up environment variables..."
  shell_rc_file=""

  case "$SHELL" in
    */bash)
      shell_rc_file="$HOME/.bashrc"
      ;;
    */zsh)
      shell_rc_file="$HOME/.zshrc"
      ;;
    */ksh)
      shell_rc_file="$HOME/.kshrc"
      ;;
    */fish)
      shell_rc_file="$HOME/.config/fish/config.fish"
      ;;
    *)
      echo "Unsupported shell: $SHELL"
      exit 1
      ;;
  esac

  echo "export PATH=$export_path:\$PATH" >> "$shell_rc_file"
  source "$shell_rc_file"
}

is_installed() {
  pacman -Qi "$1" &>/dev/null
}