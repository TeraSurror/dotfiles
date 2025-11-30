#!/bin/bash

# Top-level sync script to run all individual sync commands

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
echo "Syncing all dotfiles from: $PROJECT_DIR"
echo ""

# Function to run sync script and capture output
run_sync() {
    local script_name="$1"
    local script_path="$PROJECT_DIR/$script_name/sync.sh"
    
    echo "=== Running $script_name sync ==="
    if [ -f "$script_path" ]; then
        chmod +x "$script_path"
        bash "$script_path"
        if [ $? -eq 0 ]; then
            echo "✓ $script_name sync completed successfully"
            echo ""
            return 0
        else
            echo "✗ $script_name sync failed"
            echo ""
            return 1
        fi
    else
        echo "⚠ Sync script not found for $script_name: $script_path"
        echo ""
        return 1
    fi
}

# Run all sync scripts
run_sync "nvim"
run_sync "tmux"  
run_sync "zsh"

echo "=== All sync operations completed ==="
echo "Note: Some changes may require terminal restart or reload to take effect"