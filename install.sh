#!/bin/bash
# =======================================
# Brian Smith's Fedora 43 Dev Setup Installer
# =======================================

# Banner
cat << "EOF"
| __ )| | ___  ___| |_ ___  ___ |  _ \| | __ _| |_ ___
|  _ \| |/ _ \/ __| __/ _ \/ __|| | | | |/ _` | __/ _ \
| |_) | |  __/\__ \ ||  __/ (__ | |_| | | (_| | ||  __/
|____/|_|\___||___/\__\___|\___||____/|_|\__,_|\__\___|
=======================================
Brian Smith's Fedora 43 Dev Setup Installer
=======================================
EOF

# ---------------------------------------
# Functions
# ---------------------------------------

install_essentials() {
    echo "Installing essential packages..."
    sudo dnf install -y git zsh curl wget vim tmux neovim stow ripgrep fd-find fzf htop bat
}

install_gui() {
    echo "Installing GUI packages..."
    sudo dnf install -y gnome-terminal gnome-tweaks
}

install_flatpaks() {
    echo "Installing Flatpak apps..."
    sudo flatpak install -y flathub org.gimp.GIMP org.videolan.VLC
}

install_zsh() {
    echo "Installing Zsh + Powerlevel10k..."
    sudo dnf install -y zsh
    if [ ! -d "$HOME/powerlevel10k" ]; then
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
    fi
    if ! grep -q "powerlevel10k.zsh-theme" ~/.zshrc; then
        echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
    fi
    echo "Setting Zsh as default shell..."
    chsh -s $(which zsh)
}

install_nvim() {
    echo "Setting up Neovim config..."
    mkdir -p ~/.config/nvim
    cp -r ./nvim-config/* ~/.config/nvim/
}

install_tmux() {
    echo "Setting up Tmux config..."
    cp ./tmux.conf ~/.tmux.conf
}

install_extras() {
    echo "Installing extras & productivity tools..."
    sudo dnf install -y exa
}

install_languages() {
    echo "Installing language managers & SDKs..."
    sudo dnf install -y pyenv rbenv nvm
}

install_containers() {
    echo "Installing container tools..."
    sudo dnf install -y podman docker-compose
}

setup_fastfetch() {
    echo "Installing Fastfetch..."
    sudo dnf install -y fastfetch
    if ! grep -q "fastfetch" ~/.zshrc; then
        echo "fastfetch" >> ~/.zshrc
    fi
}

setup_history() {
    echo "Setting up persistent Zsh history..."
    if ! grep -q "SAVEHIST" ~/.zshrc; then
        echo "HISTFILE=~/.zsh_history" >> ~/.zshrc
        echo "HISTSIZE=10000" >> ~/.zshrc
        echo "SAVEHIST=10000" >> ~/.zshrc
        echo "setopt append_history" >> ~/.zshrc
    fi
}

# ---------------------------------------
# Interactive Menu
# ---------------------------------------
while true; do
    echo "Select what to install:"
    echo "  1) Essential Packages"
    echo "  2) GUI Packages"
    echo "  3) Flatpak Apps"
    echo "  4) Zsh + Powerlevel10k"
    echo "  5) Neovim Config"
    echo "  6) Tmux Config"
    echo "  7) Extras & Productivity Tools"
    echo "  8) Language Managers & SDKs"
    echo "  9) Container Tools"
    echo " 10) Install Everything"
    echo " 11) Quit"
    read -p "#? " choice

    case $choice in
        1) install_essentials ;;
        2) install_gui ;;
        3) install_flatpaks ;;
        4) install_zsh ;;
        5) install_nvim ;;
        6) install_tmux ;;
        7) install_extras ;;
        8) install_languages ;;
        9) install_containers ;;
        10)
            install_essentials
            install_gui
            install_flatpaks
            install_zsh
            install_nvim
            install_tmux
            install_extras
            install_languages
            install_containers
            setup_fastfetch
            setup_history
            ;;
        11) echo "Goodbye!"; exit 0 ;;
        *) echo "Invalid option." ;;
    esac
done
