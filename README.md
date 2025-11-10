# Brian Smith Fedora 43 Developer Setup

![Fedora Logo](https://upload.wikimedia.org/wikipedia/commons/3/3f/Fedora_logo.svg)

## 🚀 Overview

This repository provides an **interactive installer** for setting up a **complete Fedora 43 developer environment**.  
The goal is to quickly set up a modern, fully functional development system optimized for productivity, terminal efficiency, and coding convenience.

---

## 🛠 Features

The installer can optionally install each category or perform a **full setup**, including:

| Category | What it includes | Where files/configs are stored |
|----------|-----------------|-------------------------------|
| **Essential Packages** | git, zsh, curl, wget, vim, tmux, ripgrep, fd-find, fzf, htop, bat, exa | Installed system-wide via `dnf` |
| **GUI Packages** | Common GUI apps (editors, browsers, utilities) | Installed via `dnf` or `flatpak` |
| **Flatpak Apps** | Flatpak versions of apps | `/var/lib/flatpak` for system-wide, `$HOME/.local/share/flatpak` for user |
| **Zsh + Powerlevel10k** | Zsh shell + Powerlevel10k prompt | `$HOME/.zshrc`, `$HOME/.p10k.zsh` |
| **Neovim Config** | Custom Neovim configuration | `$HOME/.config/nvim/init.vim` or `$HOME/.config/nvim/init.lua` |
| **Tmux Config** | Tmux configuration | `$HOME/.tmux.conf` |
| **Extras & Productivity Tools** | fzf, bat, htop, exa, ripgrep, fd-find | Installed system-wide via `dnf` |
| **Language Managers & SDKs** | pyenv, rbenv, nvm | Installed under `$HOME/.pyenv`, `$HOME/.rbenv`, `$HOME/.nvm` |
| **Container Tools** | Podman, Docker Compose | Installed system-wide via `dnf` |
| **Terminal Enhancements** | Fastfetch on startup, persistent history | Fastfetch added to `$HOME/.zshrc`, history managed via `$HOME/.zsh_history` |

---

## 🎯 Usage

### 1. Clone the repository

```bash
git clone https://github.com/brian-smith-git/Fedora-Dotfiles.git
cd Fedora-Dotfiles

2. Make the installer executable

chmod +x install.sh

3. Run the installer

./install.sh

The installer will show an interactive menu:

=======================================
Brian Smith Fedora 43 Dev Installer
=======================================
Select what to install:
  1) Essential Packages
  2) GUI Packages
  3) Flatpak Apps
  4) Zsh + Powerlevel10k
  5) Neovim Config
  6) Tmux Config
  7) Extras & Productivity Tools
  8) Language Managers & SDKs
  9) Container Tools
 10) Install Everything
 11) Quit
=======================================

Choose the option you want to install, or 10 for a full setup.
4. Powerlevel10k Setup

If you installed Zsh + Powerlevel10k, start a new terminal and run:

zsh

This will launch the Powerlevel10k setup wizard, allowing you to configure your prompt interactively.
5. Fastfetch and History

    Fastfetch will display system information whenever a terminal is opened. This is automatically added to your $HOME/.zshrc.

    Zsh history persistence is enabled, storing commands in $HOME/.zsh_history for future sessions.

6. File Locations

All configuration and installer files are stored as follows:

    install.sh – main installer script

    README.md – documentation

    $HOME/.zshrc – Zsh configuration including Fastfetch and history settings

    $HOME/.p10k.zsh – Powerlevel10k prompt configuration

    $HOME/.config/nvim/ – Neovim configuration

    $HOME/.tmux.conf – Tmux configuration

    Language managers (pyenv, rbenv, nvm) – stored in user home directories

💡 Notes

    You can rerun the installer at any time to install additional packages.

    The full install option exits automatically after finishing — no need to manually select "Quit".

    This setup is optimized for Fedora 43 and is suitable for developers of all skill levels.

