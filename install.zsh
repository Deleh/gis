#!/usr/bin/env zsh

# Check 'column' dependency
if ! command -v column &> /dev/null; then
    echo "Command 'column' not available on the system, please make sure all dependencies are fulfilled."
    exit 1
fi

# Adds $1 to ~/.zshrc if not already present
function _add_to_config {
    if ! grep "$1" ~/.zshrc > /dev/null; then
        echo "$1" >> ~/.zshrc
    fi
}

# Link files
basedir="$(dirname "$(realpath "$0")")"
mkdir -p ~/.local/{bin,share/bash-completion/completions}
ln -fs "${basedir}/gis" ~/.local/bin/gis
echo "Created link '~/.local/bin/gis'"
ln -fs "${basedir}/gis_completion.bash" ~/.local/share/bash-completion/completions/gis
echo "Created link '~/.local/share/bash-completion/completions/gis'"

# Modify config
touch ~/.zshrc
_add_to_config "export PATH=\$PATH:${HOME}/.local/bin"
_add_to_config "autoload -U +X compinit && compinit"
_add_to_config "autoload -U +X bashcompinit && bashcompinit"
_add_to_config "source ${HOME}/.local/share/bash-completion/completions/gis"
echo "Updated '~/.zshrc'"

echo
echo "Source ~/.zshrc to use gis"
echo "To update gis in future execute 'git pull' in '${basedir}'"
