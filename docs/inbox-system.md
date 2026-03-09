# Cross-Workspace Inbox System

A lightweight protocol for sending actionable messages between Claude Code workspaces. When work in one project produces something actionable for another, drop an `inbox.md` entry in the target project so it gets picked up next session.

## How It Works

1. A SessionStart hook checks for `inbox.md` in the project root
2. If pending tasks exist (unchecked `- [ ]` items), Claude summarizes them at session start
3. The user processes the inbox items before proceeding with new work

## Setup

### 1. Add the SessionStart hook

Add to your project's `.claude/settings.json` (or user-level `~/.claude/settings.json` for all projects):

```json
{
  "hooks": {
    "SessionStart": [
      {
        "matcher": "startup|resume",
        "hooks": [
          {
            "type": "command",
            "command": ".claude/hooks/check-inbox.sh"
          }
        ]
      }
    ]
  }
}
```

### 2. Add the hook script

Copy `.claude/hooks/check-inbox.sh` to your project (available in power-user and kitchen-sink tiers).

### 3. Add inbox instructions to CLAUDE.md

Add this section to your project's CLAUDE.md:

```markdown
## Session Start — Inbox Check

At the start of each session, check for `inbox.md` in the project root. If it exists and has pending tasks (unchecked `- [ ]` items), briefly summarize them before proceeding.

## Cross-Workspace Inbox Messages

When a conversation references another repo and produces something actionable for that workspace, suggest adding an `inbox.md` entry there.

**When to suggest it:**
- A design decision or plan is finalized that affects another project
- Implementation steps are identified for a different repo
- A bug, dependency change, or breaking change impacts another workspace

**When NOT to suggest it:**
- The reference is purely informational
- Already working in the target repo
- An inbox message was already suggested this session

**Inbox entry format:**
\```markdown
- [ ] **[Source: {current-project}]** Brief description of what's actionable
  - Context: Why this matters to this repo
  - See: {path-or-link-to-relevant-artifact}
  - Added: {YYYY-MM-DD}
\```
```

## Benefits

- **No tooling required** — pure markdown, works with any project
- **Async communication** — write once, process next session
- **Cross-project coordination** — design decisions flow to implementation repos
- **Auditable** — inbox.md is a plain file you can review, version, or ignore

## Best Practices

- Keep entries concise — the inbox is a pointer, not a full briefing
- Link to the source artifact for details
- Process inbox items at session start, then clear completed items
- Use the `[Source: project-name]` prefix so you know where the message came from
