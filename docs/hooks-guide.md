# Claude Code Hooks Guide

Hooks are shell commands that run in response to Claude Code events. They enable automation like inbox checking, quality gates, and notifications.

## Available Hook Events

| Event | When It Fires | Common Uses |
|-------|--------------|-------------|
| `SessionStart` | When a session begins or resumes | Inbox check, context loading, environment validation |
| `TeammateIdle` | When an agent team member finishes | Output validation, task reassignment |
| `TaskCompleted` | When a task is marked complete | Quality gate (exit code 2 blocks completion) |

## Configuration

Add hooks to `.claude/settings.json` (project-level) or `~/.claude/settings.json` (user-level):

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

### Hook Configuration Fields

| Field | Description |
|-------|-------------|
| `matcher` | Regex pattern to match against event context (e.g., `"startup\|resume"`) |
| `hooks[].type` | Hook type — currently `"command"` for shell commands |
| `hooks[].command` | Shell command to execute |

## Included Hooks

### check-inbox.sh

Checks for `inbox.md` in the current working directory and reports pending tasks at session start.

**What it does:**
- Looks for `inbox.md` in the project root
- Counts unchecked `- [ ]` items
- Outputs a structured JSON message for Claude to process
- Reports "no inbox" if file doesn't exist, or task count if it does

**Setup:** Copy `.claude/hooks/check-inbox.sh` to your project and add the SessionStart hook configuration above.

## Writing Custom Hooks

Hooks are regular shell scripts. They receive event context and should:
- Exit 0 for success
- Exit non-zero to signal a problem
- Output JSON for structured data that Claude can process
- Be fast — hooks run synchronously before the session continues

### Example: Environment Check Hook

```bash
#!/bin/bash
# Check that required tools are available
missing=()
for cmd in python uv ruff pytest; do
    if ! command -v "$cmd" &>/dev/null; then
        missing+=("$cmd")
    fi
done

if [ ${#missing[@]} -gt 0 ]; then
    echo "Missing required tools: ${missing[*]}"
    exit 1
fi
```

## Best Practices

- Keep hooks fast — they block session start
- Use exit codes meaningfully
- Output structured data when possible
- Test hooks independently before adding to settings
- Use project-level hooks for project-specific checks, user-level for global ones
