#!/usr/bin/env bash
set -e

echo "=== Fedora 43 Dotfiles Setup ==="

# Update system
sudo dnf upgrade --refresh -y

# Essential packages
sudo dnf install -y git zsh neovim tmux kitty alacritty neofetch curl wget unzip fzf htop ripgrep bat starship

# Flatpak
sudo dnf install -y flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Set Zsh default shell
chsh -s $(which zsh)

# Symlink dotfiles
echo "Symlinking configs..."
ln -sf ~/Fedora-Dotfiles/.zshrc ~/.zshrc
ln -sf ~/Fedora-Dotfiles/.p10k.zsh ~/.p10k.zsh
ln -sf ~/Fedora-Dotfiles/.tmux.conf ~/.tmux.conf
mkdir -p ~/.config/nvim ~/.config/kitty ~/.config/alacritty
ln -sf ~/Fedora-Dotfiles/.config/nvim/init.lua ~/.config/nvim/init.lua
ln -sf ~/Fedora-Dotfiles/.config/kitty/kitty.conf ~/.config/kitty/kitty.conf
ln -sf ~/Fedora-Dotfiles/.config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

echo "=== Fedora 43 Dotfiles Setup Complete ==="
