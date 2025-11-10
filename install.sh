#!/usr/bin/env bash
# Brian Smith Fedora 43 Dev Setup Installer

# Colors
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
BLUE="\033[0;34m"
RED="\033[0;31m"
CYAN="\033[0;36m"
NC="\033[0m"

# Banner function
banner() {
cat << "EOF"
 ____  _           _             ____  _       _       
| __ )| | ___  ___| |_ ___  ___ |  _ \| | __ _| |_ ___ 
|  _ \| |/ _ \/ __| __/ _ \/ __|| | | | |/ _` | __/ _ \
| |_) | |  __/\__ \ ||  __/ (__ | |_| | | (_| | ||  __/
|____/|_|\___||___/\__\___|\___||____/|_|\__,_|\__\___|
EOF
echo -e "${CYAN}=======================================${NC}"
echo -e "${YELLOW}Brian Smith Fedora 43 Dev Setup Installer${NC}"
echo -e "${CYAN}=======================================${NC}"
}

# Print menu in modern style
menu() {
echo -e "${YELLOW}Select what to install:${NC}"
echo -e "  ${BLUE}1)${NC} Essential Packages"
echo -e "  ${BLUE}2)${NC} GUI Packages"
echo -e "  ${BLUE}3)${NC} Flatpak Apps"
echo -e "  ${BLUE}4)${NC} Zsh + Powerlevel10k"
echo -e "  ${BLUE}5)${NC} Neovim Config"
echo -e "  ${BLUE}6)${NC} Tmux Config"
echo -e "  ${BLUE}7)${NC} Extras & Productivity Tools"
echo -e "  ${BLUE}8)${NC} Language Managers & SDKs"
echo -e "  ${BLUE}9)${NC} Container Tools"
echo -e "  ${BLUE}10)${NC} Install Everything"
echo -e "  ${BLUE}11)${NC} Quit"
}

# Function to install packages
install_package() {
  pkg=$1
  echo -e "${GREEN}Installing: $pkg...${NC}"
  sudo dnf install -y $pkg &> /tmp/install.log
  if [ $? -eq 0 ]; then
      echo -e "${GREEN}✔ Installed: $pkg${NC}"
  else
      echo -e "${YELLOW}⚠ Could not install $pkg, skipping.${NC}"
  fi
}

# Fastfetch setup
setup_fastfetch() {
  echo 'if command -v fastfetch &> /dev/null; then fastfetch; fi' >> ~/.zshrc
}

# Add other installation functions here (Essentials, GUI, Flatpaks, Zsh/Powerlevel10k, Neovim, Tmux, Languages, Containers, Extras)
# ... (reuse the previous functions from earlier version)

# Main interactive loop
while true; do
  clear
  banner
  menu
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
          echo -e "${GREEN}✔ Full Fedora 43 dev setup completed!${NC}"
          exit 0
          ;;
      11) echo "Exiting..."; exit 0 ;;
      *) echo -e "${RED}Invalid option${NC}" ;;
  esac
done
