#!/bin/bash
# SessionStart hook: Check for inbox.md and report pending tasks
# Add to .claude/settings.json under hooks.SessionStart

INBOX_FILE="${PWD}/inbox.md"

if [ ! -f "$INBOX_FILE" ]; then
    # No inbox file — output minimal JSON
    cat <<'ENDJSON'
{
  "system": "SessionStart inbox check | Inbox: no inbox.md found"
}
ENDJSON
    exit 0
fi

# Count pending (unchecked) tasks
PENDING=$(grep -c '^\s*- \[ \]' "$INBOX_FILE" 2>/dev/null || echo "0")
COMPLETED=$(grep -c '^\s*- \[x\]' "$INBOX_FILE" 2>/dev/null || echo "0")

if [ "$PENDING" -eq 0 ]; then
    cat <<ENDJSON
{
  "system": "SessionStart inbox check | Inbox: ${COMPLETED} completed, 0 pending"
}
ENDJSON
else
    cat <<ENDJSON
{
  "system": "SessionStart inbox check | Inbox: ${PENDING} pending tasks — read inbox.md and present status to user"
}
ENDJSON
fi
