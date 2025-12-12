#!/usr/bin/env bash

# Ensure required commands exist
for cmd in playerctl curl magick; do
    if ! command -v "$cmd" &> /dev/null; then
        echo "Error: $cmd is not installed." >&2
        exit 1
    fi
done

# Get metadata
url=$(playerctl metadata mpris:artUrl 2>/dev/null)
artist=$(playerctl metadata xesam:artist 2>/dev/null)
album=$(playerctl metadata xesam:album 2>/dev/null)

# Check if player is running
if [[ -z "$url" || "$url" == "No player found" ]]; then
    exit 1
fi

# Define cache directory
CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/albumart"
mkdir -p "$CACHE_DIR"

# Define file path
metadata="${artist} - ${album}"
file_path="$CACHE_DIR/${metadata}.webp"

# If file exists, return its path
if [[ -f "$file_path" ]]; then
    echo "$file_path"
    exit 0
fi

# Download album art to a temporary file
temp_file=$(mktemp)
curl -s "$url" -o "$temp_file"

# Convert to WebP (faster than PNG)
magick "$temp_file" -resize 512x512 "$file_path"
rm -f "$temp_file"

# Output file path
echo "$file_path"
