# Brian Smith's Fedora 42 Workstation Dotfiles

This repository contains my personal **dotfiles and configurations** for a professional development environment on Fedora 42 Workstation.  

It is designed for **Zsh with Oh My Zsh**, **Powerlevel10k**, **Neovim**, **Tmux**, and popular terminal emulators like **Kitty** or **Alacritty**. The setup is optimized for **productivity, privacy, and portability**.

---

## Features

- **Zsh & Oh My Zsh**
  - Powerlevel10k prompt theme
  - Autosuggestions, syntax highlighting, completions
  - Custom aliases for git, system updates, and editing

- **Neovim**
  - Basic Lua config with sane defaults
  - Line numbers, relative numbers, and modern editing features

- **Tmux**
  - Mouse support, history scrollback, vi-style navigation
  - Easy reload of config

- **Terminal**
  - Compatible with Kitty, Alacritty, and GNOME Terminal
  - GPU-accelerated rendering for fast workflows (Kitty/Alacritty)

- **Install Script**
  - One-command setup for Fedora 42 systems
  - Automatically installs essentials, sets Zsh, pulls dotfiles, and applies configs

---

## Installation

Clone the repository and run the install script:

```bash
git clone https://github.com/brian-smith-git/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
