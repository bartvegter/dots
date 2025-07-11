#!/usr/bin/env bash

function enablePowerSaving() {
  echo && echo ":: Installing power management packages..."
  paru -S --needed tlpui tlp ethtool smartmontools

  echo && echo ":: Enabling and starting tlp for power management..."
  sudo systemctl enable tlp.service --now

  echo && echo ":: Masking conflicting systemd units..."
  sudo systemctl mask systemd-rfkill.socket && sudo systemctl mask systemd-rfkill.service
}

function disablePowerSaving() {
  echo && echo ":: Disabling and stopping tlp..."
  sudo systemctl disable tlp.service --now

  echo && echo ":: Masking conflicting systemd units..."
  sudo systemctl unmask systemd-rfkill.socket && sudo systemctl unmask systemd-rfkill.service

  echo && echo ":: Uninstalling power management packages..."
  paru -Rns tlpui tlp ethtool smartmontools
}

echo && echo ":: What would you like to do?"
echo "   1. Enable power saving settings"
echo "   2. Disable power saving settings"
echo "   3. Nothing (exit)"
while true; do
  read -p ">> Please make your choice (1-3): " menuChoice
  case $menuChoice in
    "1")
      echo && echo ":: Enabling power saving settings..."
      enablePowerSaving
      echo && echo ":: Done enabling power saving"
      break
      ;;
    "2")
      echo && echo ":: Disabling power saving settings..."
      disablePowerSaving
      echo && echo ":: Done disabling power saving"
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
