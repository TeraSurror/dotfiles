#!/bin/bash

# Script to sync .tmux.conf from home directory to project

PROJECT_DIR="/Users/harshshelar/Desktop/Projects/dotfiles"
TMUX_FILE="$PROJECT_DIR/tmux/.tmux.conf"
HOME_TMUX="$HOME/.tmux.conf"

# Check if the tmux file exists in home directory
if [ ! -f "$HOME_TMUX" ]; then
    echo "Error: .tmux.conf not found in home directory"
    exit 1
fi

# Copy to project directory
cp "$HOME_TMUX" "$TMUX_FILE"

if [ $? -eq 0 ]; then
    echo "Successfully synced .tmux.conf from home directory to project"
else
    echo "Error: Failed to copy .tmux.conf"
    exit 1
fi