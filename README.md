# 🐧 Fedora 43 Dotfiles & Dev Setup

**Brian Smith’s Fedora 43 Developer Workstation**  
Fully automated dotfiles, tools, and configs for a **fast, efficient, and modern development environment**.

---

## 🚀 Features

### Terminal & Shell
- **Zsh** with **Oh My Zsh**  
- **Powerlevel10k** prompt for a beautiful, informative terminal  
- Persistent terminal history and command sharing across sessions  
- Plugins: `zsh-autosuggestions`, `zsh-syntax-highlighting`  
- **fastfetch** runs on terminal startup for instant system info  

### Essential Tools
- CLI: `git`, `curl`, `wget`, `vim`, `tmux`, `neovim`, `stow`, `ripgrep`, `fd-find`, `fzf`, `htop`, `bat`, `exa`, `tree`, `neofetch`  
- GUI: `kitty`, `alacritty`, `firefox`  

### Productivity Apps
- Flatpak apps: **VSCode**, **Spotify**, **Slack**  

### Developer Configs
- Neovim: `~/.config/nvim`  
- Tmux: `~/.tmux.conf`  
- Zsh: `~/.zshrc` + `.p10k.zsh`  

### Language & SDK Managers
- Python: `pyenv`  
- Node.js: `nvm`  
- Rust: `rustup`  

### Containers
- Docker (enabled and running)  
- Podman  

---

## ⚡ Installation

### 1️⃣ Clone the repository

```bash
git clone https://github.com/brian-smith-git/Fedora-Dotfiles.git
cd Fedora-Dotfiles

2️⃣ Run the installer
Interactive Mode

./install.sh

    Follow the menu to choose what to install

    Select All to install everything automatically

Non-Interactive Mode

./install.sh -a

    Installs everything automatically including:

        Terminal setup & Zsh enhancements

        Dev tools & GUI apps

        Language managers & containers

        Productivity apps

⚙️ Post-Installation

    Restart the terminal to start using Zsh with Powerlevel10k

    fastfetch appears automatically at terminal startup

    Source .zshrc if needed:

source ~/.zshrc

💡 Optional Extras

    Docker Compose

    VSCode extensions

    Nerd Fonts for Powerlevel10k symbols

    Database clients (PostgreSQL, MySQL, Redis CLI)

These can be installed manually or integrated into the installer.
🤝 Contributing

    Fork this repo

    Make improvements

    Open a pull request

Please ensure Fedora 43 compatibility for all changes.
