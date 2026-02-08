# Claude Code Bootstrap (ccbootstrap)

A tiered setup template for [Claude Code](https://claude.ai/code) — from a minimal 2-file config to full multi-agent orchestration. Each tier is a **self-contained deployment folder** with everything you need.

## Choose Your Tier

| Tier | What You Get | Folder |
|------|-------------|--------|
| **Beginner** | Claude knows your project, safe permissions, builds/tests work | [`deployments/beginner/`](deployments/beginner/) |
| **Intermediate** | + modular docs, workflows, conventions, design methodology | [`deployments/intermediate/`](deployments/intermediate/) |
| **Power User** | + agent teams, custom subagents, team hooks, delegate mode | [`deployments/power-user/`](deployments/power-user/) |
| **Kitchen Sink** | + everything: GitHub Actions, audit system, Gas Town, Beads, all integrations | [`deployments/kitchen-sink/`](deployments/kitchen-sink/) |

Each tier is **fully self-contained** — pick one folder and you have everything needed for that level. No cross-tier dependencies.

## Quick Start

```bash
# 1. Clone this repo
git clone https://github.com/liteman/cc-bootstrap.git
cd cc-bootstrap

# 2. Pick your tier and run the setup script
cd deployments/beginner        # or intermediate, power-user, kitchen-sink
chmod +x setup.sh
./setup.sh /path/to/your-project

# 3. Start Claude Code in your project
cd /path/to/your-project
claude
```

Each `setup.sh` script copies the deployment's files into your target project without overwriting existing files. Run it multiple times safely.

---

## Tier Overview

### Beginner — Get Productive Fast

Two files. Five minutes. Claude Code understands your project and runs your tools without asking every time.

**What you get:**
- `CLAUDE.md` — Project context (tech stack, commands, structure, rules)
- `.claude/settings.local.json` — Safe permission defaults

**Best for:** First-time Claude Code users, small projects, trying things out.

[Go to Beginner deployment →](deployments/beginner/)

---

### Intermediate — Structured Development Workflows

Adds modular documentation, repeatable workflows, coding conventions, and a 6-phase design methodology for architectural decisions.

**What you get (in addition to Beginner):**
- `.claude/architecture.md` — System design overview
- `.claude/modules/` — On-demand component documentation
- `.claude/workflows/` — Feature development, bug fixes, refactoring guides
- `.claude/conventions/` — Code style, testing, git workflow standards
- `.claude/design/` — Structured design methodology (Exploration → Requirements → Options → Decision → Detail → Validation)
- Custom commands: `/load-module`, `/load-workflow`, `/verify-context`, `/audit`, `/start-design-session`

**Best for:** Teams wanting consistent development practices, projects with architectural complexity.

[Go to Intermediate deployment →](deployments/intermediate/)

---

### Power User — Agent Teams

Builds on Intermediate with Claude Code's native **agent teams** feature for multi-agent coordination. Spawn specialized teammates that work in parallel.

**What you get (in addition to Intermediate):**
- `.claude/agents/` — Custom subagent definitions (researcher, implementer, reviewer)
- `.claude/settings.json` — Enables agent teams via `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1`
- `.claude/workflows/agent-team-development.md` — Team-based development workflow
- `AGENTS.md` — Agent teams coordination guide
- Agent teams hooks — `TeammateIdle`, `TaskCompleted` quality gates
- Delegate mode — `Shift+Tab` restricts lead to coordination only
- `docs/agent-teams-guide.md` — Comprehensive agent teams reference

**Best for:** Teams wanting parallel agent workflows, large features, research + implementation patterns.

[Go to Power User deployment →](deployments/power-user/)

---

### Kitchen Sink — Everything Included

Everything from Power User plus CI/CD automation, documentation audit systems, and third-party integrations. High token cost, maximum capability.

**What you get (in addition to Power User):**
- `.github/` — GitHub Actions for automated documentation auditing
- `.claude/skills/audit/` — Comprehensive audit skill with scoring
- `.claude/audit-reports/` — Audit report templates
- Full hook suite — SessionStart, PreToolUse, PreCompact, UserPromptSubmit, Stop
- Integration guides — Superpowers, Gas Town, Beads, response style customization

**Best for:** Production teams, CI/CD environments, experimental multi-agent setups.

[Go to Kitchen Sink deployment →](deployments/kitchen-sink/)

---

## How It Works

Each deployment folder contains:

| File | Purpose |
|------|---------|
| `README.md` | Tier-specific setup guide with full instructions |
| `setup.sh` | Copies files to your target project (safe, non-destructive) |
| `CLAUDE.md.template` | Project context template (rename to `CLAUDE.md` and customize) |
| `.claude/settings.local.json` | Permission configuration (gitignored, personal) |
| `.claude/**` | Documentation, workflows, conventions (varies by tier) |

The `setup.sh` script uses a copy-if-missing pattern — it will never overwrite files that already exist in your project. This means you can:
- Start with Beginner, then run Intermediate's `setup.sh` later to add more structure
- Re-run `setup.sh` after updates without losing your customizations

---

## Custom Commands Reference

Commands defined in `CLAUDE.md` for on-demand context loading (Intermediate+):

| Command | Description |
|---------|-------------|
| `/verify-context` | Show what documentation Claude currently has loaded |
| `/load-module <name>` | Load a specific module doc from `.claude/modules/` |
| `/load-workflow <name>` | Load a workflow guide before starting a task |
| `/audit` | Run a documentation health audit |
| `/team-status` | Check agent team status, task list, mailbox (Power User+) |
| `/define-agent <name>` | Create a new custom subagent from template (Power User+) |
| `/start-design-session` | Begin structured design session with Opus model |
| `/load-design-phase <phase>` | Load specific design phase: exploration, requirements, options, decision, detail, validation |
| `/finalize-design` | Transition from design to implementation |

---

## Companion Plugins

### Superpowers

The [superpowers](https://github.com/obra/superpowers) plugin by Jesse Vincent adds disciplined development methodology on top of this template's project knowledge structure.

| ccbootstrap provides | Superpowers provides |
|----------------------|----------------------|
| Project knowledge organization | Development methodology |
| Documentation structure & context loading | Behavioral workflows (TDD, verification) |
| `/audit`, `/verify-context`, `/load-module` | `/brainstorm`, `/write-plan`, `/execute-plan` |

Install inside a Claude Code session:
```bash
/plugin marketplace add obra/superpowers-marketplace
/plugin install superpowers@superpowers-marketplace
```

### Gas Town (Optional)

[Gas Town](https://github.com/steveyegge/gastown) orchestrates multiple Claude Code agents across projects. See the [Kitchen Sink deployment](deployments/kitchen-sink/) for setup details.

### Beads (Optional)

[Beads](https://github.com/steveyegge/beads) provides lightweight, git-backed issue tracking. See the [Kitchen Sink deployment](deployments/kitchen-sink/) for setup details.

---

## Contributing

Contributions are welcome. Please open an issue or submit a pull request.

## License

MIT License — use this template for any project.
