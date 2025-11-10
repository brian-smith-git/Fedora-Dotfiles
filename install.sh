#!/usr/bin/env bash
set -euo pipefail

# ========================================
# My Fedora 43+ Dotfiles Install Script 
# ========================================

# 1. Check Fedora version
FEDORA_VERSION=$(rpm -E %fedora)
if [ "$FEDORA_VERSION" -lt 43 ]; then
    echo "This script requires Fedora 43 or newer."
    exit 1
fi
echo "Running on Fedora $FEDORA_VERSION"

# 2. Helper functions
backup_file() {
    local file="$1"
    if [ -e "$file" ] || [ -L "$file" ]; then
        echo "Backing up $file -> ${file}.bak"
        mv "$file" "${file}.bak"
    fi
}

symlink_file() {
    local src="$1"
    local dest="$2"
    backup_file "$dest"
    ln -sf "$src" "$dest"
    echo "Symlinked $src -> $dest"
}

install_package() {
    local pkg="$1"
    if ! rpm -q "$pkg" &>/dev/null; then
        echo "Installing package: $pkg"
        sudo dnf install -y "$pkg"
    else
        echo "Package already installed: $pkg"
    fi
}

install_flatpak_app() {
    local app="$1"
    if ! flatpak info "$app" &>/dev/null; then
        echo "Installing Flatpak app: $app"
        flatpak install -y flathub "$app"
    else
        echo "Flatpak app already installed: $app"
    fi
}

# 3. Update system
echo "Updating system..."
sudo dnf update -y

# 4. Install essential packages
ESSENTIAL_PACKAGES=(git zsh curl wget vim tmux neovim stow flatpak)
echo "Installing essential packages..."
for pkg in "${ESSENTIAL_PACKAGES[@]}"; do
    install_package "$pkg"
done

# 5. Optional GUI packages
GUI_PACKAGES=(alacritty kitty firefox)
echo "Installing optional GUI packages..."
for pkg in "${GUI_PACKAGES[@]}"; do
    install_package "$pkg" || echo "Warning: $pkg may not be available."
done

# 6. Enable Flathub repo if missing
if ! flatpak remotes | grep -q flathub; then
    echo "Adding Flathub repository..."
    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
fi

# 7. Install common Flatpak apps
FLATPAK_APPS=(
    com.visualstudio.code
    com.spotify.Client
    com.slack.Slack
)
echo "Installing Flatpak apps..."
for app in "${FLATPAK_APPS[@]}"; do
    install_flatpak_app "$app"
done

# 8. Install Oh My Zsh if missing
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "Oh My Zsh already installed."
fi

# 9. Install Powerlevel10k theme if missing
if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
    echo "Installing Powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
        "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
else
    echo "Powerlevel10k already installed."
fi

# 10. Change default shell to Zsh
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Changing default shell to Zsh..."
    chsh -s "$(which zsh)" || echo "You may need to run 'chsh -s $(which zsh)' manually."
fi

# 11. Symlink dotfiles
DOTFILES_DIR="$(pwd)/dotfiles"
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "Error: dotfiles directory not found in $(pwd)/dotfiles"
    exit 1
fi

echo "Creating symlinks for dotfiles..."
for file in "$DOTFILES_DIR"/.*; do
    filename=$(basename "$file")
    # Skip . and .. and .git
    [[ "$filename" == "." || "$filename" == ".." || "$filename" == ".git" ]] && continue
    symlink_file "$file" "$HOME/$filename"
done

# 12. Final message
echo "======================================="
echo "Dotfiles setup complete for Fedora $FEDORA_VERSION!"
echo "Backups of existing files have .bak suffix."
echo "Restart your terminal to start using Zsh and Powerlevel10k."
echo "Flatpak apps installed: ${FLATPAK_APPS[*]}"
echo "======================================="
