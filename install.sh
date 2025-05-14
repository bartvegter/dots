#!/usr/bin/env bash
set -euo pipefail

BASE_PKGS=(
  alacritty blueberry cliphist gdm gnome-keyring libnotify linux-lts linux-lts-headers
  grimblast-git hyprland hyprlock hyprpaper hyprpicker hyprpolkitagent mako nmtui
  pamixer pavucontrol playerctl pipewire qt5-wayland qt6-wayland reflector
  rofi-emoji rofi-wayland uwsm waybar wireplumber wl-clip-persist wl-clipboard wlogout
  wlsunset xdg-desktop-portal-gtk xdg-desktop-portal-hyprland
)

THEME_PKGS=(
  gruvbox-gtk-theme-git gruvbox-icon-theme-git noto-fonts noto-fonts-cjk noto-fonts-emoji
  noto-fonts-extra ttf-jetbrains-mono-nerd ttf-ms-win11-auto
)

DEV_PKGS=(
  clang intellij-idea-ultimate-edition jdk21-openjdk nodejs-lts-jod npm postgresql python webstorm
)

USER_PKGS=(
  bat bottles brave-bin btop discord easyeffects file-roller firefox fzf lazygit nautilus
  nautilus-image-converter neovim obsidian onlyoffice-bin proton-vpn-gtk-app ripgrep
  seahorse spotify-launcher starship syncthing ticktick timeshift tldr udiskie vim
  zathura zathura-pdf-poppler zsh
)

GAMING_PKGS=(
  gamescope gamemode lib32-mesa lib32-vulkan-radeon lutris mangohud mesa minecraft-launcher
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
  sudo pacman -Syu --needed base-devel git
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
  paru -Syu --needed stow -y
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
echo ":: Package installation complete"
