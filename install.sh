#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(pwd)"

# -----------------------------------------
# Helper Functions
# -----------------------------------------

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

# -----------------------------------------
# Full Installation (Non-Interactive)
# -----------------------------------------

install_all() {
    echo "======================================="
    echo "Running full Fedora 43 developer setup..."
    echo "======================================="

    # Add Flathub if missing
    if ! flatpak remotes | grep -q flathub; then
        sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    fi

    # Essential CLI tools
    ESSENTIAL_PACKAGES=(git zsh curl wget vim tmux neovim stow ripgrep fd-find fzf htop bat exa tree neofetch)
    for pkg in "${ESSENTIAL_PACKAGES[@]}"; do install_package "$pkg"; done

    # GUI Tools
    GUI_PACKAGES=(kitty alacritty firefox)
    for pkg in "${GUI_PACKAGES[@]}"; do install_package "$pkg"; done

    # Flatpak Apps
    FLATPAK_APPS=(com.visualstudio.code com.spotify.Client com.slack.Slack)
    for app in "${FLATPAK_APPS[@]}"; do install_flatpak_app "$app"; done

    # Zsh + Oh My Zsh
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi

    # Powerlevel10k
    if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
    fi
    symlink_file "$DOTFILES_DIR/.p10k.zsh" "$HOME/.p10k.zsh"
    symlink_file "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"

    # Zsh plugins
    ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
    [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] && git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
    [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

    # Persistent history
    if ! grep -q "HISTSIZE" "$HOME/.zshrc"; then
        cat <<'EOF' >> "$HOME/.zshrc"

# Persistent history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt append_history
setopt share_history
EOF
    fi

    # fastfetch
    if ! command -v fastfetch &>/dev/null; then
        sudo dnf install -y fastfetch || echo "Install fastfetch manually if unavailable"
    fi
    if ! grep -q "fastfetch" "$HOME/.zshrc"; then
        echo "fastfetch" >> "$HOME/.zshrc"
    fi

    # Config files
    mkdir -p "$HOME/.config"
    symlink_file "$DOTFILES_DIR/.config/nvim" "$HOME/.config/nvim"
    symlink_file "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"

    # Language managers
    command -v pyenv >/dev/null 2>&1 || curl https://pyenv.run | bash
    command -v nvm >/dev/null 2>&1 || curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    command -v rustup >/dev/null 2>&1 || curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

    # Containers
    install_package docker
    sudo systemctl enable --now docker
    install_package podman

    # Set Zsh as default
    if [ "$SHELL" != "$(which zsh)" ]; then
        chsh -s "$(which zsh)" || echo "Run 'chsh -s $(which zsh)' manually."
    fi

    echo "======================================="
    echo "✅ Fedora 43 developer setup complete!"
    echo "Restart terminal to start using Zsh, Powerlevel10k, and fastfetch."
    echo "======================================="
}

# -----------------------------------------
# Interactive Menu
# -----------------------------------------

if [[ "${1:-}" == "-a" ]]; then
    install_all
    exit 0
fi

options=(
"Essential Packages"
"GUI Packages"
"Flatpak Apps"
"Zsh + Powerlevel10k"
"Neovim Config"
"Tmux Config"
"Extras & Productivity Tools"
"Language Managers & SDKs"
"Container Tools"
"All"
"Quit"
)

echo "======================================="
echo "Brian Smith Fedora 43 Dev Setup Installer"
echo "Interactive mode"
echo "======================================="

select opt in "${options[@]}"; do
    case $opt in
        "Essential Packages")
            ESSENTIAL_PACKAGES=(git zsh curl wget vim tmux neovim stow ripgrep fd-find fzf htop bat exa tree neofetch)
            for pkg in "${ESSENTIAL_PACKAGES[@]}"; do install_package "$pkg"; done
            ;;
        "GUI Packages")
            GUI_PACKAGES=(kitty alacritty firefox)
            for pkg in "${GUI_PACKAGES[@]}"; do install_package "$pkg"; done
            ;;
        "Flatpak Apps")
            FLATPAK_APPS=(com.visualstudio.code com.spotify.Client com.slack.Slack)
            for app in "${FLATPAK_APPS[@]}"; do install_flatpak_app "$app"; done
            ;;
        "Zsh + Powerlevel10k")
            install_all  # Non-interactive sub-run to reuse setup logic
            ;;
        "Neovim Config")
            mkdir -p "$HOME/.config"
            symlink_file "$DOTFILES_DIR/.config/nvim" "$HOME/.config/nvim"
            ;;
        "Tmux Config")
            symlink_file "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"
            ;;
        "Extras & Productivity Tools")
            EXTRA_PACKAGES=(htop bat exa tree neofetch)
            for pkg in "${EXTRA_PACKAGES[@]}"; do install_package "$pkg"; done
            ;;
        "Language Managers & SDKs")
            install_all
            ;;
        "Container Tools")
            install_all
            ;;
        "All")
            install_all
            break
            ;;
        "Quit")
            break
            ;;
        *)
            echo "Invalid option $REPLY"
            ;;
    esac
done
