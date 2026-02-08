# Claude Code Bootstrap (ccbootstrap)

A tiered setup template for [Claude Code](https://claude.ai/code) — from a minimal 2-file config to full multi-agent orchestration. Each tier is a **self-contained deployment folder** with everything you need.

## Choose Your Tier

| Tier | What You Get | Folder |
|------|-------------|--------|
| **Beginner** | Claude knows your project, safe permissions, builds/tests work | [`deployments/beginner/`](deployments/beginner/) |
| **Intermediate** | + modular docs, workflows, conventions, design methodology | [`deployments/intermediate/`](deployments/intermediate/) |
| **Power User** | + GitHub Actions, audit system, hooks, multi-agent support | [`deployments/power-user/`](deployments/power-user/) |

Each tier is **fully self-contained** — pick one folder and you have everything needed for that level. No cross-tier dependencies.

## Quick Start

```bash
# 1. Clone this repo
git clone https://github.com/liteman/cc-bootstrap.git
cd cc-bootstrap

# 2. Pick your tier and run the setup script
cd deployments/beginner        # or intermediate, or power-user
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

### Power User — Full Automation & Multi-Agent

Everything from Intermediate plus CI/CD automation, documentation audit systems, session hooks, and multi-agent orchestration support.

**What you get (in addition to Intermediate):**
- `.github/` — GitHub Actions for automated documentation auditing
- `.claude/skills/audit/` — Comprehensive audit skill with scoring
- `.claude/audit-reports/` — Audit report templates
- `AGENTS.md` — Multi-agent coordination guide
- Session hooks — Automated guardrails at session start, tool use, compaction, and stop
- Enhanced permissions — Full deny list, hook configurations
- Integration guides — Superpowers, Gas Town, Beads issue tracking

**Best for:** Production teams, CI/CD environments, multi-agent workflows.

[Go to Power User deployment →](deployments/power-user/)

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
| `/audit` | Run a comprehensive documentation health audit |
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

[Gas Town](https://github.com/steveyegge/gastown) orchestrates multiple Claude Code agents across projects. See the Power User deployment for setup details.

### Beads (Optional)

[Beads](https://github.com/steveyegge/beads) provides lightweight, git-backed issue tracking. See the Power User deployment for setup details.

---

## Contributing

Contributions are welcome. Please open an issue or submit a pull request.

## License

MIT License — use this template for any project.
