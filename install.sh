#!/bin/bash

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

if [[ $EUID -eq 0 ]]; then
   print_error "Do not run as root"
   exit 1
fi

print_status "Installing Hyprland environment..."

if ! command -v fish &> /dev/null; then
    print_status "Installing Fish shell..."
    sudo pacman -S --noconfirm fish
    print_success "Fish installed"
fi

print_status "Updating system..."
sudo pacman -Syu --noconfirm

if ! command -v yay &> /dev/null; then
    print_status "Installing yay..."
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ~
    rm -rf /tmp/yay
fi

print_status "Installing Hyprland core..."
sudo pacman -S --noconfirm \
    hyprland \
    hyprpaper \
    hypridle \
    hyprlock \
    xdg-desktop-portal-hyprland

print_status "Installing utilities..."
sudo pacman -S --noconfirm \
    dunst \
    pipewire \
    pipewire-alsa \
    pipewire-pulse \
    pipewire-jack \
    wireplumber \
    qt5-wayland \
    qt6-wayland \
    polkit-kde-agent \
    noto-fonts \
    noto-fonts-emoji \
    noto-fonts-cjk \
    noto-fonts-extra \
    ttf-nerd-fonts-symbols-mono \
    ttf-liberation \
    ttf-dejavu \
    ttf-opensans \
    adobe-source-code-pro-fonts \
    ttf-font-awesome

print_status "Installing Waybar and Fuzzel..."
sudo pacman -S --noconfirm waybar
yay -S --noconfirm fuzzel

print_status "Installing additional fonts..."
yay -S --noconfirm ttf-jetbrains-mono
yay -S --noconfirm ttf-fira-code
yay -S --noconfirm ttf-cascadia-code

print_status "Installing audio/network tools..."
sudo pacman -S --noconfirm \
    pavucontrol \
    pamixer \
    networkmanager \
    nm-connection-editor \
    network-manager-applet

print_status "Installing applications..."
yay -S --noconfirm ghostty-bin
yay -S --noconfirm google-chrome
yay -S --noconfirm visual-studio-code-bin
yay -S --noconfirm cursor-bin
yay -S --noconfirm teams-for-linux
yay -S --noconfirm webstorm
yay -S --noconfirm webstorm-jre
sudo pacman -S --noconfirm steam

print_status "Installing additional tools..."
sudo pacman -S --noconfirm \
    grim \
    slurp \
    swappy \
    wl-clipboard \
    brightnessctl \
    playerctl \
    thunar \
    thunar-volman \
    thunar-archive-plugin \
    file-roller \
    vulkan-radeon \
    lib32-vulkan-radeon \
    mesa \
    lib32-mesa \
    xdg-desktop-portal-wlr

print_status "Enabling services..."
sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager

print_status "Creating directories..."
mkdir -p ~/.config/{hypr,waybar,fuzzel,dunst,fish,swappy}
mkdir -p ~/.config/hypr/wallpapers
mkdir -p ~/.local/bin

print_status "Copying configurations..."

if [ -d "./config/hypr" ]; then
    cp -r ./config/hypr/* ~/.config/hypr/
    print_success "Hyprland config copied"
else
    print_warning "Hyprland config not found"
fi

if [ -d "./wallpapers" ]; then
    cp ./wallpapers/* ~/.config/hypr/wallpapers/ 2>/dev/null || true
    print_success "Wallpapers copied"
else
    print_warning "Wallpapers not found"
fi

if [ -d "./config/waybar" ]; then
    cp -r ./config/waybar/* ~/.config/waybar/
    print_success "Waybar config copied"
else
    print_warning "Waybar config not found"
fi

if [ -d "./config/fuzzel" ]; then
    cp -r ./config/fuzzel/* ~/.config/fuzzel/
    print_success "Fuzzel config copied"
else
    print_warning "Fuzzel config not found"
fi

if [ -d "./config/dunst" ]; then
    cp -r ./config/dunst/* ~/.config/dunst/
    print_success "Dunst config copied"
else
    print_warning "Dunst config not found"
fi

if [ -d "./config/fish" ]; then
    if [ ! -f ~/.config/fish/config.fish ] || [ ! -s ~/.config/fish/config.fish ]; then
        cp ./config/fish/config.fish ~/.config/fish/
        print_success "Fish config copied"
    else
        print_warning "Fish config exists, skipping"
    fi
else
    print_warning "Fish config not found"
fi

if [ -d "./config/swappy" ]; then
    cp -r ./config/swappy/* ~/.config/swappy/
    print_success "Swappy config copied"
else
    print_warning "Swappy config not found"
fi

print_status "Setting up Wayland apps..."
if [ -f "./scripts/setup-wayland-apps" ]; then
    chmod +x ./scripts/setup-wayland-apps
    ./scripts/setup-wayland-apps
else
    print_warning "Wayland setup script not found"
fi

if [ -d "./scripts" ]; then
    cp ./scripts/* ~/.local/bin/
    chmod +x ~/.local/bin/*
    print_success "Scripts copied"
fi

print_status "Configuring Fish shell..."
mkdir -p ~/.config/fish

if ! grep -q "PATH.*local/bin" ~/.config/fish/config.fish 2>/dev/null; then
    echo "" >> ~/.config/fish/config.fish
    echo "# Hyprland environment" >> ~/.config/fish/config.fish
    echo 'set -gx PATH $HOME/.local/bin $PATH' >> ~/.config/fish/config.fish
    echo 'set -gx QT_QPA_PLATFORM wayland' >> ~/.config/fish/config.fish
    echo 'set -gx XDG_CURRENT_DESKTOP Hyprland' >> ~/.config/fish/config.fish
    echo 'set -gx XDG_SESSION_DESKTOP Hyprland' >> ~/.config/fish/config.fish
    echo 'set -gx XDG_SESSION_TYPE wayland' >> ~/.config/fish/config.fish
    echo 'set -gx ELECTRON_OZONE_PLATFORM_HINT wayland' >> ~/.config/fish/config.fish
    echo 'set -gx ELECTRON_ENABLE_WAYLAND 1' >> ~/.config/fish/config.fish
    print_success "Fish environment configured"
else
    print_success "Fish already configured"
fi

print_success "Installation complete!"
print_status "Reboot and select Hyprland or run 'Hyprland' from TTY" 