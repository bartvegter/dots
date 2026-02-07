#!/usr/bin/env bash

SCRIPTS_DIR="$(pwd)/scripts/"
SCRIPTS=$(find "${SCRIPTS_DIR}" -type f -name "*.sh")

for SCRIPT in ${SCRIPTS}; do
  SCRIPT_NAME=$(basename "${SCRIPT}")
  LINK_NAME="${SCRIPT_NAME%.sh}"
  sudo ln -s "${SCRIPT}" "/usr/local/bin/${LINK_NAME}"
done
