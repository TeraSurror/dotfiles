#!/bin/bash

# Script to copy .zshrc from home directory to project directory

SOURCE="$HOME/.zshrc"
DEST="$(dirname "$0")/.zshrc"

if [ ! -f "$SOURCE" ]; then
    echo "Error: Source file $SOURCE does not exist."
    exit 1
fi

# Create backup if destination already exists
if [ -f "$DEST" ]; then
    BACKUP="${DEST}.backup.$(date +%Y%m%d_%H%M%S)"
    cp "$DEST" "$BACKUP"
    echo "Created backup: $BACKUP"
fi

# Copy the file
cp "$SOURCE" "$DEST"

if [ $? -eq 0 ]; then
    echo "Successfully copied .zshrc from home directory to project directory."
    echo "Source: $SOURCE"
    echo "Destination: $DEST"
else
    echo "Error: Failed to copy .zshrc"
    exit 1
fi

