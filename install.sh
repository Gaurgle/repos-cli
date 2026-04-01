#!/usr/bin/env bash
set -eo pipefail

INSTALL_DIR="${1:-$HOME/.local/bin}"

# Check dependencies
missing=()
for cmd in gh jq git; do
    command -v "$cmd" >/dev/null 2>&1 || missing+=("$cmd")
done

if [ ${#missing[@]} -gt 0 ]; then
    echo "Missing required tools: ${missing[*]}"
    echo "Install them before continuing."
    exit 1
fi

# Ensure gh is authenticated
if ! gh auth status >/dev/null 2>&1; then
    echo "gh is not authenticated. Run: gh auth login"
    exit 1
fi

# Install
mkdir -p "$INSTALL_DIR"
cp repos "$INSTALL_DIR/repos"
chmod +x "$INSTALL_DIR/repos"

echo "Installed repos to $INSTALL_DIR/repos"

if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo ""
    echo "Note: $INSTALL_DIR is not in your PATH."
    echo "Add it with: export PATH=\"$INSTALL_DIR:\$PATH\""
fi
