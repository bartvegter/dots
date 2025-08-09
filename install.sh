#!/usr/bin/env bash
set -euo pipefail

BASE_PKGS=(
  brightnessctl blueberry bluez-utils cliphist cups gnome-keyring less libnotify ghostty
  grimblast-git hyprland hyprlock hyprpicker hyprpolkitagent libgnome-keyring man-db openssh
  pamixer pavucontrol playerctl pipewire python python-pywal qt5-wayland qt6-wayland reflector
  rofi-emoji rofi-wayland sddm swaync swayosd swww tree uwsm vim waybar wireplumber wf-recorder
  wl-clip-persist wl-clipboard wlsunset xdg-desktop-portal-gtk xdg-desktop-portal-hyprland
)

THEME_PKGS=(
  gruvbox-gtk-theme-git gruvbox-icon-theme-git noto-fonts noto-fonts-cjk noto-fonts-emoji
  noto-fonts-extra qt6-declarative qt5-quickcontrols2 qt5-svg qt6-svg sddm-sugar-dark
  ttf-aptos ttf-jetbrains-mono-nerd ttf-ms-win11-auto
)

DEV_PKGS=(
  android-tools cmake intellij-idea-ultimate-edition jdk21-jetbrains-bin mtpfs nodejs-lts-jod npm
  postgresql python webstorm webstorm-jre
)

USER_PKGS=(
  bat bottles brave-bin btop catfish discord easyeffects file-roller fzf gvfs gvfs-mtp lazygit
  libopenraw lua-language-server nautilus nautilus-image-converter neovim obsidian onlyoffice-bin
  poppler-glib proton-vpn-gtk-app ripgrep seahorse spotify-launcher sushi syncthing ticktick
  timeshift tldr tumbler udiskie unrar unzip viewnior vim webp-pixbuf-loader xorg-xhost
  zathura zathura-pdf-poppler zen-browser-bin zip zsh zsh-autosuggestions zsh-syntax-highlighting
)

GAMING_PKGS=(
  gamescope gamemode lib32-mesa lib32-vulkan-radeon mangohud mesa minecraft-launcher
  protontricks protonup-qt steam vulkan-radeon wine-staging wine-gecko wine-mono winetricks
)

ALL_PKGS=(
  "${BASE_PKGS[@]}"
  "${THEME_PKGS[@]}"
  "${DEV_PKGS[@]}"
  "${USER_PKGS[@]}"
  "${GAMING_PKGS[@]}"
)

# -----------------------------------------------
# Install paru if not installed already
# -----------------------------------------------

echo ":: Checking if paru is installed..."
if ! command -v paru &>/dev/null; then
  echo ":: Paru is not yet installed. Installing now..."
  sudo pacman -Syu --needed base-devel git rust
  git clone https://aur.archlinux.org/paru.git "$HOME/paru"
  pushd "$HOME/paru"
  makepkg -si --noconfirm
  popd
  rm -rf "$HOME/paru"
else
  echo ":: Found existing installation of paru. Continuing..."
fi

# -----------------------------------------------
# Use GNU stow if dotfiles are available
# -----------------------------------------------

echo ":: Installing and setting up GNU stow for dotfile management"
if [[ -d "$HOME/dots" ]]; then
  paru -Syu --needed stow
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

echo ":: Installing all packages..."
paru -Syu --needed "${ALL_PKGS[@]}" -y
echo ":: Package install completed"

# -----------------------------------------------
# SDDM setup
# -----------------------------------------------

echo ":: Enabling SDDM as display manager"
sudo systemctl enable sddm.service
if [[ ! -d "/etc/sddm.conf.d" ]]; then
    sudo mkdir /etc/sddm.conf.d
fi
sudo cp "$HOME/dots/etc/sddm.conf" "/etc/sddm.conf.d/sddm.conf"

# -----------------------------------------------
# Lofree Flow keyboard patches
# -----------------------------------------------

while true; do
  read -p ">> Would you like to apply patches for Lofree Flow keyboard? [y/N]: " ynLofree
  case $ynLofree in
    "Y" | "y")
      echo ":: Applying Lofree Flow keyboard patches..."
      if [[ ! -d "/etc/modprobe.d" ]]; then
        sudo mkdir /etc/modprobe.d
      fi
      sudo cp "$HOME/dots/etc/hid_apple.conf" "/etc/modprobe.d/hid_apple.conf"
      sudo mkinitcpio -P
      break
      ;;
    "" | "N" | "n")
      echo && echo ":: Continuing..."
      break
      ;;
    *)
      echo ":: Invalid input, please try again..." && echo
      echo ":: Valid values are [y]es or [N]o (case insensitive), or press [return] for default (No)"
      break
      ;;
  esac
done

# -----------------------------------------------
# Finishing touches
# -----------------------------------------------

while true; do
  read -p ">> Would you like to enable bluetooth on your system? [y/N]: " ynBluetooth
  case $ynBluetooth in
    "Y" | "y")
      echo && echo ":: Enabling bluetooth through systemd..."
      systemctl enable bluetooth
      break
      ;;
    "" | "N" | "n")
      echo && echo ":: Continuing..."
      break
      ;;
    *)
      echo ":: Invalid input, please try again..." && echo
      echo ":: Valid values are [y]es or [N]o (case insensitive), or press [return] for default (No)"
      break
      ;;
  esac
done

while true; do
  read -p ">> Would you like to setup your git credentials? [y/N]: " ynGit
  case $ynGit in
    "Y" | "y")
      echo ":: Setting up git credentials..."
      read -p ">> What is your git name (e.g. 'John Smith')? " gitName
      git config --global user.name "$gitName"

      read -p ">> What is your email address tied to your remotes account? " gitEmail
      git config --global user.email "$gitEmail"
      break
      ;;
    "" | "N" | "n")
      echo && echo ":: Continuing..."
      break
      ;;
    *)
      echo ":: Invalid input, please try again..." && echo
      echo ":: Valid values are [y]es or [N]o (case insensitive), or press [return] for default (No)"
      break
      ;;
  esac
done

while true; do
  read -p ">> Would you like to enable the ssh agent? [y/N]: " ynSshService
  case $ynSshService in
    "Y" | "y")
      echo && echo ":: Enabling ssh agent as systemd user unit..."
      systemctl --user enable --now gcr-ssh-agent.socket
	while true; do
	  read -p ">> Would you like to add an ssh key to the agent? [y/N]: " ynSshKey
	  case $ynSshKey in
	    "Y" | "y")
	      read -p ">> Enter the location of your private key (e.g. ~/.ssh/key or /home/user/.ssh/key)? " keyLocation
	      /usr/lib/seahorse/ssh-askpass $keyLocation
	      break
	      ;;
	    "" | "N" | "n")
	      echo && echo ":: Continuing..."
	      break
	      ;;
	    *)
	      echo ":: Invalid input, please try again..." && echo
	      echo ":: Valid values are [y]es or [N]o (case insensitive), or press [return] for default (No)"
	      break
	      ;;
	  esac
	done
      break
      ;;
    "" | "N" | "n")
      echo && echo ":: Continuing..."
      break
      ;;
    *)
      echo ":: Invalid input, please try again..." && echo
      echo ":: Valid values are [y]es or [N]o (case insensitive), or press [return] for default (No)"
      break
      ;;
  esac
done


echo && echo ":: Enabling reflector.timer for automatic mirrorlist updates..."
sudo systemctl enable reflector.timer

echo && echo ":: Setting zsh as default user shell..."
chsh -s $(which zsh)

echo && echo ":: Installation complete"
while true; do
  read -p ">> Would you like to reboot into Hyprland? [Y/n]: " ynReboot
  case $ynReboot in
    "" | "Y" | "y")
      echo && echo ":: Rebooting system..."
      systemctl reboot
      break
      ;;

    "N" | "n")
      echo && echo ":: When ready, run 'systemctl reboot' to reboot into Hyprland"
      break
      ;;

    *)
      echo ":: Invalid input, please try again..." && echo
      echo ":: Valid values are [Y]es or [n]o (case insensitive), or press [return] for default (Yes)"
      break
      ;;
  esac
done
