#!/bin/bash
# Script to verify all required submodules are present and initialized

set -e

REQUIRED_SUBMODULES=(
    "cosmic-applets"
    "cosmic-applibrary"
    "cosmic-bg"
    "cosmic-comp"
    "cosmic-edit"
    "cosmic-files"
    "cosmic-greeter"
    "cosmic-icons"
    "cosmic-idle"
    "cosmic-initial-setup"
    "cosmic-launcher"
    "cosmic-notifications"
    "cosmic-osd"
    "cosmic-panel"
    "cosmic-player"
    "cosmic-randr"
    "cosmic-screenshot"
    "cosmic-session"
    "cosmic-settings"
    "cosmic-settings-daemon"
    "cosmic-store"
    "cosmic-term"
    "cosmic-wallpapers"
    "cosmic-workspaces-epoch"
    "xdg-desktop-portal-cosmic"
    "pop-launcher"
)

echo "Checking COSMIC Epoch submodules..."
echo ""

MISSING=0
UNINITIALIZED=0

for submodule in "${REQUIRED_SUBMODULES[@]}"; do
    if [ ! -d "$submodule" ]; then
        echo "❌ MISSING: $submodule (directory does not exist)"
        MISSING=$((MISSING + 1))
    elif [ ! -f "$submodule/Cargo.toml" ] && [ ! -f "$submodule/Makefile" ] && [ ! -d "$submodule/debian" ]; then
        echo "⚠️  UNINITIALIZED: $submodule (appears empty)"
        UNINITIALIZED=$((UNINITIALIZED + 1))
    else
        echo "✓ OK: $submodule"
    fi
done

echo ""
echo "Summary:"
echo "--------"
echo "Total submodules: ${#REQUIRED_SUBMODULES[@]}"
echo "Missing: $MISSING"
echo "Uninitialized: $UNINITIALIZED"
echo "OK: $((${#REQUIRED_SUBMODULES[@]} - MISSING - UNINITIALIZED))"

if [ $MISSING -gt 0 ] || [ $UNINITIALIZED -gt 0 ]; then
    echo ""
    echo "❌ Some submodules are missing or uninitialized!"
    echo ""
    echo "To fix this, run:"
    echo "  git submodule update --init --recursive"
    exit 1
else
    echo ""
    echo "✓ All submodules are present and initialized!"
    exit 0
fi
