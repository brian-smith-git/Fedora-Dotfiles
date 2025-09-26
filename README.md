# Brian Smith's Fedora 42 Workstation Dotfiles

This repository contains my **personal dotfiles and configurations** for a professional development environment on **Fedora 42 Workstation**.  

It’s designed for developers and creators who want a **fast, organized, and reproducible setup** with **Zsh, Powerlevel10k, Neovim, Tmux**, and GPU-accelerated terminal emulators like **Kitty** or **Alacritty**.

---

## Features

### Shell & Productivity
- **Zsh** with **Oh My Zsh**
- **Powerlevel10k** prompt theme
- Plugins: autosuggestions, syntax highlighting, completions
- Custom aliases for:
  - Git (`gs`, `gc`, `ga`, `gp`, `gl`)
  - Editing (`v` → nvim)
  - System updates (`update` → dnf + flatpak)
- Secure history settings for privacy

### Editor
- **Neovim**
  - Line numbers & relative numbers
  - Expand tabs and shift width configured
  - Modern defaults for faster coding

### Terminal
- Supports **Kitty**, **Alacritty**, and **GNOME Terminal**
- GPU-accelerated rendering in Kitty/Alacritty
- Optional Tmux integration with mouse and scrollback support

### Tmux
- Mouse support enabled
- History scrollback increased
- Reloadable configuration
- Vi-style navigation

### Install Script
- One-command setup for Fedora 42 systems
- Installs essentials: git, zsh, neovim, tmux, ripgrep, fd, fzf, etc.
- Sets default shell to Zsh
- Pulls dotfiles and applies configs automatically
- Creates backups of existing configs

---

## Tracked Dotfiles

The repository currently tracks:

- `~/.zshrc` → Zsh configuration  
- `~/.p10k.zsh` → Powerlevel10k prompt config  
- `~/.gitconfig` → Git configuration  
- `~/.tmux.conf` → Tmux config  
- `~/.config/nvim/` → Neovim configuration  
- `~/.config/kitty/` or `~/.config/alacritty/` → Terminal configs  
- `install.sh` → Automated setup script

Other files are ignored to keep the repository clean (history, cache, browser data, etc.).

---

## Installation

Clone the repository and run the **install script**:

```bash
git clone https://github.com/brian-smith-git/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh

After installation, restart your terminal and configure Powerlevel10k:

p10k configure


