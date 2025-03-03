#!/bin/bash

script_dir="$(dirname "$0")"

source "$script_dir/utilities.sh"

touch "$HOME/.zshrc"

# Install Zsh and Oh My Zsh
log_message "Installing Zsh..."
if ! is_installed "zsh"; then
  apt update -y 
  apt install zsh -y
  log_message "Zsh installed successfully."
else
  log_message "Zsh is already installed."
fi

# Securely install Oh My Zsh
log_message "Configuring Zsh with Oh My Zsh..."
OH_MY_ZSH_CUSTOM="https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  log_message "Installing Oh My Zsh..."
  secure_download "$OH_MY_ZSH_CUSTOM" /tmp/ohmyzsh_install.sh && \
  RUNZSH=no sh /tmp/ohmyzsh_install.sh
  rm /tmp/ohmyzsh_install.sh
else
  log_message "Oh My Zsh is already installed."
fi

# Securely install Powerlevel10k theme for Oh My Zsh
log_message "Installing Powerlevel10k theme..."
PL10K_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
if [ ! -d "$PL10K_DIR" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$PL10K_DIR"
  log_message "Powerlevel10k theme installed."
else
  log_message "Powerlevel10k theme is already installed."
fi

# Modify .zshrc to set Powerlevel10k theme
if ! grep -q "ZSH_THEME=\"powerlevel10k/powerlevel10k\"" "$HOME/.zshrc"; then
  log_message "Setting Powerlevel10k as the default theme in .zshrc..."
  sed -i 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' "$HOME/.zshrc"
fi

# Install Zsh plugins
log_message "Ensuring Zsh plugins are available..."
ZSH_AUTOSUGGESTIONS="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
ZSH_COMPLETIONS="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-completions"

if [ ! -d "$ZSH_AUTOSUGGESTIONS" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_AUTOSUGGESTIONS"
fi

if [ ! -d "$ZSH_COMPLETIONS" ]; then
  git clone https://github.com/zsh-users/zsh-completions "$ZSH_COMPLETIONS"
fi

if ! grep -q "plugins=(.*zsh-autosuggestions.*zsh-completions.*)" "$HOME/.zshrc"; then
  log_message "Adding zsh-autosuggestions and zsh-completions to plugins in .zshrc..."
  sed -i 's/^plugins=(\(.*\))/plugins=(\1 zsh-autosuggestions zsh-completions)/' "$HOME/.zshrc"
fi

# Switch to Zsh
log_message "Switching to Zsh..."
chsh -s "$(which zsh)"

log_message "Installation and configuration complete! Please restart your session or run 'source ~/.zshrc' to apply the changes to Zsh."
