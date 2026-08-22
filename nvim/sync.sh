#!/bin/bash

# Script to sync nvim configuration from project to nvim config directory

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
NVIM_PROJECT_DIR="$SCRIPT_DIR"
NVIM_CONFIG_DIR="$HOME/.config/nvim"

if [ ! -d "$NVIM_PROJECT_DIR" ]; then
    echo "Error: nvim directory not found in $SCRIPT_DIR"
    exit 1
fi

mkdir -p "$NVIM_CONFIG_DIR"

# Rsync configuration to ~/.config/nvim
rsync -av --delete "$NVIM_PROJECT_DIR/" "$NVIM_CONFIG_DIR/" --exclude="sync.sh"

if [ $? -eq 0 ]; then
    echo "✓ Successfully synced nvim configuration to $NVIM_CONFIG_DIR"
else
    echo "✗ Error: Failed to sync nvim configuration"
    exit 1
fi
