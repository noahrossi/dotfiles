#!/bin/bash
set -euo pipefail

# OS detection
if [[ "$(uname)" == "Darwin" ]]; then
    INSTALL_CMD="brew install"
elif command -v apt-get &>/dev/null; then
    INSTALL_CMD="sudo apt-get install -y"
    sudo apt-get update -y
else
    echo "Unsupported OS: no apt-get or brew found"
    exit 1
fi

# Install system packages (idempotent)
for pkg in tmux vim zip; do
    if ! command -v "$pkg" &>/dev/null; then
        $INSTALL_CMD "$pkg"
    fi
done

# Install uv
if ! command -v uv &>/dev/null; then
    curl -LsSf https://astral.sh/uv/install.sh | sh
fi

# Install Claude Code
if ! command -v claude &>/dev/null; then
    curl -fsSL https://claude.ai/install.sh | bash
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc && source ~/.bashrc
fi

# Install HuggingFace CLI
if ! command -v huggingface-cli &>/dev/null; then
    uv tool install 'huggingface_hub[cli]'
fi

echo ""
echo "Install complete! Run ./deploy.sh next."
