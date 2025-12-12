#!/bin/sh

DIR="$HOME/Wallpaper/"
SCRIPTS="$HOME/Scripts/"

# Find image files in the specified directory
PICS=($(find "$DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.gif" \)))

# Check if the array is empty
if [ ${#PICS[@]} -eq 0 ]; then
    echo "No images found in $DIR"
    exit 1
fi

# Generate a random index to pick an image
RANDOM_INDEX=$(( RANDOM % ${#PICS[@]} ))
RANDOMPICS="${PICS[$RANDOM_INDEX]}"

# Transition settings
FPS=180
TYPE="fade"
DURATION=2
SWWW_TRANSITION="--transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION"

# Check if 'swww' is installed
if ! command -v swww > /dev/null 2>&1; then
    echo "swww command not found. Please install swww."
    exit 1
fi

# Set wallpaper with transition
swww query || swww init
swww img "$RANDOMPICS" $SWWW_TRANSITION
#&& wal -c  && wal -i ${RANDOMPICS}
