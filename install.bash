#!/usr/bin/env bash

# Adds $1 to ~/.bashrc if not already present
function _add_to_config {
    if ! grep "$1" ~/.bashrc > /dev/null; then
        echo "$1" >> ~/.bashrc
    fi
}

# Link files
basedir="$(dirname "$(realpath "$0")")"
mkdir -p ~/.local/bin
ln -frs "${basedir}/gis" ~/.local/bin/gis
echo "Created link '~/.local/bin/gis'"

# Modify bashrc
touch ~/.bashrc
_add_to_config "export PATH=\$PATH:/home/${USER}/.local/bin"
echo "Updated '~/.bashrc'"

echo
echo "Source ~/.bashrc to use gis"
echo "To update gis in future execute 'git pull' in '${basedir}'"
