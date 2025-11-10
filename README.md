# Brian Smith Fedora 43 Dev Setup

> Streamlined Fedora 43 developer environment setup with an interactive installer. Install only what you need or set up everything with one command. Includes Zsh, Powerlevel10k, Neovim, Tmux, container tools, language managers, and more.  

---

## Features

- Interactive installer with **Powerlevel10k-style menu**  
- Automatic setup of essential packages & productivity tools  
- Zsh + Oh-My-Zsh + Powerlevel10k configured  
- Persistent shell history & Fastfetch on startup  
- Neovim & Tmux configuration preloaded  
- Python, Node, Rust language managers included  
- Container tools: Docker & Podman  
- Flatpaks for common GUI apps  
- “Install Everything” option for full dev environment  

---

## Requirements

- Fedora 43  
- Sudo privileges  

---

## Installation

```bash
git clone https://github.com/brian-smith-git/Fedora-Dotfiles.git
cd Fedora-Dotfiles
chmod +x install.sh
./install.sh
