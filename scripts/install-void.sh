#!/bin/bash

# Void Linux Installation Script for Sway/Wayland Dotfiles
# This script installs necessary packages and sets up configurations for Void Linux

set -e

echo "🚀 Installing Void Linux packages for Sway/Wayland setup..."

# Update system
echo "📦 Updating system packages..."
sudo xbps-install -Su

# Install Sway and Wayland components
echo "🏗️  Installing Sway and Wayland components..."
sudo xbps-install -S sway waybar swaylock swayidle swaybg swaync

# Install ly display manager
echo "🖥️  Installing ly display manager..."
sudo xbps-install -S ly

# Install terminal and system utilities
echo "📱 Installing terminal and system utilities..."
sudo xbps-install -S foot alacritty starship zsh git direnv

# Install additional utilities
echo "🔧 Installing additional utilities..."
sudo xbps-install -S dmenu wmenu grim slurp wl-clipboard pavucontrol

# Install fonts (including Nerd Fonts)
echo "🔤 Installing fonts..."
sudo xbps-install -S font-hack-ttf noto-fonts-ttf noto-fonts-emoji

# Install development tools
echo "👨‍💻 Installing development tools..."
sudo xbps-install -S neovim nano curl wget

# Install multimedia and graphics
echo "🎨 Installing multimedia and graphics..."
sudo xbps-install -S mpv imv

# Install system monitoring tools
echo "📊 Installing system monitoring tools..."
sudo xbps-install -S htop neofetch

echo "✅ Package installation complete!"

# Set up user directories
echo "📁 Setting up user directories..."
mkdir -p ~/.config
mkdir -p ~/.local/bin

# Change default shell to zsh if not already
if [ "$SHELL" != "/bin/zsh" ]; then
    echo "🐚 Changing default shell to zsh..."
    sudo chsh -s /bin/zsh $USER
    echo "⚠️  Please log out and log back in for shell change to take effect"
fi

echo "🎉 Void Linux setup complete!"
echo ""
echo "Next steps:"
echo "1. Log out and log back in (or restart) to use the new shell"
echo "2. Run 'make install-void' to set up dotfiles"
echo "3. Enable ly display manager: 'sudo ln -s /etc/sv/ly /var/service/'"
echo "4. Start Sway with 'sway' command or reboot to use ly"
echo ""
echo "📝 Note: ly is now installed as your display manager for easy Wayland session management"