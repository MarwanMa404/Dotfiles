#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print header
print_header() {
    echo -e "${BLUE}
    _       __     __                         _____ __        __
   | |     / /__  / /________  ____ ___  ___ / ___// /_____  / /
   | | /| / / _ \\/ / ___/ __ \\/ __ \`__ \\/ _ \\\\__ \\/ __/ __ \\/ / 
   | |/ |/ /  __/ / /__/ /_/ / / / / / /  __/__/ / /_/ /_/ / /  
   |__/|__/\\___/_/\\___/\\____/_/ /_/ /_/\\___/____/\\__/\\____/_/   
    ${NC}"
    echo -e "${YELLOW}---------------------------------------------${NC}"
}

# Function to print status messages
print_status() {
    echo -e "${YELLOW}[*] $1${NC}"
}

# Function to print success messages
print_success() {
    echo -e "${GREEN}[+] $1${NC}"
}

# Function to print error messages
print_error() {
    echo -e "${RED}[-] $1${NC}"
    exit 1
}

# Install base packages
install_pacman_packages() {
    #print_status "Updating system and installing packages..."
    #sudo pacman -Syu --noconfirm || print_error "Failed to update system"
    sudo pacman -Sy --noconfirm hyprland kitty git base-devel pipewire brightnessctl \
        waybar neovim tmux nautilus rofi firefox file-roller mpv qt5-base qt5-svg qt5-quickcontrols2 qt5-graphicaleffects htop btop || print_error "Failed to install packages"
    print_success "Base packages installed successfully"
}

# Install yay and AUR packages
install_aur_packages() {
    print_status "Installing yay..."
    sudo pacman -S --needed --noconfirm git base-devel || print_error "Failed to install dependencies for yay"
    git clone https://aur.archlinux.org/yay.git || print_error "Failed to clone yay repository"
    cd yay && makepkg -si --noconfirm || print_error "Failed to build yay"
    cd ..
    
    print_status "Installing AUR packages..."
    yay -Sy --noconfirm wlogout swaylock-effects sddm freedownloadmanager || print_error "Failed to install AUR packages"
    print_success "AUR packages installed successfully"
}

# Enable system services
enable_services() {
    print_status "Enabling system services..."
    sudo systemctl enable NetworkManager && print_success "NetworkManager enabled"
    sudo systemctl enable sddm && print_success "SDDM display manager enabled"
}

# Setup user files
setup_files() {
    print_status "Setting up user files..."
    
    # Create directories
    mkdir -p ~/{Documents,Downloads,Pictures}
    
    # Copy configurations
    cp -r ./.config ~/ && print_success "Config files copied"
    cp -r ./.icons ~/ && print_success "Icons copied"
    cp -r ./.themes ~/ && print_success "Themes copied"
    cp ./assets/start.sh ~/ && print_success "Start script copied"
    cp ./assets/swwwwalhash.sh ~/ && ptint_success "SwwwWalhash script copied"
    
    # Move wallpapers
    mv ./assets/wallpapers ~/Pictures/ && print_success "Wallpapers moved"
}

# Main installation flow
main() {
    print_header
    install_pacman_packages
    install_aur_packages
    enable_services
    setup_files
    
    echo -e "${GREEN}"
    echo "---------------------------------------------"
    echo " Installation Complete! "
    echo "---------------------------------------------"
    echo -e "${NC}"
}

# Start main function
main
