#!/bin/bash

script_dir="$(dirname "$0")"

source "$script_dir/utilities.sh"

# Function to display usage
usage() {
    echo "Usage: $0 [install|update|uninstall|completion]"
    echo "Options:"
    echo "  install          Install Poetry"
    echo "  update           Update Poetry"
    echo "  uninstall        Uninstall Poetry"
    echo "  completion       Enable tab completion for Bash, Fish, or Zsh"
    echo "  append           Append the necessary lines to the shell configuration file"
    echo "  setup            Set the location of the virtual environment (optional, default: outside project directory)"
    exit 1
}

append_to_rc() {
    shell=$(basename "$SHELL")

    setup_environment "$HOME/.local/bin"

    # Try to run poetry 
    poetry --version
    if [ $? -ne 0 ]; then
        echo "Poetry was not found in the PATH. Please restart the shell or run 'source ~/.bashrc' or 'source ~/.zshrc' or 'source ~/.config/fish/config.fish'."
    fi
}

# Function to install Poetry
install_poetry() {
    echo "Installing Poetry..."

    # Install Poetry in an isolated virtual environment
    curl -sSL https://install.python-poetry.org | python3 -

    append_to_rc

    # Set the location of the virtual environment outside the project directory by default
    poetry config virtualenvs.in-project false

    echo "Poetry installation complete."
    echo "To verify, run: poetry --version"
}

# Function to update Poetry
update_poetry() {
    echo "Updating Poetry..."

    poetry self update

    echo "Poetry update complete."
}

# Function to uninstall Poetry
uninstall_poetry() {
    echo "Uninstalling Poetry..."

    curl -sSL https://install.python-poetry.org | python3 - --uninstall

    echo "Poetry uninstallation complete."
}

set_venv_location() {
    # Set the location of the virtual environment
    if [ -z "$POETRY_VIRTUALENVS_PATH" ]; then
        poetry config virtualenvs.in-project true
    else
        poetry config virtualenvs.path "$POETRY_VIRTUALENVS_PATH"
    fi
}

# Function to enable tab completion
enable_completions() {
    echo "Enabling tab completion for Poetry..."

    # Determine the shell type
    shell=$(basename "$SHELL")

    if [[ "$shell" == "bash" ]]; then
        echo "Enabling Bash completion..."
        poetry completions bash >> ~/.bash_completion
        echo "Tab completion enabled for Bash."

    elif [[ "$shell" == "fish" ]]; then
        echo "Enabling Fish completion..."
        poetry completions fish > ~/.config/fish/completions/poetry.fish
        echo "Tab completion enabled for Fish."

    elif [[ "$shell" == "zsh" ]]; then
        echo "Enabling Zsh completion..."
        poetry completions zsh > ~/.zfunc/_poetry
        # Add necessary lines to ~/.zshrc
        if ! grep -q "fpath+=~/.zfunc" ~/.zshrc; then
            echo "fpath+=~/.zfunc" >> ~/.zshrc
            echo "autoload -Uz compinit && compinit" >> ~/.zshrc
        fi
        echo "Tab completion enabled for Zsh."

    else
        echo "Unsupported shell: $shell. Tab completion can only be enabled for Bash, Fish, or Zsh."
    fi
}

all() {
    install_poetry
    append_to_rc
    enable_completions
}

# Parse the command-line argument
if [ "$#" -ne 1 ]; then
    all
fi

case "$1" in
    install)
        install_poetry
        ;;
    update)
        update_poetry
        ;;
    uninstall)
        uninstall_poetry
        ;;
    setup)
        set_venv_location "$2"
        ;;
    completion)
        enable_completions
        ;;
    append)
        append_to_rc
        ;;
    help)
        usage
        ;;
    *)
        all
        ;;
esac
