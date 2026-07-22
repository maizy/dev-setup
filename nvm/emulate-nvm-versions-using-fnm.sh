#!/bin/zsh

NVM_NODE_DIR="$HOME/.nvm/versions/node"
mkdir -p "$NVM_NODE_DIR"

cd "$NVM_NODE_DIR"
for installation in "$HOME"/.local/share/fnm/node-versions/*/installation(N/); do
    version=${installation:h:t}
    [[ -L $version ]] && echo "Update $version -> $installation" && rm "$version"
    [[ -e $version ]] && { echo "Skip: $version"; continue; }
    ln -s "$installation" "$version"
done