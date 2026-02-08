#!/usr/bin/env bash
# setup.sh — Deploy power-user Claude Code configuration to a project
#
# Usage: ./setup.sh [target-directory]
#   target-directory: Path to the project to configure (default: current directory)
#
# Includes everything from intermediate plus:
# - GitHub Actions documentation audit
# - Audit skill and workflows
# - Session hooks
# - AGENTS.md for multi-agent coordination
# - Integration guides (Superpowers, Gas Town)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="${1:-.}"
TARGET="$(cd "$TARGET" 2>/dev/null && pwd)" || { echo "Error: Directory '$1' does not exist."; exit 1; }

echo "=== Claude Code Bootstrap — Power User Setup ==="
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

# === Core Files ===
copy_if_missing "$SCRIPT_DIR/CLAUDE.md.template" "$TARGET/CLAUDE.md" "CLAUDE.md"
copy_if_missing "$SCRIPT_DIR/AGENTS.md.template" "$TARGET/AGENTS.md" "AGENTS.md"
copy_if_missing "$SCRIPT_DIR/.claude/settings.local.json" "$TARGET/.claude/settings.local.json" ".claude/settings.local.json"
copy_if_missing "$SCRIPT_DIR/.claude/settings.json" "$TARGET/.claude/settings.json" ".claude/settings.json"

# === Architecture ===
copy_if_missing "$SCRIPT_DIR/.claude/architecture.md" "$TARGET/.claude/architecture.md" ".claude/architecture.md"

# === Module Template ===
copy_if_missing "$SCRIPT_DIR/.claude/modules/_template.md" "$TARGET/.claude/modules/_template.md" ".claude/modules/_template.md"

# === Workflows ===
for f in feature-development bug-fixes refactoring documentation-audit; do
    copy_if_missing "$SCRIPT_DIR/.claude/workflows/$f.md" "$TARGET/.claude/workflows/$f.md" ".claude/workflows/$f.md"
done

# === Conventions ===
for f in code-style testing git-workflow; do
    copy_if_missing "$SCRIPT_DIR/.claude/conventions/$f.md" "$TARGET/.claude/conventions/$f.md" ".claude/conventions/$f.md"
done

# === Design Methodology ===
for f in design-session exploration-phase requirements-phase options-phase decision-phase detail-phase validation-phase; do
    copy_if_missing "$SCRIPT_DIR/.claude/design/workflows/$f.md" "$TARGET/.claude/design/workflows/$f.md" ".claude/design/workflows/$f.md"
done
copy_if_missing "$SCRIPT_DIR/.claude/design/conventions/design-thinking.md" "$TARGET/.claude/design/conventions/design-thinking.md" ".claude/design/conventions/design-thinking.md"
for f in DESIGN_DOCUMENT ADR_TEMPLATE SESSION_NOTES; do
    copy_if_missing "$SCRIPT_DIR/.claude/design/templates/$f.md" "$TARGET/.claude/design/templates/$f.md" ".claude/design/templates/$f.md"
done

# === Audit System ===
copy_if_missing "$SCRIPT_DIR/.claude/AUDIT_COMMAND.md" "$TARGET/.claude/AUDIT_COMMAND.md" ".claude/AUDIT_COMMAND.md"
copy_if_missing "$SCRIPT_DIR/.claude/skills/audit/SKILL.md" "$TARGET/.claude/skills/audit/SKILL.md" ".claude/skills/audit/SKILL.md"
copy_if_missing "$SCRIPT_DIR/.claude/skills/audit/reference.md" "$TARGET/.claude/skills/audit/reference.md" ".claude/skills/audit/reference.md"
copy_if_missing "$SCRIPT_DIR/.claude/audit-reports/TEMPLATE.md" "$TARGET/.claude/audit-reports/TEMPLATE.md" ".claude/audit-reports/TEMPLATE.md"

# === GitHub Actions ===
copy_if_missing "$SCRIPT_DIR/.github/workflows/documentation-audit.yml.template" "$TARGET/.github/workflows/documentation-audit.yml.template" ".github/workflows/documentation-audit.yml.template"
copy_if_missing "$SCRIPT_DIR/.github/scripts/audit-docs.py" "$TARGET/.github/scripts/audit-docs.py" ".github/scripts/audit-docs.py"
copy_if_missing "$SCRIPT_DIR/.github/audit-config.yml" "$TARGET/.github/audit-config.yml" ".github/audit-config.yml"
copy_if_missing "$SCRIPT_DIR/.github/ACTIONS.md" "$TARGET/.github/ACTIONS.md" ".github/ACTIONS.md"
copy_if_missing "$SCRIPT_DIR/.github/SETUP.md" "$TARGET/.github/SETUP.md" ".github/SETUP.md"

# === Docs ===
for f in permissions-guide git-setup gh-cli-setup superpowers-integration gastown-integration design-integration response-style-guidelines; do
    copy_if_missing "$SCRIPT_DIR/docs/$f.md" "$TARGET/docs/$f.md" "docs/$f.md"
done
for f in design-workflow-guide design-phase-reference adr-guide; do
    copy_if_missing "$SCRIPT_DIR/docs/design/$f.md" "$TARGET/docs/design/$f.md" "docs/design/$f.md"
done

echo ""
echo "=== Setup Complete ==="
echo ""
echo "Next steps:"
echo "  1. Edit CLAUDE.md — replace [BRACKETED] placeholders"
echo "  2. Edit .claude/settings.local.json — adjust permissions and hooks"
echo "  3. Enable GitHub Actions:"
echo "     mv .github/workflows/documentation-audit.yml.template .github/workflows/documentation-audit.yml"
echo "     Add ANTHROPIC_API_KEY to GitHub Secrets"
echo "  4. Optional: bd init (Beads issue tracking)"
echo "  5. Optional: gt install ~/gt --git (Gas Town multi-agent)"
echo "  6. Run: claude"
