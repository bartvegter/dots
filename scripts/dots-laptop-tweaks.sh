#!/usr/bin/env bash

function enableLaptopTweaks() {
  printf "\n:: Installing necessary packages..."
  paru -S --needed --noconfirm tlpui tlp ethtool smartmontools

  printf "\n:: Masking conflicting systemd units..."
  sudo systemctl mask systemd-rfkill.socket && sudo systemctl mask systemd-rfkill.service

  printf "\n:: Enabling and starting tlp for power management..."
  sudo systemctl enable tlp.service --now

  printf "\n:: Updating /etc/systemd/logind.conf to let Hyprland handle laptop lid switch..."
  if grep "^#HandleLidSwitch=" /etc/systemd/logind.conf; then
    sudo sed -i "s/^#HandleLidSwitch=.*$/HandleLidSwitch=ignore/" /etc/systemd/logind.conf
  fi
  if grep "^#HandleLidSwitchExternalPower=" /etc/systemd/logind.conf; then
    sudo sed -i "s/^#HandleLidSwitchExternalPower=.*$/HandleLidSwitchExternalPower=ignore/" /etc/systemd/logind.conf
  fi
  if grep "^#HandleLidSwitchDocked=" /etc/systemd/logind.conf; then
    sudo sed -i "s/^#HandleLidSwitchDocked=.*$/HandleLidSwitchDocked=ignore/" /etc/systemd/logind.conf
  fi
}

function disableLaptopTweaks() {
  printf "\n:: Disabling and stopping tlp..."
  sudo systemctl disable tlp.service --now

  printf "\n:: Masking conflicting systemd units..."
  sudo systemctl unmask systemd-rfkill.socket && sudo systemctl unmask systemd-rfkill.service

  printf "\n:: Uninstalling power management packages..."
  paru -Rns --noconfirm tlpui tlp ethtool smartmontools
}

echo ":: What would you like to do?"
echo "   1. Enable laptop tweaks"
echo "   2. Disable laptop tweaks"
printf "   3. Exit this script\n"
while true; do
  read -rp ">> Please make your choice (1-3): " menu_choice
  case $menu_choice in
  "1")
    enableLaptopTweaks
    printf "\n:: Done enabling tweaks"
    break
    ;;
  "2")
    disableLaptopTweaks
    printf "\n:: Done disabling tweaks"
    break
    ;;
  "3")
    printf "\n:: Exiting..."
    break
    ;;
  *)
    printf "\n:: Invalid input, please try again...\n:: Valid values are 1 for enabling, 2 for disabling or 3 to exit the script\n"
    break
    ;;
  esac
done
