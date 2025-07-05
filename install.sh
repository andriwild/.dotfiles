#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Check if exactly one argument (path to the package list file) is provided.
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <package_list_file>"
  exit 1
fi

PACKAGE_FILE="$1"
FAILED_FILE="failed_pkg_install"

# Check if the file exists
if [ ! -f "$PACKAGE_FILE" ]; then
  echo "File '$PACKAGE_FILE' not found."
  exit 1
fi

# Ensure the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root or with sudo."
  exit 1
fi

# Clear the old failed file
: > "$FAILED_FILE"

# Count total non-empty lines (packages) for progress indication
TOTAL=$(grep -cv '^\s*$' "$PACKAGE_FILE")
CURRENT=0

echo "Starting installation of packages from '$PACKAGE_FILE'..."
echo "Total packages to process: $TOTAL"

# Process each package in the file
while IFS= read -r pkg || [ -n "$pkg" ]; do
  # Skip empty lines
  if [ -z "$pkg" ]; then
    continue
  fi

  CURRENT=$((CURRENT + 1))
  echo "[$CURRENT/$TOTAL] Processing package: '$pkg'..."

  # Check if the package is already installed
  if dpkg -s "$pkg" &> /dev/null; then
    echo "Package '$pkg' is already installed - skipping."
  else
    echo "Installing package '$pkg'..."
    if ! apt install -y "$pkg"; then
      echo "$pkg" >> "$FAILED_FILE"
      echo "Error: Installation of '$pkg' failed. Logged in '$FAILED_FILE'."
    fi
  fi
done < "$PACKAGE_FILE"

echo "Installation process completed."
if [ -s "$FAILED_FILE" ]; then
  echo "The following packages failed to install:"
  cat "$FAILED_FILE"
else
  echo "All packages installed successfully."
fi
