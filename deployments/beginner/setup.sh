#!/usr/bin/env bash
# setup.sh — Deploy beginner Claude Code configuration to a project
#
# Usage: ./setup.sh [target-directory]
#   target-directory: Path to the project to configure (default: current directory)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="${1:-.}"
TARGET="$(cd "$TARGET" 2>/dev/null && pwd)" || { echo "Error: Directory '$1' does not exist."; exit 1; }

echo "=== Claude Code Bootstrap — Beginner Setup ==="
echo "Target: $TARGET"
echo ""

# Create .claude directory
mkdir -p "$TARGET/.claude"

# Copy CLAUDE.md template (don't overwrite existing)
if [ -f "$TARGET/CLAUDE.md" ]; then
    echo "SKIP  CLAUDE.md (already exists)"
    echo "      To overwrite, remove it first and re-run this script."
else
    cp "$SCRIPT_DIR/CLAUDE.md.template" "$TARGET/CLAUDE.md"
    echo "ADDED CLAUDE.md — edit the [BRACKETED] placeholders with your project details"
fi

# Copy settings (don't overwrite existing)
if [ -f "$TARGET/.claude/settings.local.json" ]; then
    echo "SKIP  .claude/settings.local.json (already exists)"
else
    cp "$SCRIPT_DIR/.claude/settings.local.json" "$TARGET/.claude/settings.local.json"
    echo "ADDED .claude/settings.local.json — adjust allow/deny lists for your toolchain"
fi

echo ""
echo "=== Setup Complete ==="
echo ""
echo "Next steps:"
echo "  1. Edit CLAUDE.md — replace [BRACKETED] placeholders with your project details"
echo "  2. Edit .claude/settings.local.json — adjust permissions for your toolchain"
echo "  3. Start Claude Code: claude"
echo "  4. Try: 'Read CLAUDE.md and confirm you understand the project.'"
