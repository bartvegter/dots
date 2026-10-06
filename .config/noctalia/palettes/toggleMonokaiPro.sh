#!/usr/bin/env bash

proFg="#FCFCFA"
proGreyLight="#C1C0C0"
proGreyMid="#727072"
proGreyDark="#403E41"
proBg="#2D2A2E"
proRed="#FF6188"
proCyan="#FC9867"
proYellow="#FFD866"
proGreen="#A9DC76"
proBlue="#78DCE8"
proMagenta="#AB9DF2"

proRisFg="#FFF1F3"
proRisGreyLight="#C3B7B8"
proRisGreyMid="#72696A"
proRisGreyDark="#403838"
proRisBg="#2C2525"
proRisRed="#FD6883"
proRisCyan="#F38D70"
proRisYellow="#F9CC6C"
proRisGreen="#ADDA78"
proRisBlue="#85DACC"
proRisMagenta="#A8A9EB"

set -euo pipefail

usage() {
  printf 'Usage: %s FILE\n' "${0##*/}" >&2
}

if [[ $# -ne 1 ]]; then
  usage
  exit 64
fi

target_file=$1

if [[ ! -f $target_file ]]; then
  printf 'Error: "%s" is not a regular file.\n' "$target_file" >&2
  exit 66
fi

pro_colors=(
  "$proFg" "$proGreyLight" "$proGreyMid" "$proGreyDark" "$proBg"
  "$proRed" "$proCyan" "$proYellow" "$proGreen" "$proBlue" "$proMagenta"
)
pro_ris_colors=(
  "$proRisFg" "$proRisGreyLight" "$proRisGreyMid" "$proRisGreyDark" "$proRisBg"
  "$proRisRed" "$proRisCyan" "$proRisYellow" "$proRisGreen" "$proRisBlue" "$proRisMagenta"
)

sed_expressions=()
for index in "${!pro_colors[@]}"; do
  sed_expressions+=(
    -e "s|${pro_colors[index]}|${pro_ris_colors[index]}|g"
  )
done

sed -i "${sed_expressions[@]}" -- "$target_file"
printf 'Updated Monokai Pro colors in %s\n' "$target_file"
