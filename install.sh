#/bin/bash 

echo "installing......."
sleep 2
sudo pacman -Syu
sleep 1
sudo pacman -Sy hyprland kitty git base-devel pipewire brightnessctl waybar neovim tmux nautilus rofi firefox file-roller mpv
sleep 2
echo "installing yay........"
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
sleep 1
yay -S wlogout swaylock swaylock-effects ly
sleep 2
echo "enabling services......."
sudo systemctl enable NetworkManager &
echo "network......ok"
sudo systemctl enable ly &
echo "ly...........ok"
sleep 2
echo "copying files.........."
mv ./.config ~/ 
mv ./.icons/ ~/ 
mv ./.themes ~/ 
mv ./assets/start.sh ~/ 
mkdir ~/Documents ~/Downloads ~/Pictures 
mv ./assets/wallpapers ~/Pictures 
sleep 1
echo "Done!"
