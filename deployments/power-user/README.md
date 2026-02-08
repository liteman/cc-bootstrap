# Claude Code Bootstrap — Power User (Agent Teams)

Builds on intermediate with Claude Code's native **agent teams** feature for multi-agent coordination. Spawn specialized teammates that work in parallel — researchers explore, implementers build, reviewers validate — all coordinated through a shared task list and mailbox.

> **Agent teams** is a research preview feature released with Opus 4.6 (February 2026).

## What You'll Set Up

```
your-project/
├── CLAUDE.md                        # Full-featured with team commands
├── AGENTS.md                        # Agent teams coordination guide
├── .claude/
│   ├── settings.local.json          # Permissions + agent teams hooks
│   ├── settings.json                # Enables agent teams for the whole team
│   ├── architecture.md              # System design overview
│   ├── agents/                      # Custom subagent definitions
│   │   ├── _template.md             # Template for new agents
│   │   ├── researcher.md            # Codebase exploration agent
│   │   ├── implementer.md           # Code writing agent
│   │   └── reviewer.md              # Code review agent
│   ├── modules/                     # On-demand module documentation
│   ├── workflows/                   # Development workflows
│   │   ├── feature-development.md
│   │   ├── bug-fixes.md
│   │   ├── refactoring.md
│   │   └── agent-team-development.md  # Team-based workflow
│   ├── conventions/                 # Team coding standards
│   └── design/                      # Design methodology
├── docs/
│   ├── agent-teams-guide.md         # Comprehensive agent teams reference
│   ├── design/                      # Design guides
│   ├── permissions-guide.md
│   ├── git-setup.md
│   └── gh-cli-setup.md
```

## Quick Start

```bash
chmod +x setup.sh
./setup.sh /path/to/your-project
```

## What This Tier Adds (Beyond Intermediate)

### Agent Teams Configuration

Agent teams are enabled automatically via `.claude/settings.json`:

```json
{
  "env": {
    "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS": "1"
  },
  "teammateMode": "auto"
}
```

This means every team member who clones the project gets agent teams enabled.

### Custom Subagent Definitions

Three example agents in `.claude/agents/`:

| Agent | Model | Role | Tools |
|-------|-------|------|-------|
| `researcher.md` | Opus | Codebase exploration, documentation reading | Read-only |
| `implementer.md` | Sonnet | Code writing, test authoring | Full access |
| `reviewer.md` | Sonnet | Code review, convention checking | Read-only |

Create your own by copying `_template.md`. Subagents use YAML frontmatter to define name, model, description, and available tools.

### Agent Team Development Workflow

A new workflow (`.claude/workflows/agent-team-development.md`) guides team-based development through five phases:

1. **Planning** — Break work into parallel tasks (team lead, solo)
2. **Research** — Researcher explores codebase and reports findings
3. **Implementation** — Implementers work on independent tasks in parallel
4. **Review** — Reviewer validates changes against conventions
5. **Integration** — Team lead merges and runs final tests

### New Hooks

| Hook | Fires When | Purpose |
|------|-----------|---------|
| `TeammateIdle` | Teammate finishes work | Review output before reassigning |
| `TaskCompleted` | Task marked complete | Quality gate — exit code 2 blocks completion |

These are pre-configured in `.claude/settings.local.json` alongside `SessionStart`, `PreToolUse`, and `Stop`.

### Delegate Mode

Press `Shift+Tab` to toggle the team lead into coordination-only mode. The lead can only spawn teammates, send messages, and manage the task list — no direct implementation.

### AGENTS.md

Orients any AI agent entering the repo with agent teams context: how teams are configured, available subagent roles, communication patterns, and quality gates.

## Setup Steps

1. Run `./setup.sh /path/to/your-project`
2. Edit `CLAUDE.md` — replace `[BRACKETED]` placeholders with your project details
3. Customize subagent definitions in `.claude/agents/` for your team's roles
4. Review hooks in `.claude/settings.local.json`
5. Start Claude Code: `claude`
6. Try delegate mode: `Shift+Tab`

## All Custom Commands

| Command | Description |
|---------|-------------|
| `/verify-context` | Show loaded documentation |
| `/load-module <name>` | Load module from `.claude/modules/` |
| `/load-workflow <name>` | Load workflow guide |
| `/audit [quick\|full]` | Basic documentation review |
| `/start-design-session` | Begin structured design |
| `/load-design-phase <phase>` | Load specific design phase |
| `/finalize-design` | Transition to implementation |
| `/team-status` | Check agent team status, task list, and mailbox |
| `/define-agent <name>` | Create a new custom subagent from template |

## Agent Teams Quick Reference

| Action | How |
|--------|-----|
| Enable agent teams | Set `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` (pre-configured) |
| Toggle delegate mode | `Shift+Tab` |
| Navigate teammates (in-process) | `Shift+Up` / `Shift+Down` |
| Change display mode | Set `teammateMode` in `.claude/settings.json` |
| Create custom agent | Copy `.claude/agents/_template.md` |
| Load team workflow | `/load-workflow agent-team-development` |

## Display Modes

| Mode | Best For | Requirements |
|------|----------|--------------|
| `in-process` | Quick tasks, 1-2 teammates | Any terminal |
| `tmux` | Multiple teammates, visibility | tmux or iTerm2 |
| `auto` (default) | Let Claude Code decide | None |

## Next Level

Want CI/CD automation, documentation audit systems, Gas Town, or Beads issue tracking? See the [Kitchen Sink deployment](../kitchen-sink/) for the full-featured, experimental option.

## Documentation Index

| Document | Description |
|----------|-------------|
| `docs/agent-teams-guide.md` | Comprehensive agent teams reference |
| `docs/permissions-guide.md` | Permission patterns by platform |
| `docs/git-setup.md` | Git configuration guide |
| `docs/gh-cli-setup.md` | GitHub CLI setup |
| `.claude/workflows/agent-team-development.md` | Team-based development workflow |
| `.claude/agents/_template.md` | Custom subagent template |
