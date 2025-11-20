#!/usr/bin/env bash

while true; do
    tidalctl="playerctl --player=tidal-hifi"
    playerStatus=$($tidalctl status 2>/dev/null)
    if [[ "$playerStatus" == "Playing" ]]; then
	echo " $($tidalctl metadata artist) - $($tidalctl metadata title)"
    elif [[ "$playerStatus" == "Paused" ]]; then
        echo " $($tidalctl metadata artist) - $($tidalctl metadata title)"
    else
        echo ""
    fi
    sleep 0.1
done
