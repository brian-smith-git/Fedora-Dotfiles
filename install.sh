#!/bin/bash

# =======================================
# Brian Smith Fedora 43 Dev Setup Installer
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

echo -e "${CYAN}${BOLD}Interactive Fedora 43 Developer Setup${NC}\n"

# -------------------------------
# Functions for each section
# -------------------------------
install_essentials() {
    echo -e "${GREEN}${BOLD}Installing Essential Packages...${NC}"
    sudo dnf install -y git zsh curl wget vim tmux ripgrep fd-find fzf htop bat
}

install_gui() {
    echo -e "${GREEN}${BOLD}Installing GUI Packages...${NC}"
    sudo dnf install -y gnome-tweaks gnome-terminal gnome-software
}

install_flatpaks() {
    echo -e "${GREEN}${BOLD}Installing Flatpak Apps...${NC}"
    flatpak install -y flathub com.visualstudio.code com.spotify.Client
}

install_zsh() {
    echo -e "${GREEN}${BOLD}Installing Zsh + Powerlevel10k...${NC}"
    sudo dnf install -y zsh
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi
    if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
        sed -i 's|^ZSH_THEME=.*|ZSH_THEME="powerlevel10k/powerlevel10k"|' $HOME/.zshrc
    fi
    echo -e "${CYAN}Launching Zsh for Powerlevel10k setup if not configured...${NC}"
    zsh -c '[[ ! -f $HOME/.p10k.zsh ]] && exec zsh'
}

install_nvim() {
    echo -e "${GREEN}${BOLD}Installing Neovim + config...${NC}"
    sudo dnf install -y neovim
    mkdir -p $HOME/.config/nvim
    cp ./nvim/init.vim $HOME/.config/nvim/init.vim 2>/dev/null || true
}

install_tmux() {
    echo -e "${GREEN}${BOLD}Installing Tmux + config...${NC}"
    sudo dnf install -y tmux
    cp ./tmux/.tmux.conf $HOME/.tmux.conf 2>/dev/null || true
}

install_extras() {
    echo -e "${GREEN}${BOLD}Installing Extras & Productivity Tools...${NC}"
    sudo dnf install -y bat fzf htop exa
}

install_languages() {
    echo -e "${GREEN}${BOLD}Installing Language Managers & SDKs...${NC}"
    [[ ! -d "$HOME/.pyenv" ]] && curl https://pyenv.run | bash
    [[ ! -d "$HOME/.nvm" ]] && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
    [[ ! -d "$HOME/.rbenv" ]] && git clone https://github.com/rbenv/rbenv.git ~/.rbenv
}

install_containers() {
    echo -e "${GREEN}${BOLD}Installing Container Tools...${NC}"
    sudo dnf install -y podman docker-compose
}

# -------------------------------
# Menu
# -------------------------------
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
    "Install Everything"
    "Quit"
)

while true; do
    echo -e "${BOLD}${CYAN}Select what to install:${NC}\n"
    select opt in "${options[@]}"; do
        case $REPLY in
            1) install_essentials; break ;;
            2) install_gui; break ;;
            3) install_flatpaks; break ;;
            4) install_zsh; break ;;
            5) install_nvim; break ;;
            6) install_tmux; break ;;
            7) install_extras; break ;;
            8) install_languages; break ;;
            9) install_containers; break ;;
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
                echo -e "${GREEN}${BOLD}✔ Full Fedora 43 dev setup completed!${NC}"
                exit 0
                ;;
            11) echo -e "${GREEN}Exiting installer.${NC}"; exit 0 ;;
            *) echo -e "${YELLOW}Invalid option. Please choose again.${NC}"; break ;;
        esac
    done
done
