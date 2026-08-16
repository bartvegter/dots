#!/usr/bin/env bash

if [[ -n "$1" ]]; then
  for ((i = 1; i <= 10; i++)); do
    hyprctl dispatch "hl.dsp.workspace.move($i $1)" >/dev/null 2>&1
  done
fi
