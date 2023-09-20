#!/usr/bin/env zsh

# Adds $1 to ~/.zshrc if not already present
function _add_to_config {
    if ! grep "$1" ~/.zshrv > /dev/null; then
        echo "$1" >> ~/.zshrc
    fi
}

# Link files
basedir="$(dirname "$(realpath "$0")")"
mkdir -p ~/.local/{bin,share/bash-completion/completions}
ln -frs "${basedir}/gis" ~/.local/bin/gis
echo "Created link '~/.local/bin/gis'"

# Modify config
touch ~/.zshrc
_add_to_config "export PATH=\$PATH:${HOME}/.local/bin"
echo "Updated '~/.zshrc'"

echo
echo "Source ~/.zshrc to use gis"
echo "To update gis in future execute 'git pull' in '${basedir}'"
