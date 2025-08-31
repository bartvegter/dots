#!/usr/bin/env bash

if [[ -n "$1" ]]; then
    for ((i=1;i<=10;i++));
    do
	hyprctl dispatch moveworkspacetomonitor $i $1 >/dev/null 2>&1
    done
fi
