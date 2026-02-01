# Claude Code Bootstrap Template

A comprehensive template for projects using [Claude Code](https://claude.ai/code), pre-configured with documentation structures, workflows, and best practices for efficient AI-assisted development.

## Purpose

This template provides a complete foundation for working with Claude Code, whether you're starting a new project or adding Claude Code to an existing codebase. It includes:

- **Structured documentation** for guiding Claude Code through your codebase
- **Workflow guides** for common development tasks (features, bugs, refactoring)
- **Convention templates** for code style, testing, and git practices
- **GitHub Actions** for automated documentation audits
- **Custom commands** for context management and documentation maintenance

## Quick Start

### For New Projects

```bash
# Clone or use this template
git clone https://github.com/liteman/cc-bootstrap.git my-project
cd my-project
rm -rf .git && git init

# Start Claude Code
claude

# Initialize your project with a prompt like:
```

**Suggested prompt for new projects:**
```
Analyze this Claude Code bootstrap template and help me initialize a new
[TypeScript/Python/Go/etc.] project. Please:
1. Set up the project structure and package management
2. Configure linting and formatting tools
3. Set up a testing framework with TDD workflow
4. Update CLAUDE.md with the actual project details, removing template placeholders
5. Create module documentation in .claude/modules/ for the initial components
6. Set up git hooks for code quality
```

### For Existing Projects

```bash
# Clone just the documentation structure
git clone https://github.com/liteman/cc-bootstrap.git temp-bootstrap
cp -r temp-bootstrap/.claude your-project/
cp -r temp-bootstrap/.github your-project/
cp temp-bootstrap/CLAUDE.md your-project/
rm -rf temp-bootstrap

cd your-project
claude
```

**Suggested prompt for existing projects:**
```
I've added the Claude Code bootstrap template to this existing project. Please:
1. Analyze the current codebase structure and architecture
2. Update CLAUDE.md with accurate project information:
   - Tech stack and dependencies
   - Build, test, and lint commands
   - Architecture overview and key components
3. Create module documentation in .claude/modules/ for the main components
4. Update .claude/architecture.md with the actual system design
5. Identify any conventions and document them in .claude/conventions/
```

---

## What's Included

### Project Structure

```
.
├── CLAUDE.md                    # Primary guidance file for Claude Code
├── .claude/                     # Detailed documentation structure
│   ├── architecture.md          # System architecture template
│   ├── AUDIT_COMMAND.md         # Quick reference for /audit command
│   ├── modules/                 # Module-specific documentation
│   │   └── _template.md         # Template for new modules
│   ├── workflows/               # Development workflow guides
│   │   ├── feature-development.md
│   │   ├── bug-fixes.md
│   │   ├── refactoring.md
│   │   └── documentation-audit.md
│   ├── conventions/             # Coding standards and practices
│   │   ├── code-style.md
│   │   ├── testing.md
│   │   └── git-workflow.md
│   ├── audit-reports/           # Generated audit reports
│   │   └── TEMPLATE.md
│   └── settings.local.json      # Claude Code project settings
├── .github/                     # GitHub Actions and scripts
│   ├── workflows/
│   │   └── documentation-audit.yml.template
│   ├── scripts/
│   │   └── audit-docs.py
│   ├── audit-config.yml
│   ├── README.md
│   └── SETUP.md
└── docs/                        # Project documentation
    ├── git-setup.md             # Git configuration guide
    ├── gh-cli-setup.md          # GitHub CLI setup
    ├── permissions-guide.md     # Claude Code permissions
    ├── response-style-guidelines.md  # Personal response preferences
    ├── planning/                # Implementation plans
    └── analysis/                # Code analysis documents
```

---

## Companion Plugin: Superpowers

This template works excellently with the [superpowers](https://github.com/obra/superpowers) plugin by Jesse Vincent, which provides disciplined development workflows.

| This Template | Superpowers |
|---------------|-------------|
| Project knowledge organization | Development methodology |
| Documentation structure | Behavioral workflows |
| `/audit`, `/verify-context`, `/load-module` | `/brainstorm`, `/write-plan`, `/execute-plan` |

Together they create a complete development environment where Claude knows both WHAT your project contains and HOW to work on it effectively.

**Quick Install:**
```bash
/plugin marketplace add obra/superpowers-marketplace
/plugin install superpowers@superpowers-marketplace
```

See [docs/superpowers-integration.md](docs/superpowers-integration.md) for detailed setup and usage.

---

## Documentation Structure

### CLAUDE.md

The main configuration file that Claude Code reads when starting a session. It contains:

- **Project Overview**: Tech stack, structure, and key directories
- **Custom Commands**: `/audit`, `/verify-context`, `/load-module`, `/load-workflow`
- **Development Commands**: Build, test, lint commands for quick reference
- **Critical Rules**: Project-wide constraints and requirements
- **Best Practices**: TDD approach, multiple options for decisions

### .claude/ Directory

Detailed documentation that Claude loads on-demand to reduce context overhead:

#### modules/
Module-specific documentation for different parts of your codebase. Use `_template.md` to create new module docs. Each module doc includes:
- Architecture and component structure
- Data models and API references
- Common patterns and integration points
- Testing and troubleshooting guides

**Usage**: Tell Claude `/load-module auth` to load authentication module context.

#### workflows/
Step-by-step guides for common development tasks:

| Workflow | Purpose |
|----------|---------|
| `feature-development.md` | Adding new features with proper planning, testing, and documentation |
| `bug-fixes.md` | Systematic bug investigation, fixing, and regression prevention |
| `refactoring.md` | Safe refactoring with test coverage and incremental changes |
| `documentation-audit.md` | Comprehensive review of all `.claude/` documentation |

**Usage**: Tell Claude `/load-workflow bug-fixes` before starting bug work.

#### conventions/
Coding standards and practices for consistency:

| Convention | Covers |
|------------|--------|
| `code-style.md` | Naming, file organization, comments, error handling |
| `testing.md` | Test structure, mocking, coverage, TDD practices |
| `git-workflow.md` | Branching, commits, PRs, code review process |

#### audit-reports/
Generated reports from the `/audit` command. Track documentation health over time.

### Custom Commands

These commands are defined in CLAUDE.md and help manage context efficiently:

| Command | Purpose |
|---------|---------|
| `/verify-context` | Show what documentation Claude has loaded |
| `/load-module <name>` | Load specific module documentation |
| `/load-workflow <name>` | Load workflow guide before starting work |
| `/read-all-context` | Load all documentation (use sparingly) |
| `/audit` | Run comprehensive documentation audit |

---

## GitHub Actions

### Documentation Audit Workflow

Automated documentation audits using Claude API. The workflow is provided as a template to prevent it from running in the bootstrap repo itself.

**To enable:**
```bash
mv .github/workflows/documentation-audit.yml.template .github/workflows/documentation-audit.yml
```

**Features:**
- Monthly scheduled audits
- PR checks when documentation changes
- Manual trigger option
- Automatic issue creation for critical findings
- PR comments with audit results

**Setup:**
1. Enable the workflow (rename `.template` to `.yml`)
2. Add `ANTHROPIC_API_KEY` to GitHub Secrets
3. Customize `audit-config.yml` as needed

See [.github/SETUP.md](.github/SETUP.md) for detailed instructions.

---

## Claude Code Settings

### .claude/settings.local.json

Project-level settings for Claude Code permissions. Pre-configured with safe defaults:

```json
{
  "permissions": {
    "allow": [
      "Bash(npm run:*)",
      "Bash(npx:*)"
    ]
  }
}
```

Customize based on your project's needs. See [docs/permissions-guide.md](docs/permissions-guide.md) for recommended permissions by platform.

### Response Style Guidelines

Personal preferences for how Claude responds are kept separate from project configuration. See [docs/response-style-guidelines.md](docs/response-style-guidelines.md) for guidelines you can add to your user-specific `~/.claude/CLAUDE.md`.

---

## Useful Prompts

### Project Setup

**Initialize a new project:**
```
Initialize a TypeScript Node.js project with:
- ESLint and Prettier configured
- Jest for testing with watch mode
- Pre-commit hooks for linting
- Update CLAUDE.md with actual commands
- Create initial module docs in .claude/modules/
```

**Analyze existing codebase:**
```
Analyze this codebase and:
1. Map out the architecture in .claude/architecture.md
2. Create module docs for each major component
3. Document the build/test/lint commands in CLAUDE.md
4. Identify coding conventions and add to .claude/conventions/
```

### Development Workflows

**Start a new feature:**
```
I want to add [feature]. Please:
1. Load the relevant workflow: /load-workflow feature-development
2. Create a feature plan
3. Implement using TDD (tests first)
4. Update documentation as needed
```

**Fix a bug:**
```
There's a bug: [description]. Please:
1. Load the bug fix workflow
2. Reproduce and write a failing test
3. Investigate root cause
4. Fix and verify
5. Add regression tests
```

**Refactor code:**
```
I want to refactor [component] because [reason]. Please:
1. Load the refactoring workflow
2. Ensure test coverage exists
3. Plan the refactoring approach
4. Make incremental changes, keeping tests green
```

### Documentation Maintenance

**Run documentation audit:**
```
/audit
```

**Update module documentation:**
```
The [module] has changed significantly. Please:
1. Load the current module doc
2. Analyze the actual code
3. Update the documentation to match reality
4. Check for any broken references
```

### Architecture Decisions

**Get implementation options:**
```
I need to [add feature/solve problem]. Please suggest 3-5 approaches with:
- Description of each approach
- Pros and cons
- Complexity assessment
- Your recommendation
```

---

## Tips for Effective Use

1. **Start sessions with context**: Tell Claude what you're working on so it can suggest relevant docs to load
2. **Use workflows**: Load the appropriate workflow before starting a task
3. **Keep docs updated**: Run `/audit` periodically and update docs when code changes
4. **Leverage TDD**: The workflows emphasize test-driven development for better results
5. **Customize templates**: Replace placeholder text in templates with your actual project details
6. **Use module docs**: Create focused documentation for each major component
7. **Trust the structure**: The documentation hierarchy is designed to minimize context while maximizing relevance

---

## Customization Checklist

After using this template:

- [ ] Update `CLAUDE.md` with actual project details
- [ ] Replace `[PROJECT NAME]` and other placeholders
- [ ] Create module docs for your main components
- [ ] Update `architecture.md` with your system design
- [ ] Customize conventions for your team's practices
- [ ] Configure permissions in `settings.local.json`
- [ ] Enable GitHub Actions if desired
- [ ] Add project-specific workflows if needed
- [ ] Consider installing superpowers plugin for enhanced workflows

---

## Documentation

| Document | Purpose |
|----------|---------|
| [CLAUDE.md](CLAUDE.md) | Main Claude Code configuration |
| [docs/git-setup.md](docs/git-setup.md) | Git configuration recommendations |
| [docs/gh-cli-setup.md](docs/gh-cli-setup.md) | GitHub CLI setup for PR creation |
| [docs/permissions-guide.md](docs/permissions-guide.md) | Safe commands to pre-approve |
| [docs/response-style-guidelines.md](docs/response-style-guidelines.md) | Personal response preferences |
| [.github/SETUP.md](.github/SETUP.md) | GitHub Actions configuration |

---

<!-- TIER-3-START -->
## Tier 3: Power User — Full Automation & Multi-Agent

*Building on Tiers 1 and 2, this tier adds CI/CD automation, git-backed issue tracking, session hooks, and optional multi-agent orchestration.*

### What This Tier Adds

```
.                                        # Adds to your existing structure
├── AGENTS.md                            # Multi-agent coordination guide
├── .claude/
│   └── settings.local.json              # + hook configurations (see below)
├── .github/
│   ├── workflows/
│   │   └── documentation-audit.yml      # Activated from .template
│   ├── scripts/
│   │   └── audit-docs.py               # Claude-powered audit script
│   ├── audit-config.yml                 # Audit thresholds and behavior
│   └── SETUP.md                         # GitHub Actions setup guide
├── .beads/                              # (Optional) Git-backed issue tracking
│   └── issues.jsonl                     # Issue database
└── docs/
    ├── git-setup.md                     # Git configuration guide
    ├── gh-cli-setup.md                  # GitHub CLI setup
    ├── permissions-guide.md             # Claude Code permissions reference
    ├── response-style-guidelines.md     # Personal response preferences
    ├── superpowers-integration.md       # Superpowers plugin guide
    ├── gastown-integration.md           # (Optional) Gas Town multi-agent guide
    ├── planning/                        # Implementation plans
    └── analysis/                        # Code analysis documents
```

---

### GitHub Actions: Automated Documentation Audit

A GitHub Actions workflow audits your `.claude/` documentation using the Claude API. It runs on a schedule, on documentation PRs, and on-demand.

**Enable it:**
```bash
mv .github/workflows/documentation-audit.yml.template \
   .github/workflows/documentation-audit.yml
```

**Add your API key:**
1. Go to your repo's **Settings > Secrets and variables > Actions**
2. Add `ANTHROPIC_API_KEY` with your Anthropic API key

**What it does:**
- Monthly scheduled audits (1st of each month)
- PR checks when `.claude/` or `CLAUDE.md` files change
- Creates GitHub issues for critical findings
- Comments on PRs with audit results

**Customize** in `.github/audit-config.yml`:
```yaml
model: claude-sonnet-4-20250514
thresholds:
  max_file_size: 600
  min_coverage: 80
ci_behavior:
  create_issue_on_critical: true
  comment_on_pr: true
```

See [.github/SETUP.md](.github/SETUP.md) for full setup instructions.

---

### Beads: Git-Backed Issue Tracking

[Beads](https://github.com/steveyegge/beads) (`bd` CLI) provides lightweight, git-backed issue tracking that Claude Code can read and update directly.

**Install:**
```bash
go install github.com/steveyegge/beads/cmd/bd@latest
```

**Initialize in your project:**
```bash
bd init
```

**Basic usage:**
```bash
bd create --title "Add user auth" --type feat --priority 2
bd list                    # View all issues
bd show <id>               # Full issue details
bd update <id> --status=in_progress
bd close <id>              # Mark complete
```

**Why it matters:** Issues live in your repo as `.beads/issues.jsonl`. Claude Code can read issue context, update status, and create new issues — all without leaving the terminal. No browser, no context switch.

**Suggested permissions** (add to `.claude/settings.local.json`):
```json
{
  "permissions": {
    "allow": [
      "Bash(bd list:*)",
      "Bash(bd show:*)",
      "Bash(bd --version:*)"
    ]
  }
}
```

---

### Hook Configurations

Hooks are shell commands that Claude Code runs in response to session events. They enforce project standards automatically.

Add hooks to `.claude/settings.local.json`:

```json
{
  "hooks": {
    "SessionStart": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "echo 'Load project context: run /verify-context to check loaded docs'"
          }
        ]
      }
    ],
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "echo 'Reminder: check permissions-guide.md for safe command patterns'"
          }
        ]
      }
    ],
    "PreCompact": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "echo 'Context compacting — ensure critical state is committed or noted'"
          }
        ]
      }
    ],
    "UserPromptSubmit": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "echo 'Workflow active — following project conventions'"
          }
        ]
      }
    ],
    "Stop": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "echo 'Session ending — verify all changes are committed'"
          }
        ]
      }
    ]
  }
}
```

| Hook | When It Fires | Use Case |
|------|---------------|----------|
| `SessionStart` | Session begins | Load context reminders, check environment |
| `PreToolUse` | Before any tool call | Guard dangerous operations, log activity |
| `PreCompact` | Before context compaction | Preserve critical state before memory trim |
| `UserPromptSubmit` | User sends a message | Inject workflow context, enforce conventions |
| `Stop` | Session ends | Verify cleanup, commit reminders |

Customize these hooks for your project. The examples above are starting points — replace the `echo` commands with scripts that enforce your team's standards.

---

### AGENTS.md

Create an `AGENTS.md` at your project root to guide any AI agent (not just Claude Code) working in the repo:

```markdown
# AGENTS.md

## Project Context
- This project uses the cc-bootstrap documentation structure
- All project context is in `.claude/` — start with `CLAUDE.md`
- Module docs are in `.claude/modules/`, workflows in `.claude/workflows/`

## Working Conventions
- Follow conventions in `.claude/conventions/`
- Run tests before committing: `<your test command>`
- Run linting before committing: `<your lint command>`

## Issue Tracking
- Issues are tracked in `.beads/issues.jsonl` (if using Beads)
- Use `bd show <id>` to read issue context before starting work

## Multi-Agent Coordination
- If multiple agents work in this repo, coordinate via git branches
- Each agent should work on a separate branch
- Do not force-push or rewrite shared history
```

This file is read by any agent entering the repository, providing immediate orientation regardless of the agent framework.

---

### Gas Town: Multi-Agent Orchestration (Optional)

> **This section is entirely optional.** Everything above works without Gas Town. Add Gas Town only if you need multiple Claude Code agents working in parallel across your projects.

[Gas Town](https://github.com/steveyegge/gastown) orchestrates multiple Claude Code agents across projects. It manages agent lifecycles, work assignment, and coordination through git-backed state.

| Single Agent (Tiers 1-2) | Multi-Agent (Gas Town) |
|---------------------------|------------------------|
| One Claude Code session | Multiple parallel agents |
| Manual task management | Automated work dispatch |
| Project-level context | Workspace-level coordination |
| `/audit`, `/load-module` | `gt sling`, `gt convoy` |

**Install:**
```bash
# Homebrew (recommended)
brew install gastown

# Or via Go
go install github.com/steveyegge/gastown/cmd/gt@latest
```

**Initial setup:**
```bash
gt install ~/gt --git          # Create workspace
cd ~/gt
gt rig add myproject <repo>    # Add your project
gt crew add yourname --rig myproject
gt mayor attach                # Start the coordinator
```

**Key concepts:**

| Term | Description |
|------|-------------|
| **Town** | Root workspace containing all projects |
| **Mayor** | AI coordinator with workspace-wide context |
| **Rig** | Project container wrapping a git repo |
| **Polecat** | Ephemeral worker agent for a specific task |
| **Convoy** | Bundle of related work items |

**Suggested permissions** for Gas Town (add to `.claude/settings.local.json`):
```json
{
  "permissions": {
    "allow": [
      "Bash(gt rig:*)",
      "Bash(gt convoy:*)",
      "Bash(gt agents:*)",
      "Bash(gt config show:*)"
    ]
  }
}
```

Agent-spawning commands (`gt mayor attach`, `gt sling`) are intentionally not pre-approved — they create new sessions that consume API credits.

See [docs/gastown-integration.md](docs/gastown-integration.md) for the full setup guide.

---

### What This Enables

With Tier 3 fully configured, you get:

- **Automated quality gates** — GitHub Actions audits catch documentation drift before it becomes a problem
- **Git-native issue tracking** — Beads issues live in your repo; Claude reads and updates them directly
- **Session guardrails** — Hooks enforce conventions automatically at session start, tool use, and session end
- **Agent-ready repos** — AGENTS.md means any AI agent can orient itself in your project immediately
- **Parallel development** (with Gas Town) — Multiple agents work on separate tasks simultaneously, coordinated through git-backed state
<!-- TIER-3-END -->

---

## Contributing

Contributions are welcome! Please feel free to submit issues or pull requests.

## License

MIT License - feel free to use this template for any project.
