# 🧠 Brian Smith's Fedora 43 Developer Setup

![Fedora Logo](https://upload.wikimedia.org/wikipedia/commons/3/3f/Fedora_logo.svg)

[![Fedora](https://img.shields.io/badge/Fedora-43-blue?logo=fedora&logoColor=white&style=flat-square)](https://getfedora.org/)
[![License](https://img.shields.io/github/license/brian-smith-git/Fedora-Dotfiles?style=flat-square)](LICENSE)
[![Made with Bash](https://img.shields.io/badge/Made%20with-Bash-4EAA25?style=flat-square&logo=gnu-bash&logoColor=white)](https://www.gnu.org/software/bash/)
[![Maintainer](https://img.shields.io/badge/Maintainer-Brian%20Smith-lightgrey?style=flat-square)](https://github.com/brian-smith-git)



## 🚀 Overview

This repository provides an **interactive installer** for setting up a **modern Fedora 43 developer environment**.  
It’s designed for **speed, productivity, and terminal efficiency**, offering both **modular** and **complete** system setups.  

Ideal for developers who want a pre-configured, professional Linux workspace out of the box.



## 🧩 Key Features

| Category | Description | Config / Install Location |
|-----------|--------------|----------------------------|
| **Essential Packages** | Core CLI tools (`git`, `zsh`, `curl`, `vim`, etc.) | Installed system-wide via `dnf` |
| **GUI Packages** | Desktop apps, editors, browsers, and utilities | Installed via `dnf` or `flatpak` |
| **Flatpak Apps** | Sandbox-isolated desktop apps | `/var/lib/flatpak` (system) / `$HOME/.local/share/flatpak` (user) |
| **Zsh + Powerlevel10k** | Modern shell with rich prompt and customization | `$HOME/.zshrc`, `$HOME/.p10k.zsh` |
| **Neovim Config** | Developer-optimized configuration for Neovim | `$HOME/.config/nvim/init.lua` or `init.vim` |
| **Tmux Config** | Pre-configured terminal multiplexer | `$HOME/.tmux.conf` |
| **Extras & CLI Tools** | `fzf`, `exa`, `ripgrep`, `bat`, `htop`, `fd-find` | Installed system-wide via `dnf` |
| **Language Managers** | `pyenv`, `rbenv`, `nvm` for managing SDKs | `$HOME/.pyenv`, `$HOME/.rbenv`, `$HOME/.nvm` |
| **Container Tools** | Podman, Docker Compose | Installed system-wide via `dnf` |
| **Terminal Enhancements** | Fastfetch startup info + persistent shell history | `$HOME/.zshrc`, `$HOME/.zsh_history` |



## 📂 File Structure & Config Paths

| File / Directory | Purpose |
|------------------|----------|
| `install.sh` | Main interactive installer script |
| `README.md` | Documentation and setup guide |
| `$HOME/.zshrc` | Zsh configuration + Fastfetch integration |
| `$HOME/.p10k.zsh` | Powerlevel10k theme configuration |
| `$HOME/.config/nvim/` | Neovim configuration directory |
| `$HOME/.tmux.conf` | Tmux configuration file |
| `$HOME/.pyenv` / `.rbenv` / `.nvm` | Language managers and SDKs |



## 💡 Notes & Recommendations

- You can **rerun the installer** anytime to add or update components.  
- The **“Full Install”** option automatically installs everything and exits when complete.  
- Designed for **Fedora 43**, but compatible with newer releases.  
- Suitable for **beginners** and **advanced developers** seeking a clean, powerful environment.



## ⚙️ Installation & Setup Guide

Follow these steps to install and configure your Fedora 43 development environment.



### 🧭 Step 1: Clone the Repository

```bash
git clone https://github.com/brian-smith-git/Fedora-Dotfiles.git
cd Fedora-Dotfiles

This creates a local copy of the project on your system.




## ⚙️ Step 2: Make the Installer Executable

chmod +x install.sh

This gives the script execution permissions so it can be run directly.




🚀 Step 3: Run the Installer

./install.sh

After launching, an interactive setup menu will appear:

=======================================
 Brian Smith's Fedora 43 Dev Installer
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

Select one or more categories — or choose 10 for a full installation.




## 🧠 After-Installation Configuration

⚡ Powerlevel10k Setup

After installation, start a new terminal and launch Zsh:

zsh or p10k configure 

This opens the Powerlevel10k configuration wizard, allowing you to personalize your prompt’s icons, colors, and layout.




🖥️ Fastfetch & Command History

Fastfetch runs on startup to show system info (added to $HOME/.zshrc).

Persistent command history keeps a record of all terminal sessions ($HOME/.zsh_history).


These features are enabled automatically after installation.




### ✅ After Installation

Once setup completes, your Fedora 43 system will include:

A Zsh shell with Powerlevel10k and autosuggestions

Fastfetch displaying system information at startup

A Neovim configuration optimized for coding productivity

A pre-configured Tmux layout for multitasking

Installed language managers (pyenv, rbenv, nvm)

Fully configured Podman and Docker Compose for containers


You can start customizing your environment or rerun the installer anytime to add more components.




👨‍💻 Maintainer

Maintained by: Brian Smith
Repository: Fedora-Dotfiles
License: MIT




⭐ If you find this setup useful, consider starring the repository to support future updates!
