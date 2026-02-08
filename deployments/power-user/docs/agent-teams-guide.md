# Agent Teams Guide

Comprehensive reference for Claude Code's native agent teams feature. Agent teams let you coordinate multiple Claude Code instances working together on a shared codebase.

> **Status**: Research preview (released February 2026 with Opus 4.6)

## Overview

Agent teams introduce peer-to-peer multi-agent coordination directly in Claude Code. Unlike external orchestration tools, agent teams are built in — enable one environment variable and describe your team in natural language.

### Core Architecture

| Component | Description |
|-----------|-------------|
| **Team Lead** | The main Claude Code session that creates the team, spawns teammates, and coordinates work |
| **Teammates** | Independent Claude Code instances, each with its own context window |
| **Shared Task List** | Work queue with dependency tracking and status updates |
| **Mailbox** | Messaging system for inter-agent communication (point-to-point or broadcast) |

## Enabling Agent Teams

### Via settings.json (recommended — enables for the whole team)

```json
{
  "env": {
    "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS": "1"
  }
}
```

This is already configured in this deployment's `.claude/settings.json`.

### Via shell environment

```bash
export CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1
claude
```

## Display Modes

Configure how teammates appear in your terminal via `teammateMode` in settings:

| Mode | Behavior | Requirements |
|------|----------|--------------|
| `in-process` | All teammates in the same terminal, navigate with `Shift+Up/Down` | Any terminal |
| `tmux` | Each teammate gets its own pane | tmux or iTerm2 (not VS Code terminal) |
| `auto` (default) | Uses split panes if in tmux, otherwise in-process | None |

Set in `.claude/settings.json`:
```json
{
  "teammateMode": "auto"
}
```

Or via CLI flag: `claude --teammate-mode tmux`

## Delegate Mode

Press `Shift+Tab` to toggle the team lead into **delegate mode**. In this mode, the lead can only:
- Spawn and shut down teammates
- Send and receive mailbox messages
- Manage the shared task list

This prevents the lead from implementing things itself, keeping it focused on coordination.

## Creating a Team

Describe the team structure in natural language:

```
Create an agent team for this feature. I need:
- A researcher to explore the auth module and map dependencies
- Two implementers: one for the API endpoints, one for the frontend
- A reviewer to check changes against our conventions
```

Claude Code spawns each teammate and assigns them their roles. You confirm before it proceeds.

## Custom Subagents

Define specialized agent roles in `.claude/agents/<name>.md` using YAML frontmatter:

```markdown
---
name: researcher
description: Explores codebase and gathers context
model: opus
tools:
  - Read
  - Glob
  - Grep
  - Bash
---

# Researcher

## Role
[Agent's responsibilities and constraints]
```

### Frontmatter Fields

| Field | Required | Description |
|-------|----------|-------------|
| `name` | Yes | Agent identifier |
| `description` | Yes | Brief role description |
| `model` | No | Model to use (opus, sonnet, haiku). Defaults to session model |
| `tools` | No | Tools this agent can use. Defaults to all available |

### Included Example Agents

This deployment includes three example subagent definitions:

| Agent | Model | Tools | Purpose |
|-------|-------|-------|---------|
| `researcher.md` | opus | Read-only (Read, Glob, Grep, Bash) | Codebase exploration, dependency mapping |
| `implementer.md` | sonnet | Full (Read, Glob, Grep, Bash, Edit, Write) | Code writing, test authoring |
| `reviewer.md` | sonnet | Read-only (Read, Glob, Grep, Bash) | Code review, convention checking |

Create your own: copy `.claude/agents/_template.md` and customize.

## Hooks

Agent teams introduce two new hooks for quality gates:

### TeammateIdle

Fires when a teammate finishes work and is about to go idle.

```json
{
  "TeammateIdle": [
    {
      "matcher": "",
      "hooks": [
        {
          "type": "command",
          "command": "echo 'Teammate idle — review output before assigning next task'"
        }
      ]
    }
  ]
}
```

**Exit code 2**: Sends the hook's stdout as feedback to the teammate, keeping it working instead of going idle.

### TaskCompleted

Fires when a task is being marked complete.

```json
{
  "TaskCompleted": [
    {
      "matcher": "",
      "hooks": [
        {
          "type": "command",
          "command": "echo 'Task marked complete — verify tests pass and conventions followed'"
        }
      ]
    }
  ]
}
```

**Exit code 2**: Prevents the task from being marked complete and sends feedback. Use this to enforce quality gates — for example, run the test suite and reject completion if tests fail.

## Shared Task List

The team lead creates and manages a shared task list. All teammates can see task status and claim available work.

### Task States

| State | Meaning |
|-------|---------|
| `pending` | Not yet started, available to claim |
| `in_progress` | Claimed by a teammate |
| `completed` | Finished (subject to TaskCompleted hook) |

### Task Dependencies

Tasks can declare dependencies on other tasks. A dependent task stays pending until its dependencies are completed.

### Best Practices

- Write self-contained task descriptions
- Include relevant file paths in each task
- Specify acceptance criteria
- Order by dependency (independent tasks first)

## Mailbox Messaging

Teammates communicate via an inbox-based messaging system:

- **Point-to-point**: Send a message to a specific teammate
- **Broadcast**: Send a message to all teammates
- **Idle notifications**: When a teammate stops, it automatically notifies the lead

## Permissions

- Teammates inherit the lead's permission settings
- If the lead uses `--dangerously-skip-permissions`, all teammates do too
- Per-teammate permissions can be changed after spawning but not at spawn time

## Context Loading

Each teammate loads the same project context as a regular session:
- `CLAUDE.md` (project root)
- MCP servers
- Skills and plugins
- The spawn prompt from the lead

The lead's conversation history does **not** carry over. This makes `CLAUDE.md` and `AGENTS.md` critical — they are the primary shared configuration that every teammate reads.

## File Locations

| Path | Content |
|------|---------|
| `~/.claude/teams/{team-name}/config.json` | Team configuration |
| `~/.claude/tasks/{team-name}/` | Shared task list |

## Comparison with Other Multi-Agent Approaches

| Aspect | Agent Teams | Gas Town | Task Tool Subagents |
|--------|-------------|----------|---------------------|
| **Built-in** | Yes (first-party) | No (third-party) | Yes (first-party) |
| **Communication** | Peer-to-peer mailbox | External state (Beads) | Results return to caller only |
| **Coordination** | Shared task list | Mayor orchestrator | Main agent manages all |
| **Setup** | One env var | Install + configure | None needed |
| **Best for** | Collaborative parallel work | Large-scale orchestration | Focused subtasks |
| **Token cost** | High (each teammate is a full session) | Very high (external overhead) | Lower (results summarized) |

## Known Limitations

- No session resumption with in-process teammates (`/resume` and `/rewind` don't restore them)
- Task status can lag; teammates sometimes fail to mark tasks completed
- Shutdown can be slow (teammates finish their current tool call first)
- One team per session; no nested teams
- The lead is fixed for the team's lifetime
- Split panes require tmux or iTerm2 (not VS Code integrated terminal)

## Troubleshooting

### Teammate not reading CLAUDE.md
Verify `CLAUDE.md` exists at the project root and is not empty.

### YAML frontmatter errors in custom agents
Check for proper `---` delimiters and valid YAML syntax. Common issues: missing quotes around strings with colons, incorrect indentation.

### Teammates working on the same files
Assign teammates to separate modules/components via the task list. Include explicit file ownership in task descriptions.

### Team lead doing implementation instead of coordinating
Toggle delegate mode with `Shift+Tab` to restrict the lead to coordination-only tools.

## Resources

- [Official Docs: Orchestrate teams of Claude Code sessions](https://code.claude.com/docs/en/agent-teams)
- [Custom subagents documentation](https://code.claude.com/docs/en/sub-agents)
