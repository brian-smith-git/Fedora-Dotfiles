# 🧠 Brian Smith’s Fedora 43 Workstation Dotfiles

This repository contains my **personal dotfiles and configuration scripts** for a professional-grade development setup on **Fedora 43 Workstation**.  
It’s designed for developers who want a **fast, reproducible, and minimal** environment with:

- ⚡ Zsh + Powerlevel10k  
- 🧩 Neovim, Tmux, and productivity plugins  
- 🖥️ GPU-accelerated terminals (Kitty or Alacritty)  
- 🧠 Smart aliases, secure history settings, and system-safe backups  

---

## 🚀 Highlights

- ✅ Updated and tested for **Fedora 43 Workstation (GNOME / Wayland)**  
- 🧾 Automated install script with **backups and safety checks**  
- 🧮 Modern CLI tools (`fd-find`, `eza`, `fzf`, `ripgrep`, `bat`)  
- 🧱 Clean defaults for Zsh, Neovim, Tmux, and GPU terminals  
- 🔒 Non-destructive setup: automatically backs up old configs  
- 🧩 Supports local overrides via `~/.zshrc.local`

---

## 🛠️ Features Overview

### 🐚 Shell & Productivity
- **Zsh** with **Oh My Zsh**
- **Powerlevel10k** theme for a clean, fast prompt
- Plugins: `zsh-autosuggestions`, `zsh-syntax-highlighting`, completions
- Handy aliases:
  - Git: `gs`, `gc`, `ga`, `gp`, `gl`
  - Edit: `v` → `nvim`
  - System updates: `update` → runs DNF + Flatpak
- Secure history handling and privacy-friendly defaults

---

### 📝 Neovim Editor
- Line & relative numbering
- Consistent tab / indent width
- Modern defaults and LSP-ready config
- Optimized for speed and readability

---

### 🧮 Terminal
- GPU acceleration via **Kitty** / **Alacritty**
- GNOME Terminal fallback support
- Pre-tuned themes and fonts for developer readability

---

### 🧩 Tmux
- Mouse and extended scroll-back
- Vi-style navigation
- Quick reload with `<prefix> r`
- Seamless terminal integration

---

## 📂 Tracked Files

| File / Directory | Description |
|------------------|-------------|
| `~/.zshrc` | Main Zsh configuration |
| `~/.p10k.zsh` | Powerlevel10k prompt config |
| `~/.gitconfig` | Git settings |
| `~/.tmux.conf` | Tmux configuration |
| `~/.config/nvim/` | Neovim config tree |
| `~/.config/kitty/` / `~/.config/alacritty/` | Terminal configs |
| `install.sh` | Automated setup script |

> Temporary files, caches, and histories are intentionally ignored to keep the repo clean.

---

## 🧰 Installation / Setup

### 1️⃣ Clone the Repository
```bash
git clone https://github.com/brian-smith-git/Fedora-Dotfiles.git ~/.dotfiles
cd ~/.dotfiles

2️⃣ Run the Installer

chmod +x install.sh
./install.sh

The installer will:

    Confirm Fedora 43 release

    Update and refresh packages

    Install core tools (git, zsh, neovim, tmux, kitty, alacritty, fzf, ripgrep, bat, fd-find, eza, etc.)

    Install and configure Flatpak + Flathub

    Install Oh My Zsh (non-interactive)

    Set Zsh as the default shell

    Backup existing dotfiles before linking

    Apply symlinks from ~/Fedora-Dotfiles/

    ⚠️ Note: The script warns if run on a different Fedora version.
    Designed for Fedora 43 Workstation (GNOME / Wayland), but it should also work on most Fedora Spins with minor adjustments.

3️⃣ Post-Install Steps

After the installer finishes:

p10k configure

Follow the on-screen wizard to customize your Powerlevel10k prompt.

Then restart your terminal session to activate Zsh.
🔧 Customization & Maintenance

    Update your dotfiles:

cd ~/.dotfiles && git pull

Add machine-specific tweaks (without touching the repo):

nano ~/.zshrc.local

Keep Fedora up to date:

    update

🧩 Troubleshooting / Tips

    If you see a version warning, you’re likely running a different Fedora release—most commands will still work.

    Wayland-only GNOME is the default in Fedora 43; Kitty and Alacritty both support Wayland natively.

    If using an NVIDIA GPU and encounter rendering issues, launch your terminal with --enable-wayland or force XWayland mode.

🧾 License

MIT License — You are free to fork, modify, and share with attribution.
💬 Feedback / Contributions

Found a bug or want to suggest an improvement?

    Open an issue or pull request on GitHub:
    https://github.com/brian-smith-git/Fedora-Dotfiles

Enjoy your streamlined Fedora 43 Workstation! 🚀


---

### ✅ To apply and publish this update

1. Open your repo:
   ```bash
   cd ~/Fedora-Dotfiles
# Brian Smith's Fedora Workstation Dotfiles

This repository contains my **personal dotfiles and configurations** for a professional development environment on **Fedora 42 Workstation**.  

It’s designed for developers and creators who want a **fast, organized, and reproducible setup** with **Zsh, Powerlevel10k, Neovim, Tmux**, fastfetch on startup, and GPU-accelerated terminal emulators like **Kitty** or **Alacritty**.

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


