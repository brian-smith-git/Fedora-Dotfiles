#!/usr/bin/env bash

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
BOLD='\033[1m'
NC='\033[0m'

echo -e "${MAGENTA}${BOLD}
 ____  _       _               ____  _ _       _       
| __ )| | ___ | |_ ___  ___   / ___|| (_) __ _| | ___  
|  _ \| |/ _ \| __/ _ \/ __|  \___ \| | |/ _\` | |/ _ \ 
| |_) | | (_) | ||  __/\__ \   ___) | | | (_| | |  __/ 
|____/|_|\___/ \__\___||___/  |____/|_|_|\__, |_|\___| 
                                         |___/        
${NC}"

echo -e "${CYAN}${BOLD}Interactive Brian Smith's Dev Installer (safer)${NC}\n"

# Ensure we are on Fedora-like system with dnf
if ! command -v dnf &>/dev/null; then
    echo -e "${YELLOW}dnf not found. This installer expects a Fedora/RHEL-based system.${NC}"
    echo -e "${YELLOW}Aborting.${NC}"
    exit 1
fi

# Ensure sudo exists
if ! command -v sudo &>/dev/null; then
    echo -e "${YELLOW}sudo not found. Please run this as root or install sudo.${NC}"
    exit 1
fi

# Helper: install a package if the given command is missing
install_if_missing() {
    local cmd="$1"       # command to check, e.g., git
    local pkg="$2"       # package name to install via dnf (can be same as cmd)
    if command -v "$cmd" &>/dev/null; then
        echo -e "${CYAN}Command '$cmd' found; skipping install of '$pkg'.${NC}"
        return 0
    fi

    echo -e "${CYAN}Attempting to install package '$pkg' (command '$cmd' missing)...${NC}"
    if sudo dnf install -y "$pkg"; then
        echo -e "${GREEN}Installed $pkg${NC}"
        return 0
    else
        echo -e "${YELLOW}Failed to install $pkg via dnf. You may need to install it manually.${NC}"
        return 1
    fi
}

# Install essential packages (checks commands first)
install_essentials() {
    echo -e "${GREEN}${BOLD}Installing Essential Packages...${NC}"

    # Map command -> package (pkg may be adjusted if command differs from package name)
    declare -A map=(
        [git]=git
        [zsh]=zsh
        [curl]=curl
        [wget]=wget
        [vim]=vim
        [tmux]=tmux
        [rg]=ripgrep       # command 'rg' provided by 'ripgrep'
        [fd]=fd-find       # fallback package name; if this is wrong for your Fedora, edit it
        [fzf]=fzf
        [htop]=htop
        [bat]=bat
    )

    # Friendly loop: check for several possible commands (rg -> ripgrep, fd -> fd or fdfind)
    for cmd in "${!map[@]}"; do
        pkg="${map[$cmd]}"

        # special handling for some commands that have different binary names
        if [ "$cmd" = "rg" ]; then
            # check 'rg' binary (ripgrep)
            install_if_missing "rg" "$pkg"
        elif [ "$cmd" = "fd" ]; then
            # fd sometimes installs binary 'fd' or 'fdfind'
            if command -v fd &>/dev/null || command -v fdfind &>/dev/null; then
                echo -e "${CYAN}fd or fdfind already present; skipping.${NC}"
            else
                install_if_missing "fd" "$pkg"
            fi
        else
            install_if_missing "$cmd" "$pkg"
        fi
    done
}

install_zsh() {
    echo -e "${GREEN}${BOLD}Installing Zsh + Powerlevel10k...${NC}"
    install_if_missing zsh zsh

    # Install Oh My Zsh non-interactively (do not auto-run zsh or change shell)
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo -e "${CYAN}Installing Oh My Zsh (non-interactive)...${NC}"
        export RUNZSH=no
        export CHSH=no
        export KEEP_ZSHRC=yes
        # installer supports --unattended flag
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || {
            echo -e "${YELLOW}Warning: Oh My Zsh installer failed or returned non-zero. Continuing.${NC}"
        }
    else
        echo -e "${CYAN}Oh My Zsh is already installed.${NC}"
    fi

    # zsh-autosuggestions plugin
    if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
        echo -e "${CYAN}Installing zsh-autosuggestions plugin...${NC}"
        git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" || true
    else
        echo -e "${CYAN}zsh-autosuggestions is already installed.${NC}"
    fi

    # Powerlevel10k Theme
    if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
        echo -e "${CYAN}Installing Powerlevel10k theme...${NC}"
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" || true
    else
        echo -e "${CYAN}Powerlevel10k theme is already installed.${NC}"
    fi

    # Safely update .zshrc: if exists, change ZSH_THEME line; otherwise create a basic .zshrc
    if [ -f "$HOME/.zshrc" ]; then
        if grep -q '^ZSH_THEME=' "$HOME/.zshrc"; then
            sed -i 's|^ZSH_THEME=.*|ZSH_THEME="powerlevel10k/powerlevel10k"|' "$HOME/.zshrc" || true
        else
            echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >> "$HOME/.zshrc"
        fi
    else
        echo -e "${CYAN}.zshrc not found; creating a minimal one.${NC}"
        cat > "$HOME/.zshrc" <<'EOF'
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git)
source $ZSH/oh-my-zsh.sh
EOF
    fi

    echo -e "${CYAN}Powerlevel10k and Zsh setup complete.${NC}"
}

install_nvim() {
    echo -e "${GREEN}${BOLD}Installing Neovim + config...${NC}"
    install_if_missing nvim neovim
    mkdir -p "$HOME/.config/nvim"
    cp ./nvim/init.vim "$HOME/.config/nvim/init.vim" 2>/dev/null || true
}

install_tmux() {
    echo -e "${GREEN}${BOLD}Installing Tmux + config...${NC}"
    install_if_missing tmux tmux
    cp ./tmux/.tmux.conf "$HOME/.tmux.conf" 2>/dev/null || true
}

install_flatpaks() {
    echo -e "${GREEN}${BOLD}Installing Flatpak Apps...${NC}"
    if ! command -v flatpak &>/dev/null; then
        echo -e "${YELLOW}flatpak not found; installing flatpak...${NC}"
        sudo dnf install -y flatpak || {
            echo -e "${YELLOW}Could not install flatpak. Skipping flatpak installs.${NC}"
            return 1
        }
    fi

    # Ensure Flathub remote exists
    if ! flatpak remote-info flathub &>/dev/null; then
        echo -e "${CYAN}Adding Flathub remote...${NC}"
        sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo || true
    fi

    sudo flatpak install -y flathub com.visualstudio.code com.spotify.Client || {
        echo -e "${YELLOW}flatpak install failed for one or more apps. Continue or install them manually.${NC}"
    }
}

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
