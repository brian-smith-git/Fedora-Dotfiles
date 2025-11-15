#!/bin/bash

# =======================================
# Brian Smith's Dev Installer
# =======================================

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
BOLD='\033[1m'
NC='\033[0m'

# -------------------------------
# ASCII Header
# -------------------------------
echo -e "${MAGENTA}${BOLD}
 ____  _       _               ____  _ _       _       
| __ )| | ___ | |_ ___  ___   / ___|| (_) __ _| | ___  
|  _ \| |/ _ \| __/ _ \/ __|  \___ \| | |/ _\` | |/ _ \ 
| |_) | | (_) | ||  __/\__ \   ___) | | | (_| | |  __/ 
|____/|_|\___/ \__\___||___/  |____/|_|_|\__, |_|\___| 
                                         |___/        
${NC}"

echo -e "${CYAN}${BOLD}Interactive Brian Smith's Dev Installer${NC}\n"

# -------------------------------
# Functions for each section
# -------------------------------

# Check if a package is installed
is_package_installed() {
    rpm -q "$1" &>/dev/null
    return $?
}

# Install essential packages
install_essentials() {
    echo -e "${GREEN}${BOLD}Installing Essential Packages...${NC}"
    for package in git zsh curl wget vim tmux ripgrep fd-find fzf htop bat; do
        if ! is_package_installed $package; then
            sudo dnf install -y $package
        else
            echo -e "${CYAN}Package $package is already installed.${NC}"
        fi
    done
}

# Install Zsh + Powerlevel10k
install_zsh() {
    echo -e "${GREEN}${BOLD}Installing Zsh + Powerlevel10k...${NC}"
    if ! is_package_installed zsh; then
        sudo dnf install -y zsh
    else
        echo -e "${CYAN}Zsh is already installed.${NC}"
    fi

    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo -e "${CYAN}Installing Oh My Zsh...${NC}"
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi

    # Install zsh-autosuggestions if it's not already installed
    if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
        echo -e "${CYAN}Installing zsh-autosuggestions plugin...${NC}"
        git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    fi

    # Powerlevel10k Theme Setup
    if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
        echo -e "${CYAN}Installing Powerlevel10k theme...${NC}"
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
        sed -i 's|^ZSH_THEME=.*|ZSH_THEME="powerlevel10k/powerlevel10k"|' $HOME/.zshrc
    fi

 
