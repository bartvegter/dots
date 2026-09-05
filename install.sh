#!/usr/bin/env bash
set -euo pipefail

BASE_PKGS=(
  7zip
  adw-gtk-theme
  bat-extras
  brightnessctl
  bluetui
  bluez-utils
  btrfs-progs
  cdrtools
  cups
  ddcutil
  dosfstools
  eza
  exfatprogs
  e2fsprogs
  ffmpegthumbnailer
  file-roller
  ghostty
  gnome-keyring
  gvfs
  gvfs-mtp
  gvfs-nfs
  gvfs-smb
  hunspell
  hunspell-en_US
  hyprland
  hyprpicker
  kde-cli-tools
  less
  libgepub
  libgnome-keyring
  libnotify
  libopenraw
  libva-utils
  man-db
  nautilus
  nautilus-image-converter
  nautilus-share
  nfs-utils
  noctalia
  noctalia-greeter
  ntfsprogs
  openssh
  pamixer
  playerctl
  pipewire
  poppler-glib
  python
  python-pywal
  qt5-wayland
  qt6-wayland
  qt6ct-kde
  rocm-smi-lib
  seahorse
  speech-dispatcher
  starship
  sushi
  tealdeer
  trash-cli
  tumbler
  udiskie
  unrar
  unzip
  uwsm
  vim
  webp-pixbuf-loader
  wf-recorder
  wireplumber
  wl-clip-persist
  wl-clipboard
  wtype
  xdg-desktop-portal-gtk
  xdg-desktop-portal-hyprland
  xfsprogs
  xorg-xhost
  zip
  zoxide
  zsh
  zsh-autosuggestions
  zsh-syntax-highlighting
)

THEME_PKGS=(
  bibata-cursor-theme
  gruvbox-icon-theme-git
  noto-fonts
  noto-fonts-cjk
  noto-fonts-emoji
  noto-fonts-extra
  qt6-declarative
  qt5-quickcontrols2
  qt5-svg
  qt6-svg
  ttf-aptos
  ttf-jetbrains-mono-nerd
  ttf-ms-fonts
)

DEV_PKGS=(
  android-tools
  bruno-bin
  clang
  cmake
  docker
  docker-compose
  docker-buildx
  fzf
  gitlab-ci-ls
  jdk-openjdk
  lazydocker
  lazygit
  maven
  mtpfs
  neovim
  nodejs-lts-jod
  npm
  pigz
  postgresql
  python
  qt6-languageserver
  ripgrep
  shellcheck
  shfmt
  stylua
  tmux
  vscodium
  zed
)

USER_PKGS=(
  brave-origin-bin
  btop
  easyeffects
  obsidian
  onlyoffice-bin
  proton-vpn-gtk-app
  sone-bin
  syncthing
  ticktick
  viewnior
  webcord
  zen-browser-bin
)

GAMING_PKGS=(
  cachyos-gaming-meta
  gamescope
  gamemode
  lib32-mangohud
  lib32-mesa
  lib32-vulkan-radeon
  mangohud
  mesa
  minecraft-launcher
  protonplus
  protontricks
  steam
  vulkan-radeon
  wine-staging
  wine-gecko
  wine-mono
  winetricks
  wqy-zenhei
)

ALL_PKGS=(
  "${BASE_PKGS[@]}"
  "${THEME_PKGS[@]}"
  "${DEV_PKGS[@]}"
  "${USER_PKGS[@]}"
  "${GAMING_PKGS[@]}"
)

# -----------------------------------------------
# Enabling color and pacman easter egg in pacman
# -----------------------------------------------

printf ":: Updating pacman config..."
if grep "Color" /etc/pacman.conf; then
  if grep "^#Color" /etc/pacman.conf; then
    sudo sed -i "s/^#Color/Color/" /etc/pacman.conf
  fi
  if ! grep "ILoveCandy" /etc/pacman.conf; then
    sudo sed -i "s/Color/Color\nILoveCandy/" /etc/pacman.conf
  fi
fi

# -----------------------------------------------
# Install paru if not installed already
# -----------------------------------------------

printf ":: Checking if paru is installed..."
if ! command -v paru &>/dev/null; then
  printf ":: Paru not found. Installing now...\n"
  sudo pacman -Syu --needed --noconfirm base-devel git rustup
  rustup default stable
  git clone https://aur.archlinux.org/paru.git "$HOME/paru"
  pushd "$HOME/paru"
  makepkg -si --noconfirm
  popd
  rm -rf "$HOME/paru"
  printf "\n:: Paru installation complete\n"
else
  printf ":: Found existing installation of paru. Continuing...\n"
fi

# -----------------------------------------------
# Use GNU stow if dotfiles are available
# -----------------------------------------------

printf ":: Checking if GNU stow is installed..."
if ! command -v stow &>/dev/null; then
  printf ":: GNU stow not found. Installing now...\n"
  paru -Syu --needed --noconfirm stow
  printf "\n:: GNU stow installation complete\n"
else
  printf ":: Found existing installation of GNU stow. Continuing...\n"
fi

printf ":: Setting up GNU stow for dotfile management\n"
if [[ -d "$HOME/dots" ]]; then
  cd "$HOME/dots"
  if [[ -e "$HOME/.bashrc" ]]; then
    mv "$HOME/.bashrc" "$HOME/.bashrc.bak"
  fi
  stow .
  cd "$HOME"
fi

# -----------------------------------------------
# Install packages
# -----------------------------------------------

printf "\n:: Installing all packages...\n"
paru -Syu --needed --noconfirm "${ALL_PKGS[@]}"
printf "\n:: Package install completed\n"

# -----------------------------------------------
# Greeter setup
# -----------------------------------------------

printf ":: Setting up noctalia greeter with greetd for login...\n"
sudo systemctl enable greetd.service
sudo cp "$HOME/dots/etc/pam.d/greetd /etc/pam.d/greetd"
sudo cp "$HOME/dots/etc/greetd/config.toml /etc/greetd/config.toml"
sudo cp "$HOME/dots/var/lib/noctalia-greeter/greeter.toml /var/lib/noctalia-greeter/greeter.toml"
printf ":: Noctalia greeter setup completed\n"

# -----------------------------------------------
# Lofree Flow keyboard patches
# -----------------------------------------------

while true; do
  read -rp ">> Would you like to apply patches for the Lofree Flow keyboard? [y/N]: " yn_lofree_patches
  case $yn_lofree_patches in
  "Y" | "y")
    printf ":: Applying Lofree Flow keyboard patches...\n"
    if [[ ! -d "/etc/modprobe.d" ]]; then
      sudo mkdir /etc/modprobe.d
    fi
    sudo cp "$HOME/dots/etc/modprobe.d/hid_apple.conf" "/etc/modprobe.d/hid_apple.conf"
    sudo mkinitcpio -P
    break
    ;;
  "" | "N" | "n")
    echo ":: Skipping Lofree Flow keyboard patches"
    break
    ;;
  *)
    printf "\n:: Invalid input, please try again"
    printf ":: Valid values are [y]es or [N]o (case insensitive), or press [return] for default (No)\n"
    break
    ;;
  esac
done

# -----------------------------------------------
# Finishing touches
# -----------------------------------------------

printf "\n:: Replacing wpa_supplicant with iwd as default wifi backend for NetworkManager...\n"
sudo cp "$HOME/dots/etc/NetworkManager/conf.d/iwd.conf" "/etc/NetworkManager/conf.d/iwd.conf"
sudo systemctl stop NetworkManager.service
sudo systemctl disable --now wpa_supplicant.service
sudo systemctl restart NetworkManager.service
sudo systemctl enable --now iwd.service

while true; do
  echo
  read -rp ">> Would you like to enable bluetooth on your system? [y/N]: " yn_bluetooth_setup
  case $yn_bluetooth_setup in
  "Y" | "y")
    echo ":: Enabling bluetooth systemd service..."
    systemctl enable bluetooth.service
    break
    ;;
  "" | "N" | "n")
    echo ":: Skipping bluetooth setup..."
    break
    ;;
  *)
    printf "\n:: Invalid input, please try again..."
    printf ":: Valid values are [y]es or [N]o (case insensitive), or press [return] for default (No)\n"
    break
    ;;
  esac
done

while true; do
  echo
  read -rp ">> Would you like to setup your git credentials? [y/N]: " yn_git_setup
  case $yn_git_setup in
  "Y" | "y")
    echo
    read -rp ">> Enter your git display name (e.g. 'John Smith'): " git_name
    git config --global user.name "${git_name}"

    read -rp ">> Enter your email address to use with git (e.g. 'name@example.com'): " git_email
    git config --global user.email "${git_email}"
    break
    ;;
  "" | "N" | "n")
    printf ":: Skipping git setup..."
    break
    ;;
  *)
    printf "\n:: Invalid input, please try again..."
    printf ":: Valid values are [y]es or [N]o (case insensitive), or press [return] for default (No)\n"
    break
    ;;
  esac
done

while true; do
  echo
  read -rp ">> Would you like to enable the ssh agent? [y/N]: " yn_ssh_agent
  case $yn_ssh_agent in
  "Y" | "y")
    printf ":: Enabling ssh agent as systemd user unit..."
    systemctl --user enable --now gcr-ssh-agent.socket

    while true; do
      echo
      read -rp ">> Would you like to add an ssh key to the agent? [y/N]: " yn_ssh_key
      case $yn_ssh_key in
      "Y" | "y")
        echo
        read -rp ">> Enter the path of your private key (e.g. ~/.ssh/key or /home/user/.ssh/key)? " ssh_key_path
        /usr/lib/seahorse/ssh-askpass "${ssh_key_path}"
        break
        ;;
      "" | "N" | "n")
        printf ":: Skipping ssh key setup..."
        break
        ;;
      *)
        printf "\n:: Invalid input, please try again..."
        printf ":: Valid values are [y]es or [N]o (case insensitive), or press [return] for default (No)\n"
        break
        ;;
      esac
    done
    break
    ;;
  "" | "N" | "n")
    echo ":: Skipping ssh agent setup..."
    break
    ;;
  *)
    printf "\n:: Invalid input, please try again..."
    printf ":: Valid values are [y]es or [N]o (case insensitive), or press [return] for default (No)\n"
    break
    ;;
  esac
done

while true; do
  echo
  read -rp ">> Would you like to enable the docker engine on startup and be able to run docker as non-root? [y/N]: " yn_docker
  case $yn_docker in
  "Y" | "y")
    printf ":: Enabling docker socket...\n"
    sudo systemctl enable --now docker.socket
    sudo gpasswd -a "$USER" docker
    break
    ;;
  "" | "N" | "n")
    printf ":: Skipping docker setup...\n"
    break
    ;;
  *)
    printf "\n:: Invalid input, please try again..."
    printf ":: Valid values are [y]es or [N]o (case insensitive), or press [return] for default (No)\n"
    break
    ;;
  esac
done

if [[ "$(basename "$SHELL")" != "zsh" ]]; then
  printf "\n:: Setting zsh as the default user shell..."
  chsh -s "$(command -v zsh)"
fi

printf "\n:: Installation complete\n"
while true; do
  read -rp ">> Would you like to reboot into Hyprland? [Y/n]: " yn_reboot
  case $yn_reboot in
  "" | "Y" | "y")
    printf ":: Rebooting system...\n"
    systemctl reboot
    break
    ;;

  "N" | "n")
    printf ":: When ready, run 'systemctl reboot' to reboot into Hyprland\n"
    break
    ;;

  *)
    printf "\n:: Invalid input, please try again..."
    printf ":: Valid values are [Y]es or [n]o (case insensitive), or press [return] for default (Yes)\n"
    break
    ;;
  esac
done
