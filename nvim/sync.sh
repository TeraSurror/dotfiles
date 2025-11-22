#!/bin/bash

# Script to sync init.lua from project to nvim config directory

PROJECT_DIR="/Users/harshshelar/Desktop/Projects/dotfiles"
NVIM_FILE="$PROJECT_DIR/nvim/init.lua"
NVIM_CONFIG_DIR="$HOME/.config/nvim"
NVIM_CONFIG_FILE="$NVIM_CONFIG_DIR/init.lua"

# Check if the init.lua file exists in project
if [ ! -f "$NVIM_FILE" ]; then
    echo "Error: init.lua not found in $PROJECT_DIR/nvim/"
    exit 1
fi

# Create nvim config directory if it doesn't exist
mkdir -p "$NVIM_CONFIG_DIR"

# Copy to nvim config directory
cp "$NVIM_FILE" "$NVIM_CONFIG_FILE"

if [ $? -eq 0 ]; then
    echo "Successfully synced init.lua to nvim config directory"
else
    echo "Error: Failed to copy init.lua"
    exit 1
fi
