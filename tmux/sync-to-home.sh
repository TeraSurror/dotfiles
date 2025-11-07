#!/bin/bash

# Script to sync .tmux.conf from project to home directory

PROJECT_DIR="/Users/harshshelar/Desktop/Projects/dotfiles"
TMUX_FILE="$PROJECT_DIR/tmux/.tmux.conf"
HOME_TMUX="$HOME/.tmux.conf"

# Check if the tmux file exists in project
if [ ! -f "$TMUX_FILE" ]; then
    echo "Error: .tmux.conf not found in $PROJECT_DIR/tmux/"
    exit 1
fi

# Copy to home directory
cp "$TMUX_FILE" "$HOME_TMUX"

if [ $? -eq 0 ]; then
    echo "Successfully synced .tmux.conf to home directory"
else
    echo "Error: Failed to copy .tmux.conf"
    exit 1
fi