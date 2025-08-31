#!/usr/bin/env bash

function enableLaptopTweaks() {
  echo && echo ":: Installing necessary packages..."
  paru -S --needed tlpui tlp ethtool smartmontools hypridle kanshi

  echo && echo ":: Enabling and starting tlp for power management..."
  sudo systemctl enable tlp.service --now

  echo && echo ":: Masking conflicting systemd units..."
  sudo systemctl mask systemd-rfkill.socket && sudo systemctl mask systemd-rfkill.service

  echo && echo ":: Enabling hypridle..."
  systemctl --user enable --now hypridle
}

function disableLaptopTweaks() {
  echo && echo ":: Disabling hypridle..."
  systemctl --user disable --now hypridle

  echo && echo ":: Disabling and stopping tlp..."
  sudo systemctl disable tlp.service --now

  echo && echo ":: Masking conflicting systemd units..."
  sudo systemctl unmask systemd-rfkill.socket && sudo systemctl unmask systemd-rfkill.service

  echo && echo ":: Uninstalling power management packages..."
  paru -Rns tlpui tlp ethtool smartmontools hypridle kanshi
}

echo && echo ":: What would you like to do?"
echo "   1. Enable laptop tweaks"
echo "   2. Disable laptop tweaks"
echo "   3. Nothing (exit)"
while true; do
  read -p ">> Please make your choice (1-3): " menuChoice
  case $menuChoice in
    "1")
      echo && echo ":: Enabling tweaks..."
      enableLaptopTweaks
      echo && echo ":: Done enabling tweaks"
      break
      ;;
    "2")
      echo && echo ":: Disabling tweaks..."
      disableLaptopTweaks
      echo && echo ":: Done disabling tweaks"
      break
      ;;
    "3")
      echo && echo ":: Exiting..."
      break
      ;;
    *)
      echo && echo ":: Invalid input, please try again..."
      echo ":: Valid values are 1 for enabling, 2 for disabling or 3 to exit the script"
      break
      ;;
  esac
done
