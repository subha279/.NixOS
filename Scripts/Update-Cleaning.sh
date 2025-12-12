#!/bin/bash

# Ensure the script is run as a normal user (not root)
if [ "$(id -u)" -eq 0 ]; then
    echo "Please do not run this script as root."
    exit 1
fi

echo "Updating system"
yay -Syua  # Remove sudo from here

echo "Clearing Pacman cache"
pacman_cache_used="$(du -sh /var/cache/pacman/pkg/ 2>/dev/null)"  # Suppress permission errors
echo "Space used before clearing: $pacman_cache_used"
sudo paccache -r  # We need sudo for this because it's system-wide cache
pacman_cache_after="$(du -sh /var/cache/pacman/pkg/ 2>/dev/null)"  # Suppress permission errors
echo "Space used after clearing: $pacman_cache_after"

echo "Removing orphan packages"
orphans=$(yay -Qdtq)  # Corrected command to list orphan packages
if [ -n "$orphans" ]; then
    echo "Orphans found: $orphans"
    sudo yay -Rns $orphans  # We need sudo for removing packages
    echo "Orphans removed"
else
    echo "No orphan packages found"
fi

echo "Clearing ~/.cache"
home_cache_used="$(du -sh ~/.cache)"
echo "Space used before clearing: $home_cache_used"
rm -rf ~/.cache/*
home_cache_after="$(du -sh ~/.cache)"
echo "Space used after clearing: $home_cache_after"

echo "Clearing system logs"
sudo journalctl --vacuum-time=7d  # sudo required for clearing system logs

echo "System cleanup completed."

