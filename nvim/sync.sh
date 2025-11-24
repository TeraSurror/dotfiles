#!/bin/bash

# Script to sync nvim configuration from project to nvim config directory

PROJECT_DIR="/Users/harshshelar/Desktop/Projects/dotfiles"
NVIM_PROJECT_DIR="$PROJECT_DIR/nvim"
NVIM_CONFIG_DIR="$HOME/.config/nvim"

# Check if the nvim directory exists in project
if [ ! -d "$NVIM_PROJECT_DIR" ]; then
    echo "Error: nvim directory not found in $PROJECT_DIR/"
    exit 1
fi

# Create nvim config directory if it doesn't exist
mkdir -p "$NVIM_CONFIG_DIR"

# Copy entire nvim directory structure to config directory
rsync -av --delete "$NVIM_PROJECT_DIR/" "$NVIM_CONFIG_DIR/" --exclude="sync.sh"

if [ $? -eq 0 ]; then
    echo "Successfully synced nvim configuration to $NVIM_CONFIG_DIR"
else
    echo "Error: Failed to sync nvim configuration"
    exit 1
fi


