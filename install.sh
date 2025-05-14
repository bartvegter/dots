#!/usr/bin/env bash

BASE_PKGS="\
    alacritty\
    blueberry\
    cliphist\
    gdm\
    gnome-keyring\
    libnotify\
    linux-lts\
    linux-lts-headers\
    grimblast-git\
    hyprland\
    hyprlock\
    hyprpaper\
    hyprpicker\
    hyprpolkitagent\
    mako\
    nmtui\
    pamixer\
    pavucontrol\
    playerctl\
    pipewire\
    reflector
    rofi-emoji\
    rofi-wayland\
    uwsm\
    waybar\
    wireplumber\
    wl-clip-persist\
    wl-clipboard\
    wlogout\
    wlsunset\
    xdg-desktop-portal-gtk\
    xdg-desktop-portal-hyprland\
    "

THEME_PKGS="\
    gruvbox-gtk-theme-git\
    gruvbox-icon-theme-git\
    noto-fonts\
    noto-fonts-cjk\
    noto-fonts-emoji
    noto-fonts-extra\
    ttf-jetbrains-mono-nerd\
    ttf-ms-win11-auto\
    "

DEV_PKGS="\
    clang\
    intellij-idea-ultimate-edition\
    jdk21-openjdk\
    nodejs-lts-jod\
    npm\
    postgresql\
    python\
    webstorm\
    "

USER_PKGS="\
    bat\
    bottles\
    brave-bin\
    btop\
    discord\
    easyeffects\
    file-roller\
    firefox\
    lazygit\
    nautilus\
    nautilus-image-converter\
    neovim\
    obsidian\
    onlyoffice-bin\
    proton-vpn-gtk-app\
    ripgrep\
    seahorse\
    spotify-launcher\
    starship\
    syncthing\
    ticktick\
    timeshift\
    tldr\
    udiskie\
    zathura\
    zsh\
    zathura-pdf-mupdf\
    "

GAMING_PKGS="\
    gamescope\
    gamemode\
    lib32-mesa\
    lib32-vulkan-radeon\
    lutris\
    mangohud\
    mesa\
    minecraft-launcher\
    protontricks\
    protonup-qt\
    steam\
    vulkan-radeon\
    wine\
    wine-gecko\
    wine-mono\
    winetricks\
    "

# Installing paru as AUR helper
printf "\n:: Installing paru...\n"
sudo pacman -S --needed base-devel -y
cd $HOME
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd $HOME
rm -rf $HOME/paru

# Installing and using GNU stow
paru -S --needed stow -y
stow -d $HOME/dots

# Installing packages
printf "\n:: Installing packages...\n"
paru -Syu --needed "$BASE_PKGS $THEME_PKGS $DEV_PKGS $USER_PKGS $GAMING_PKGS"
printf "\n:: Package install complete\n"

# Applying themes
# - TODO -

# Audio setup
# - TODO -

# Adding LTS kernel to bootloader
# - TODO -

printf "\n:: Installation done"
