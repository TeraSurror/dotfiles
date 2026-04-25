#!/bin/bash

PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
CLAUDE_COMMANDS_SRC="$PROJECT_DIR/claude/commands"
CLAUDE_COMMANDS_DEST="$HOME/.claude/commands"

if [ ! -d "$CLAUDE_COMMANDS_SRC" ]; then
    echo "Error: claude/commands directory not found at $CLAUDE_COMMANDS_SRC"
    exit 1
fi

mkdir -p "$CLAUDE_COMMANDS_DEST"
rsync -av --delete "$CLAUDE_COMMANDS_SRC/" "$CLAUDE_COMMANDS_DEST/"

if [ $? -eq 0 ]; then
    echo "Successfully synced claude commands to $CLAUDE_COMMANDS_DEST"
else
    echo "Error: Failed to sync claude commands"
    exit 1
fi
