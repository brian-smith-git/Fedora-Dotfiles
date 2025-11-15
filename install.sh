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
            echo -e "${CYAN}Installing $package...${NC}"
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
        echo -e "${CYAN}Installing Zsh...${NC}"
        sudo dnf install -y zsh
    else
        echo -e "${CYAN}Zsh is already installed.${NC}"
    fi

    # Install Oh My Zsh if not installed
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo -e "${CYAN}Installing Oh My Zsh...${NC}"
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    else
        echo -e "${CYAN}Oh My Zsh is already installed.${NC}"
    fi

    # Install zsh-autosuggestions if not installed
    if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
        echo -e "${CYAN}Installing zsh-autosuggestions plugin...${NC}"
        git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    else
        echo -e "${CYAN}zsh-autosuggestions is already installed.${NC}"
    fi

    # Install Powerlevel10k Theme if not installed
    if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
        echo -e "${CYAN}Installing Powerlevel10k theme...${NC}"
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
        # Set the theme in .zshrc
        sed -i 's|^ZSH_THEME=.*|ZSH_THEME="powerlevel10k/powerlevel10k"|' $HOME/.zshrc
    else
        echo -e "${CYAN}Powerlevel10k theme is already installed.${NC}"
    fi

    echo -e "${CYAN}Powerlevel10k and Zsh setup complete.${NC}"
}

# Install Neovim + config
install_nvim() {
    echo -e "${GREEN}${BOLD}Installing Neovim + config...${NC}"
    if ! is_package_installed neovim; then
        echo -e "${CYAN}Installing Neovim...${NC}"
        sudo dnf install -y neovim
    else
        echo -e "${CYAN}Neovim is already installed.${NC}"
    fi
    mkdir -p $HOME/.config/nvim
    # Assuming you have a nvim/init.vim in the repo, copy it to the user's config folder
    cp ./nvim/init.vim $HOME/.config/nvim/init.vim 2>/dev/null || true
}

# Install tmux + config
install_tmux() {
    echo -e "${GREEN}${BOLD}Installing Tmux + config...${NC}"
    if ! is_package_installed tmux; then
        echo -e "${CYAN}Installing Tmux...${NC}"
        sudo dnf install -y tmux
    else
        echo -e "${CYAN}Tmux is already installed.${NC}"
    fi
    # Assuming you have tmux/.tmux.conf in the repo, copy it to the user's home directory
    cp ./tmux/.tmux.conf $HOME/.tmux.conf 2>/dev/null || true
}

# Install flatpak apps
install_flatpaks() {
    echo -e "${GREEN}${BOLD}Installing Flatpak Apps...${NC}"
    flatpak install -y flathub com.visualstudio.code com.spotify.Client
}

# -------------------------------
# Main menu and installer execution
# -------------------------------

options=(
    "Essential Packages"
    "Zsh + Powerlevel10k"
    "Neovim Config"
    "Tmux Config"
    "Flatpak Apps"
    "Install Everything"
    "Quit"
)

while true; do
    echo -e "${BOLD}${CYAN}Select what to install:${NC}\n"
    select opt in "${options[@]}"; do
        case $REPLY in
            1) install_essentials; break ;;
            2) install_zsh; break ;;
            3) install_nvim; break ;;
            4) install_tmux; break ;;
            5) install_flatpaks; break ;;
            6) 
                install_essentials
                install_zsh
                install_nvim
                install_tmux
                install_flatpaks
                echo -e "${GREEN}${BOLD}✔ Full setup completed!${NC}"
                exit 0
                ;;
            7) echo -e "${GREEN}Exiting installer.${NC}"; exit 0 ;;
            *) echo -e "${YELLOW}Invalid option. Please choose again.${NC}"; break ;;
        esac
    done
done
