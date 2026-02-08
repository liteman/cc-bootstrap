# Gastown Integration Guide

This guide explains how to use [Gastown](https://github.com/steveyegge/gastown) alongside this Claude Code bootstrap template for multi-agent orchestration.

## Overview

**Gastown** is a multi-agent orchestration system by Steve Yegge that manages coordinated workflows across multiple Claude Code agents. It complements this template:

| This Template | Gastown |
|---------------|---------|
| Provides per-project documentation & context | Orchestrates multiple agents across projects |
| Single-agent workflow structure | Multi-agent coordination with persistent state |
| `/audit`, `/verify-context`, `/load-module` | `gt mayor attach`, `gt sling`, `gt convoy` |
| Project-level conventions & modules | Workspace-level work tracking & agent management |

Together they create an environment where individual projects are well-documented (cc-bootstrap) and multiple agents can work across those projects in parallel (Gastown).

## Prerequisites

- **Go 1.23+** — Gastown runtime
- **Git 2.25+** — Required for worktree support
- **beads (bd) 0.44.0+** — Issue tracking system
- **sqlite3** — State storage
- **tmux 3.0+** — Recommended for session management
- **Claude Code CLI** — Primary agent runtime

## Installation

### Install Gastown

Choose one method:

```bash
# Homebrew (recommended)
brew install gastown

# npm
npm install -g @gastown/gt

# Go
go install github.com/steveyegge/gastown/cmd/gt@latest
```

### Initial Workspace Setup

```bash
# Create a Gastown workspace (the "Town")
gt install ~/gt --git

# Navigate to your workspace
cd ~/gt

# Add a project as a "Rig"
gt rig add myproject https://github.com/you/repo.git

# Create your crew identity
gt crew add yourname --rig myproject

# Start the Mayor (primary coordinator agent)
gt mayor attach
```

### Verify Installation

```bash
which gt
gt --version
gt rig list
```

## Core Concepts

| Term | Description |
|------|-------------|
| **Town** | Root workspace directory (e.g., `~/gt/`) containing all projects |
| **Mayor** | Primary AI coordinator instance with workspace-wide context |
| **Rig** | Project container wrapping a git repository |
| **Crew Member** | Your personal workspace within a rig |
| **Polecat** | Ephemeral worker agent spawned for a specific task |
| **Hook** | Git worktree-based persistent storage surviving agent crashes |
| **Convoy** | Tracked bundle of related work items |
| **Bead** | Git-backed issue/work item (ID format: `gt-abc12`) |

## How It Complements cc-bootstrap

Gastown and cc-bootstrap operate at different levels:

```
Gastown (workspace level)
├── Orchestrates agents across projects
├── Tracks work state in convoys & beads
├── Manages agent lifecycle (spawn, handoff, recover)
└── Persists context via git-backed hooks

cc-bootstrap (project level)
├── Structures project documentation
├── Provides module/workflow/convention guides
├── Defines coding standards & testing practices
└── Offers context-loading commands (/load-module, /verify-context)
```

When a Gastown agent (Polecat) is assigned to work on a cc-bootstrap-structured project, it benefits from the project's `.claude/` documentation — modules, workflows, and conventions are available to every agent that enters the repository.

## Typical Workflow

### Setting Up a cc-bootstrap Project as a Rig

```bash
# Add your cc-bootstrap project to Gastown
gt rig add my-app https://github.com/you/my-app.git

# The rig now contains your project with its .claude/ documentation
# Any agent working in this rig has access to cc-bootstrap context
```

### Mayor-Driven Development

```
You: "Build the OAuth integration for my-app"

Mayor: [Creates a convoy with beads for each subtask]
       gt convoy create oauth-integration gt-abc12 gt-def34 gt-ghi56

       [Spawns Polecats to work in parallel]
       gt sling gt-abc12 my-app   # Auth provider setup
       gt sling gt-def34 my-app   # Token management
       gt sling gt-ghi56 my-app   # Route protection

       [Each Polecat enters the rig and reads .claude/ docs]
       [cc-bootstrap's /load-module auth provides project context]
       [Polecats complete work and report back via mail system]

You: gt convoy show oauth-integration
     # See progress across all subtasks
```

### Manual Convoy Management

```bash
# Create a convoy for related work
gt convoy create refactor-api gt-abc12 gt-def34

# Assign work to specific rigs
gt sling gt-abc12 my-app
gt sling gt-def34 my-app

# Check progress
gt convoy list
gt convoy show refactor-api

# Check agent status
gt agents
```

## Key Commands Reference

### Workspace Management
| Command | Description |
|---------|-------------|
| `gt install <path> --git` | Initialize a new Gastown workspace |
| `gt rig add <name> <repo>` | Add a project repository |
| `gt rig list` | List all projects |
| `gt crew add <name> --rig <rig>` | Create crew identity |

### Agent Management
| Command | Description |
|---------|-------------|
| `gt mayor attach` | Start the Mayor coordinator |
| `gt agents` | List active agents |
| `gt sling <bead-id> <rig>` | Assign work to an agent |
| `gt prime` | Restore session context after restart |

### Work Tracking
| Command | Description |
|---------|-------------|
| `gt convoy create <name> [beads]` | Create a work bundle |
| `gt convoy list` | List all convoys |
| `gt convoy show [id]` | Show convoy details |

### Configuration
| Command | Description |
|---------|-------------|
| `gt config show` | View current configuration |
| `gt config agent set <name> <cmd>` | Configure a custom agent runtime |

## When to Use Gastown

### Good Fit
- **Large features** spanning multiple files or subsystems
- **Parallel workstreams** where multiple agents can work independently
- **Complex refactors** requiring coordinated changes across a codebase
- **Multi-project work** spanning several repositories
- **Teams** wanting visibility into distributed agent work

### Single-Agent cc-bootstrap Is Sufficient
- **Small features** or bug fixes in a single area
- **Documentation updates** or configuration changes
- **Exploratory work** where you need tight feedback loops
- **Learning a new codebase** (one agent with loaded context is clearer)

## Security Considerations

### Git-Backed State

Gastown stores all work state in git worktrees. This means:
- Work state is version-controlled and recoverable
- Agent context persists across crashes via hooks
- All state changes are auditable through git history

### Agent Spawning

Commands like `gt mayor attach` and `gt sling` spawn new Claude Code sessions. Be aware of:
- **API usage costs** — Each agent consumes API credits independently
- **Resource usage** — Multiple agents use memory and compute concurrently
- **Review agent output** — Spawned agents work autonomously; review their commits before merging

### Tmux Sessions

Gastown uses tmux for session management. Ensure:
- Tmux sessions are properly secured on shared systems
- Sessions are cleaned up after work completes (`gt agents` to verify)

## Troubleshooting

### `gt` Command Not Found

Verify installation:
```bash
which gt
go version    # Ensure Go 1.23+
```

If installed via Go, ensure `$GOPATH/bin` is in your `$PATH`:
```bash
export PATH="$PATH:$(go env GOPATH)/bin"
```

### Git Worktree Errors

Gastown requires Git 2.25+ for worktree support:
```bash
git --version
```

If worktree operations fail, check for stale worktrees:
```bash
git worktree list
git worktree prune
```

### Tmux Not Available

Gastown works without tmux but with reduced functionality. Install it:
```bash
# macOS
brew install tmux

# Ubuntu/Debian
sudo apt install tmux
```

### Beads Not Found

Install the beads CLI:
```bash
# Check current version (need 0.44.0+)
bd --version

# Install or update
go install github.com/steveyegge/beads/cmd/bd@latest
```

### Agent Not Picking Up Project Context

If a spawned agent doesn't load cc-bootstrap documentation:
1. Verify the rig points to a repo with `.claude/` directory
2. Check that `CLAUDE.md` exists at the repo root
3. Use `gt prime` to refresh agent context after setup changes

## Resources

- **Repository**: https://github.com/steveyegge/gastown
- **Documentation**: https://github.com/steveyegge/gastown/tree/main/docs
- **Glossary**: https://github.com/steveyegge/gastown/blob/main/docs/glossary.md
- **Overview**: https://github.com/steveyegge/gastown/blob/main/docs/overview.md
- **Issues**: https://github.com/steveyegge/gastown/issues

## License

Gastown is MIT licensed, compatible with this template's MIT license. Both can be freely used, modified, and distributed together.
