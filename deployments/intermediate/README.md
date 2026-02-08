# Claude Code Bootstrap — Intermediate

Structured development workflows, conventions, and on-demand documentation for Claude Code. This is a self-contained deployment that includes everything you need.

## What You'll Set Up

```
your-project/
├── CLAUDE.md                        # Enhanced with custom commands
├── .claude/
│   ├── settings.local.json          # Safe permission defaults
│   ├── architecture.md              # System design overview
│   ├── modules/                     # On-demand module documentation
│   │   └── _template.md             # Template for new modules
│   ├── workflows/                   # Step-by-step development guides
│   │   ├── feature-development.md
│   │   ├── bug-fixes.md
│   │   └── refactoring.md
│   ├── conventions/                 # Team coding standards
│   │   ├── code-style.md
│   │   ├── testing.md
│   │   └── git-workflow.md
│   └── design/                      # Design methodology
│       ├── workflows/               # 6-phase structured design process
│       ├── conventions/             # Design thinking guidance
│       └── templates/               # Design documents, ADRs
└── docs/
    ├── design/                      # Design guides
    ├── permissions-guide.md
    ├── git-setup.md
    └── gh-cli-setup.md
```

## Quick Start

### Option A: Use the setup script

```bash
./setup.sh /path/to/your-project
```

### Option B: Manual setup

Copy the directory contents into your project, then customize the `[BRACKETED]` placeholders.

## What Each Piece Does

**`architecture.md`** — Gives Claude a map of your system so it doesn't re-discover your architecture every session.

**`modules/`** — On-demand deep dives. Load only what's relevant: `/load-module auth` before auth work.

**`workflows/`** — Repeatable processes Claude follows step-by-step:

| Workflow | What it does |
|----------|-------------|
| `feature-development.md` | Plan, implement with TDD, test, document |
| `bug-fixes.md` | Reproduce, isolate root cause, fix, add regression tests |
| `refactoring.md` | Verify coverage, make incremental changes, keep tests green |

**`conventions/`** — Codified standards that prevent style drift:

| Convention | Prevents |
|------------|----------|
| `code-style.md` | Inconsistent naming, file organization, error handling |
| `testing.md` | Untested code, flaky tests, missing coverage |
| `git-workflow.md` | Messy commits, unclear PRs, broken branches |

**`design/`** — Structured design methodology for architectural decisions. Use when facing significant decisions with high reversal cost. 6 phases: Exploration → Requirements → Options → Decision → Detail → Validation.

## Custom Commands

Add these to your `CLAUDE.md` (included in the template):

| Command | Description |
|---------|-------------|
| `/verify-context` | Show what documentation Claude has loaded |
| `/load-module <name>` | Load module doc from `.claude/modules/` |
| `/load-workflow <name>` | Load workflow guide before starting a task |
| `/start-design-session` | Begin structured design with Opus model |
| `/load-design-phase <phase>` | Load specific design phase |
| `/finalize-design` | Transition from design to implementation |

## Setup Steps

1. Run `./setup.sh /path/to/your-project` (or copy files manually)
2. Edit `CLAUDE.md` — replace placeholders with your project details
3. Create `architecture.md` — ask Claude to analyze your codebase
4. Create module docs — `cp .claude/modules/_template.md .claude/modules/<component>.md`
5. Customize workflows and conventions for your team
6. Optional: Install [Superpowers](https://github.com/obra/superpowers) plugin

## Companion Plugin: Superpowers

[Superpowers](https://github.com/obra/superpowers) adds disciplined development methodology:

| This deployment provides | Superpowers provides |
|--------------------------|---------------------|
| Project knowledge (what) | Development methodology (how) |
| `/load-module`, `/load-workflow` | `/brainstorm`, `/write-plan`, `/execute-plan` |

```bash
/plugin marketplace add obra/superpowers-marketplace
/plugin install superpowers@superpowers-marketplace
```

## Next Level

- **Agent Teams**: For Claude Code's native multi-agent feature (custom subagents, team coordination, delegate mode), see the [Power User deployment](../power-user/).
- **Kitchen Sink**: For CI/CD automation, audit systems, Gas Town, Beads, and all integrations, see the [Kitchen Sink deployment](../kitchen-sink/).
