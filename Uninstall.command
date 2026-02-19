#!/bin/bash
echo -e "\033[1;31mUninstalling sync-github...\033[0m"

# Remove symlink
if [ -L "$HOME/.local/bin/sync-github" ]; then
    rm -f "$HOME/.local/bin/sync-github"
    echo "* Removed CLI 'sync-github' from ~/.local/bin"
fi

# Remove Linux desktop entry
if [ -f "$HOME/.local/share/applications/sync-github.desktop" ]; then
    rm -f "$HOME/.local/share/applications/sync-github.desktop"
    echo "* Removed Linux .desktop application entry"
fi

# Remove Mac App if exists
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APP_DIR="$DIR/Sync GitHub.app"
if [ -d "$APP_DIR" ]; then
    rm -rf "$APP_DIR"
    echo "* Removed macOS 'Sync GitHub.app'"
fi

echo -e "\033[1;32m✅ Uninstallation Complete.\033[0m"
