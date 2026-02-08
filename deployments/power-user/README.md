# Claude Code Bootstrap — Power User

Full automation, CI/CD integration, audit systems, session hooks, and multi-agent orchestration. This is a self-contained deployment that includes everything from beginner and intermediate tiers.

## What You'll Set Up

```
your-project/
├── CLAUDE.md                        # Full-featured with all custom commands
├── AGENTS.md                        # Multi-agent coordination guide
├── .claude/
│   ├── settings.local.json          # Permissions + hook configurations
│   ├── settings.json                # Team-shared permissions (committed to git)
│   ├── architecture.md              # System design overview
│   ├── AUDIT_COMMAND.md             # /audit quick reference
│   ├── modules/                     # On-demand module documentation
│   ├── workflows/                   # Development + audit workflows
│   │   ├── feature-development.md
│   │   ├── bug-fixes.md
│   │   ├── refactoring.md
│   │   └── documentation-audit.md
│   ├── conventions/                 # Team coding standards
│   ├── design/                      # Design methodology
│   ├── skills/audit/                # Audit skill implementation
│   └── audit-reports/               # Audit report storage
├── .github/
│   ├── workflows/                   # CI/CD automation
│   │   └── documentation-audit.yml.template
│   ├── scripts/
│   │   └── audit-docs.py
│   ├── audit-config.yml
│   ├── ACTIONS.md
│   └── SETUP.md
└── docs/
    ├── design/                      # Design guides
    ├── permissions-guide.md
    ├── git-setup.md
    ├── gh-cli-setup.md
    ├── superpowers-integration.md
    ├── gastown-integration.md
    ├── design-integration.md
    └── response-style-guidelines.md
```

## Quick Start

```bash
./setup.sh /path/to/your-project
```

## What This Tier Adds (Beyond Intermediate)

### GitHub Actions: Automated Documentation Audit

CI/CD workflow that audits your `.claude/` documentation using the Claude API.

**Enable it:**
```bash
mv .github/workflows/documentation-audit.yml.template \
   .github/workflows/documentation-audit.yml
```

**Add your API key:** Settings → Secrets → `ANTHROPIC_API_KEY`

**What it does:**
- Monthly scheduled audits (1st of each month)
- PR checks when `.claude/` files change
- Creates GitHub issues for critical findings
- Comments on PRs with audit results

### Documentation Audit Skill

The `/audit` command performs comprehensive documentation health checks:

```
/audit          # Full 5-phase audit with remediation
/audit quick    # Fast scan for critical/high issues only
```

### Hook Configurations

Session hooks enforce project standards automatically:

| Hook | When It Fires | Use Case |
|------|---------------|----------|
| `SessionStart` | Session begins | Load context reminders |
| `PreToolUse` | Before any tool call | Guard dangerous operations |
| `PreCompact` | Before context compaction | Preserve critical state |
| `UserPromptSubmit` | User sends a message | Inject workflow context |
| `Stop` | Session ends | Verify cleanup |

### AGENTS.md

Guides any AI agent (not just Claude Code) working in the repo with project context, conventions, and coordination patterns.

### Beads: Git-Backed Issue Tracking (Optional)

```bash
go install github.com/steveyegge/beads/cmd/bd@latest
bd init
```

### Gas Town: Multi-Agent Orchestration (Optional)

```bash
brew install gastown
gt install ~/gt --git
```

## Setup Steps

1. Run `./setup.sh /path/to/your-project`
2. Edit `CLAUDE.md` — replace placeholders with your project details
3. Enable GitHub Actions (rename `.template` to `.yml`, add API key secret)
4. Configure hooks in `.claude/settings.local.json` for your team
5. Optional: Initialize Beads for issue tracking
6. Optional: Set up Gas Town for multi-agent orchestration

## All Custom Commands

| Command | Description |
|---------|-------------|
| `/verify-context` | Show loaded documentation |
| `/load-module <name>` | Load module from `.claude/modules/` |
| `/load-workflow <name>` | Load workflow guide |
| `/audit [quick\|full]` | Documentation health check |
| `/start-design-session` | Begin structured design |
| `/load-design-phase <phase>` | Load specific design phase |
| `/finalize-design` | Transition to implementation |

## Documentation Index

| Document | Description |
|----------|-------------|
| `docs/permissions-guide.md` | Permission patterns by platform |
| `docs/git-setup.md` | Git configuration guide |
| `docs/gh-cli-setup.md` | GitHub CLI setup |
| `docs/superpowers-integration.md` | Superpowers plugin guide |
| `docs/gastown-integration.md` | Multi-agent orchestration |
| `docs/design-integration.md` | Design + Superpowers integration |
| `docs/response-style-guidelines.md` | Personal response preferences |
| `.github/SETUP.md` | GitHub Actions setup guide |
