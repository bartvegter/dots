#!/usr/bin/env bash

while true; do
  sonectl="playerctl --player=io.github.lullabyX.sone"
  playerStatus=$($sonectl status 2>/dev/null)
  if [[ "$playerStatus" == "Playing" ]]; then
    echo " $($sonectl metadata artist) - $($sonectl metadata title)"
  elif [[ "$playerStatus" == "Paused" ]]; then
    echo " $($sonectl metadata artist) - $($sonectl metadata title)"
  else
    echo ""
  fi
  sleep 0.1
done
