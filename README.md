# 🧠 Brian Smith's Fedora 43 Developer Setup

![Fedora Logo](https://upload.wikimedia.org/wikipedia/commons/3/3f/Fedora_logo.svg)

---

## 🚀 Overview

This repository provides an **interactive installer** for configuring a **complete Fedora 43 developer environment**.  
It’s designed for **speed, productivity, and terminal efficiency**, offering both **modular** and **full system setups**.

---

## 🧩 Key Features

| Category | Description | Config / Install Location |
|-----------|--------------|----------------------------|
| **Essential Packages** | Core CLI tools (`git`, `zsh`, `curl`, `vim`, etc.) | Installed system-wide via `dnf` |
| **GUI Packages** | Desktop productivity apps (editors, browsers, utilities) | Installed via `dnf` or `flatpak` |
| **Flatpak Apps** | Flatpak-managed desktop apps | `/var/lib/flatpak` (system) / `$HOME/.local/share/flatpak` (user) |
| **Zsh + Powerlevel10k** | Modern shell setup with theme and prompt customization | `$HOME/.zshrc`, `$HOME/.p10k.zsh` |
| **Neovim Config** | Custom developer-ready Neovim configuration | `$HOME/.config/nvim/init.lua` or `init.vim` |
| **Tmux Config** | Terminal multiplexer configuration | `$HOME/.tmux.conf` |
| **Extras & Productivity Tools** | Includes `fzf`, `exa`, `ripgrep`, `bat`, `htop`, `fd-find` | Installed system-wide via `dnf` |
| **Language Managers** | `pyenv`, `rbenv`, `nvm` for Python, Ruby, Node.js | `$HOME/.pyenv`, `$HOME/.rbenv`, `$HOME/.nvm` |
| **Container Tools** | Podman, Docker Compose | Installed via `dnf` |
| **Terminal Enhancements** | `fastfetch`, persistent history | Configured in `$HOME/.zshrc` and `$HOME/.zsh_history` |

---

## ⚙️ Installation Guide

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/brian-smith-git/Fedora-Dotfiles.git
cd Fedora-Dotfiles


---

2️⃣ Make the Installer Executable

chmod +x install.sh


---

3️⃣ Run the Installer

./install.sh

You’ll see an interactive menu like this:

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

➡️ Choose the option(s) you want — or select 10 for a full developer setup.


---

🧠 Post-Install Configuration

⚡ Powerlevel10k Setup

After installing Zsh + Powerlevel10k, open a new terminal and run:

zsh

The Powerlevel10k wizard will guide you through prompt customization interactively.


---

🖥️ Fastfetch & History

Fastfetch automatically runs on terminal launch to display system info.
↳ Configured in $HOME/.zshrc.

Persistent Zsh history is enabled.
↳ Commands are stored in $HOME/.zsh_history for future sessions.



---

📂 File Structure & Config Paths

File / Directory	Purpose

install.sh	Main interactive installer script
README.md	Project documentation
$HOME/.zshrc	Zsh configuration + Fastfetch integration
$HOME/.p10k.zsh	Powerlevel10k theme configuration
$HOME/.config/nvim/	Neovim configuration files
$HOME/.tmux.conf	Tmux configuration
$HOME/.pyenv / .rbenv / .nvm	Language managers and SDKs



---

💡 Notes & Tips

You can rerun the installer anytime to add or update specific packages.

The “Full Install” option completes all setup steps and exits automatically.

Optimized for Fedora 43, but most configurations are forward-compatible with newer releases.

Suitable for developers of all levels — from fresh setups to advanced workstations.



---

🧑‍💻 Maintained by: Brian Smith
🌐 Repository: Fedora-Dotfiles