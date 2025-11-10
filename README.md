# Brian Smith's Fedora Workstation Dotfiles

This repository contains my personal dotfiles and configurations for a professional development environment on **Fedora 43 Workstation**.

It’s designed for developers and creators who want a fast, organized, and reproducible setup with Zsh, ⚡ **Powerlevel10k**, Neovim, Tmux, fastfetch on startup, and GPU-accelerated terminal emulators like Kitty or Alacritty.

---

## Features

### Shell & Productivity

- Zsh with Oh My Zsh
- ⚡ **Powerlevel10k prompt theme automatically installed and configured**
- Plugins: autosuggestions, syntax highlighting, completions
- Custom aliases for:
  - Git (`gs`, `gc`, `ga`, `gp`, `gl`)
  - Editing (`v` → nvim)
  - System updates (`update` → dnf + flatpak)
- Secure history settings for privacy

### Editor

- Neovim
  - Line numbers & relative numbers
  - Expand tabs and shift width configured
  - Modern defaults for faster coding

### Terminal

- Supports Kitty, Alacritty, and GNOME Terminal
- GPU-accelerated rendering in Kitty/Alacritty
- Optional Tmux integration with mouse and scrollback support

### Tmux

- Mouse support enabled
- History scrollback increased
- Reloadable configuration
- Vi-style navigation

### Install Script

- One-command setup for **Fedora 43 systems**
- Installs essential packages: git, zsh, neovim, tmux, ripgrep, fd, fzf, stow, flatpak
- Installs optional GUI packages: Alacritty, Kitty, Firefox
- Sets default shell to Zsh
- Pulls dotfiles and applies configs automatically
- Creates backups of existing configs with `.bak` suffix
- Installs Oh My Zsh and ⚡ **Powerlevel10k if missing**
- Installs common Flatpak apps from Flathub: VSCode, Spotify, Slack

---

## Tracked Dotfiles

- `~/.zshrc` → Zsh configuration
- `~/.p10k.zsh` → ⚡ **Powerlevel10k prompt config**
- `~/.gitconfig` → Git configuration
- `~/.tmux.conf` → Tmux config
- `~/.config/nvim/` → Neovim configuration
- `~/.config/kitty/` or `~/.config/alacritty/` → Terminal configs
- `install.sh` → Automated setup script

Other files are ignored to keep the repository clean (history, cache, browser data, etc.).

---

## Installation

```bash
git clone https://github.com/brian-smith-git/Fedora-Dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
