# dotfiles

Quick setup for ephemeral compute environments (Lambda, Runpod, etc.).

## Usage

```bash
git clone https://github.com/noahrossi/dotfiles.git
cd dotfiles
./install.sh   # Install tools
./deploy.sh    # Deploy configs + credentials
```

### install.sh

Installs system packages and CLI tools:
- tmux, vim, zip
- [uv](https://github.com/astral-sh/uv)
- [Claude Code](https://claude.ai)
- [HuggingFace CLI](https://huggingface.co/docs/huggingface_hub/guides/cli)

Detects OS automatically (apt-get on Linux, brew on Mac). Skips anything already installed.

### deploy.sh

Configures the environment:
- Git identity + GitHub token auth
- Optional HuggingFace authentication (with custom `HF_HOME` support)
- tmux config (mouse, 256 colors)
- Bash settings (`vi` mode, `TERM=xterm-256color`)

## Acknowledgments

Inspired by [andyrdt/dotfiles](https://github.com/andyrdt/dotfiles).
