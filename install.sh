#!/usr/bin/env bash
set -euo pipefail

BASE_PKGS=(
  ags-hyprpanel-git alacritty brightnessctl cliphist gnome-keyring less libnotify
  grimblast-git hyprland hyprlock hyprpicker hyprpolkitagent man-db mutagen-bin openssh
  pacman-contrib pamixer pavucontrol playerctl pipewire python python-pywal qt5-wayland qt6-wayland 
  reflector rofi-emoji rofi-wayland sddm swww tree uwsm vim wireplumber wf-recorder wl-clip-persist 
  wl-clipboard wlsunset xdg-desktop-portal-gtk xdg-desktop-portal-hyprland
)

THEME_PKGS=(
  gruvbox-gtk-theme-git gruvbox-icon-theme-git noto-fonts noto-fonts-cjk noto-fonts-emoji
  noto-fonts-extra qt6-declarative qt5-quickcontrols2 qt5-svg qt6-svg sddm-sugar-dark
  ttf-jetbrains-mono-nerd ttf-ms-win11-auto
)

DEV_PKGS=(
  clang intellij-idea-ultimate-edition jdk21-openjdk nodejs-lts-jod npm postgresql python webstorm
)

USER_PKGS=(
  bat bottles brave-bin btop discord easyeffects fd file-roller firefox fzf lazygit lua-language-server
  nautilus nautilus-image-converter neovim obsidian oh-my-posh-bin onlyoffice-bin proton-vpn-gtk-app
  ripgrep seahorse spotify-launcher syncthing ticktick timeshift tldr udiskie viewnior vim
  webp-pixbuf-loader zathura zathura-pdf-poppler zen-browser-bin zsh zsh-autosuggestions
  zsh-syntax-highlighting
)

GAMING_PKGS=(
  gamescope gamemode lib32-mesa lib32-vulkan-radeon mangohud mesa minecraft-launcher
  protontricks protonup-qt steam vulkan-radeon wine wine-gecko wine-mono winetricks
)

ALL_PKGS=(
  "${BASE_PKGS[@]}"
  "${THEME_PKGS[@]}"
  "${DEV_PKGS[@]}"
  "${USER_PKGS[@]}"
  "${GAMING_PKGS[@]}"
)

# -----------------------------------------------
# Install paru if not already installed
# -----------------------------------------------

echo ":: Checking for existing installation of paru..."
if ! command -v paru &>/dev/null; then
  echo ":: Installing paru..."
  sudo pacman -Syu --needed base-devel git rust
  git clone https://aur.archlinux.org/paru.git "$HOME/paru"
  pushd "$HOME/paru"
  makepkg -si --noconfirm
  popd
  rm -rf "$HOME/paru"
else
  echo ":: Paru is already installed"
fi

# -----------------------------------------------
# Use GNU stow if dotfiles are available
# -----------------------------------------------

echo ":: Installing stow for dotfile management..."
if [[ -d "$HOME/dots" ]]; then
  echo ":: Using stow for dotfiles..."
  paru -Syu --needed stow
  cd "$HOME/dots"
  rm "$HOME/.bashrc"
  stow .
  cd "$HOME"
fi

# -----------------------------------------------
# Install packages
# -----------------------------------------------

echo ":: Installing packages..."
paru -Syu --needed "${ALL_PKGS[@]}" -y

# -----------------------------------------------
# SDDM setup
# -----------------------------------------------

echo ":: Enabling SDDM login manager..."
sudo systemctl enable sddm.service
if [ ! -d "/etc/sddm.conf.d" ]; then
    sudo mkdir /etc/sddm.conf.d
fi
sudo cp "$HOME/dots/etc/sddm.conf" "/etc/sddm.conf.d/sddm.conf"

# -----------------------------------------------
# Lofree Flow keyboard patches
# -----------------------------------------------

echo ":: Applying Lofree Flow keyboard patches..."
if [ ! -d "/etc/modprobe.d" ]; then
    sudo mkdir /etc/modprobe.d
fi
sudo cp "$HOME/dots/etc/hid_apple.conf" "/etc/modprobe.d/hid_apple.conf"
sudo mkinitcpio -P

# -----------------------------------------------
# Finishing touches
# -----------------------------------------------

echo && echo ":: Enabling ssh agent as systemd user unit..."
systemctl --user enable ssh-agent

echo && echo ":: Enabling bluetooth through systemd..."
systemctl enable bluetooth

echo && echo ":: Enabling reflector.timer for automatic mirrorlist updates..."
systemctl enable reflector.timer

echo && echo ":: Installation complete"
echo ":: Run 'systemctl reboot' to boot into the system" && echo
