#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Git identity
git config --global user.email "me@noahrossi.com"
git config --global user.name "Noah Rossi"

# GitHub token
read -sp "Enter your GitHub token (create at: https://github.com/settings/tokens): " github_token
echo ""

git config --global credential.helper store
echo "https://oauth2:${github_token}@github.com" > "$HOME/.git-credentials"
chmod 600 "$HOME/.git-credentials"

# Optional HuggingFace auth
read -p "Set up HuggingFace authentication? (y/N): " hf_auth
if [[ "${hf_auth,,}" == "y" ]]; then
    read -p "Custom HF_HOME directory? (leave blank for default): " hf_home
    if [[ -n "$hf_home" ]]; then
        mkdir -p "$hf_home"
        echo "export HF_HOME=\"$hf_home\"" >> "$HOME/.bashrc"
        export HF_HOME="$hf_home"
    fi
    huggingface-cli login
fi

# Deploy tmux config
echo "source-file $SCRIPT_DIR/config/tmux.conf" > "$HOME/.tmux.conf"

# Bash config
{
    echo 'export TERM=xterm-256color'
    echo 'set -o vi'
} >> "$HOME/.bashrc"

echo ""
echo "Deploy complete! Restart your terminal or run: exec bash"
