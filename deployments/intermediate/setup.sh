#!/usr/bin/env bash
# setup.sh — Deploy intermediate Claude Code configuration to a project
#
# Usage: ./setup.sh [target-directory]
#   target-directory: Path to the project to configure (default: current directory)
#
# Includes everything from the beginner tier plus:
# - Architecture documentation template
# - Module documentation system
# - Development workflows (feature, bug-fix, refactoring)
# - Code conventions (style, testing, git)
# - Design methodology (6-phase structured design)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="${1:-.}"
TARGET="$(cd "$TARGET" 2>/dev/null && pwd)" || { echo "Error: Directory '$1' does not exist."; exit 1; }

echo "=== Claude Code Bootstrap — Intermediate Setup ==="
echo "Target: $TARGET"
echo ""

copy_if_missing() {
    local src="$1"
    local dest="$2"
    local label="$3"
    if [ -f "$dest" ]; then
        echo "SKIP  $label (already exists)"
    else
        mkdir -p "$(dirname "$dest")"
        cp "$src" "$dest"
        echo "ADDED $label"
    fi
}

# Core files
copy_if_missing "$SCRIPT_DIR/CLAUDE.md.template" "$TARGET/CLAUDE.md" "CLAUDE.md"
copy_if_missing "$SCRIPT_DIR/.claude/settings.local.json" "$TARGET/.claude/settings.local.json" ".claude/settings.local.json"

# Architecture
copy_if_missing "$SCRIPT_DIR/.claude/architecture.md" "$TARGET/.claude/architecture.md" ".claude/architecture.md"

# Module template
copy_if_missing "$SCRIPT_DIR/.claude/modules/_template.md" "$TARGET/.claude/modules/_template.md" ".claude/modules/_template.md"

# Workflows
for f in feature-development bug-fixes refactoring; do
    copy_if_missing "$SCRIPT_DIR/.claude/workflows/$f.md" "$TARGET/.claude/workflows/$f.md" ".claude/workflows/$f.md"
done

# Conventions
for f in code-style testing git-workflow; do
    copy_if_missing "$SCRIPT_DIR/.claude/conventions/$f.md" "$TARGET/.claude/conventions/$f.md" ".claude/conventions/$f.md"
done

# Design methodology
for f in design-session exploration-phase requirements-phase options-phase decision-phase detail-phase validation-phase; do
    copy_if_missing "$SCRIPT_DIR/.claude/design/workflows/$f.md" "$TARGET/.claude/design/workflows/$f.md" ".claude/design/workflows/$f.md"
done

copy_if_missing "$SCRIPT_DIR/.claude/design/conventions/design-thinking.md" "$TARGET/.claude/design/conventions/design-thinking.md" ".claude/design/conventions/design-thinking.md"

for f in DESIGN_DOCUMENT ADR_TEMPLATE SESSION_NOTES; do
    copy_if_missing "$SCRIPT_DIR/.claude/design/templates/$f.md" "$TARGET/.claude/design/templates/$f.md" ".claude/design/templates/$f.md"
done

# Docs
for f in design-workflow-guide design-phase-reference adr-guide; do
    copy_if_missing "$SCRIPT_DIR/docs/design/$f.md" "$TARGET/docs/design/$f.md" "docs/design/$f.md"
done

copy_if_missing "$SCRIPT_DIR/docs/permissions-guide.md" "$TARGET/docs/permissions-guide.md" "docs/permissions-guide.md"
copy_if_missing "$SCRIPT_DIR/docs/git-setup.md" "$TARGET/docs/git-setup.md" "docs/git-setup.md"
copy_if_missing "$SCRIPT_DIR/docs/gh-cli-setup.md" "$TARGET/docs/gh-cli-setup.md" "docs/gh-cli-setup.md"

echo ""
echo "=== Setup Complete ==="
echo ""
echo "Next steps:"
echo "  1. Edit CLAUDE.md — replace [BRACKETED] placeholders with your project details"
echo "  2. Edit .claude/settings.local.json — adjust permissions for your toolchain"
echo "  3. Run: claude"
echo "  4. Create architecture doc: 'Analyze this codebase and create .claude/architecture.md'"
echo "  5. Create module docs: cp .claude/modules/_template.md .claude/modules/<component>.md"
echo "  6. Try: /load-workflow feature-development"
