# Claude Code Bootstrap (ccbootstrap)

A tiered setup template for [Claude Code](https://claude.ai/code) — from a minimal 2-file config to full multi-agent orchestration.

## Choose Your Tier

| Tier | What You Get | Files |
|------|-------------|-------|
| [Beginner](#tier-1-beginner--get-productive-fast) | Claude knows your project, safe permissions, builds/tests work | 2 |
| [Intermediate](#tier-2-intermediate--structured-development-workflows) | + modular docs, workflows, conventions, Superpowers plugin | ~15 |
| [Power User](#tier-3-power-user--full-automation--multi-agent) | + GitHub Actions, Beads tracking, Gas Town orchestration | ~25 |

Each tier is additive — start at Beginner and layer on what you need.

---

<!-- TIER 1: BEGINNER -->
## Tier 1: Get Productive Fast

Two files. Five minutes. You'll have Claude Code working effectively in your project.

### What You'll Set Up

```
your-project/
├── CLAUDE.md                       # Project context for Claude Code
└── .claude/
    └── settings.local.json         # Safe permission defaults
```

That's it. These two files give Claude Code the context it needs to understand your project and the permissions to run your standard tools without asking every time.

### CLAUDE.md — Tell Claude About Your Project

Create `CLAUDE.md` in your project root. This is the first file Claude Code reads when it starts a session.

**Let Claude generate it for you.** Instead of filling in placeholders manually, start a Claude Code session in your project and use this prompt:

```
Analyze this project and create a CLAUDE.md file in the project root.
Include: a one-sentence project description, the tech stack, the commands
to install dependencies / run the dev server / run tests / lint / build,
the key directories with short descriptions, and 2-3 critical rules
for working in this codebase. Use the format below as a guide.
```

Or, if you prefer to write it by hand, here's the template:

````markdown
# Project Overview

[One-sentence description of what this project does.]

## Tech Stack

- Language: [e.g., TypeScript, Python, Go]
- Framework: [e.g., Next.js, FastAPI, none]
- Package manager: [e.g., npm, pip, cargo]

## Commands

```bash
# Install dependencies
[e.g., npm install]

# Run dev server
[e.g., npm run dev]

# Run tests
[e.g., npm test]

# Run linter
[e.g., npm run lint]

# Build
[e.g., npm run build]
```

## Project Structure

- `src/` — Application source code
- `tests/` — Test files
- [Add your key directories]

## Critical Rules

- [e.g., Always write tests for new features]
- [e.g., Never commit directly to main]
- [Add any rules Claude must follow]
````

Replace the bracketed placeholders with your actual project details. Be specific — the more accurate this file is, the better Claude Code performs.

### .claude/settings.local.json — Safe Permission Defaults

Create `.claude/settings.local.json` to pre-approve common safe commands so Claude Code doesn't ask for permission on every build or test run:

```json
{
  "permissions": {
    "allow": [
      "Bash(npm run:*)",
      "Bash(npx:*)",
      "Bash(npm test:*)",
      "Bash(npm install)",
      "Bash(git status)",
      "Bash(git diff:*)",
      "Bash(git log:*)"
    ],
    "deny": [
      "Bash(curl:*)",
      "Bash(wget:*)",
      "Bash(rm -rf:*)"
    ]
  }
}
```

Adjust the `allow` list to match your project's toolchain. For example, use `Bash(python:*)` and `Bash(pip:*)` for Python projects, or `Bash(cargo:*)` for Rust. The `deny` list blocks commands you never want Claude to run without asking.

### Quick Start

#### New Project

```bash
# Create your project
mkdir my-project && cd my-project
git init

# Create the two files above:
# 1. CLAUDE.md at the project root
# 2. .claude/settings.local.json

# Start Claude Code
claude
```

#### Existing Project

```bash
cd your-project

# Create the two files above:
# 1. CLAUDE.md at the project root
# 2. .claude/settings.local.json

# Start Claude Code
claude
```

### Suggested First-Session Prompt

Once you've created both files and started Claude Code, try this prompt to validate your setup:

```
Read CLAUDE.md and confirm you understand the project. Then run the
test suite and tell me if anything fails. If tests pass, summarize
the project structure in your own words.
```

This verifies Claude Code can read your config, execute your commands with the granted permissions, and navigate your codebase.

### What This Enables

With just these two files, Claude Code can:

- **Understand your project** — tech stack, structure, and conventions from `CLAUDE.md`
- **Run your tools** — build, test, and lint without permission prompts for each command
- **Follow your rules** — critical constraints are front-and-center every session
- **Stay safe** — denied commands require explicit approval before running

This is the foundation. When you're ready for more structure — custom commands, workflow guides, coding conventions, and automated audits — see Tier 2.

<!-- /TIER 1: BEGINNER -->

---

<!-- TIER 2 START -->
## Tier 2: Intermediate — Structured Development Workflows

> **Building on Tier 1.** You already have `CLAUDE.md` and `settings.local.json`. This tier adds structured workflows, conventions, and on-demand documentation so Claude works consistently across features, bugs, and refactors.

### What you're adding

```
.
├── CLAUDE.md                        # Enhanced with custom commands (update existing)
├── .claude/
│   ├── settings.local.json          # (from Tier 1)
│   ├── architecture.md              # System design overview
│   ├── modules/                     # On-demand module documentation
│   │   └── _template.md             # Starting template for new modules
│   ├── workflows/                   # Step-by-step development guides
│   │   ├── feature-development.md
│   │   ├── bug-fixes.md
│   │   └── refactoring.md
│   ├── design/                      # Design methodology (optional)
│   │   ├── workflows/               # Structured design process
│   │   ├── conventions/             # Design thinking guidance
│   │   └── templates/               # Design documents, ADRs
│   └── conventions/                 # Team coding standards
│       ├── code-style.md
│       ├── testing.md
│       └── git-workflow.md
├── docs/
│   └── design/                      # Design guides (optional)
│       ├── design-workflow-guide.md
│       ├── design-phase-reference.md
│       └── adr-guide.md
└── (Superpowers plugin)             # Installed via Claude Code CLI
```

### Why each piece matters

**`architecture.md`** — Gives Claude a map of your system. Without it, Claude re-discovers your architecture every session by reading code. With it, Claude starts each session already knowing which components exist, how they connect, and where to make changes.

**`modules/`** — On-demand deep dives into specific parts of your codebase. Instead of loading everything into context, you load only what's relevant: `/load-module auth` before working on authentication, `/load-module payments` before billing changes. Keeps context focused and responses accurate.

**`workflows/`** — Repeatable processes that Claude follows step-by-step:

| Workflow | What it does |
|----------|-------------|
| `feature-development.md` | Plan, implement with TDD, test, document |
| `bug-fixes.md` | Reproduce, isolate root cause, fix, add regression tests |
| `refactoring.md` | Verify coverage, make incremental changes, keep tests green |

Without workflows, you describe your process every time. With them, Claude follows the same disciplined approach whether it's your first session or your fiftieth.

**`conventions/`** — Codified standards that prevent style drift:

| Convention | Prevents |
|------------|----------|
| `code-style.md` | Inconsistent naming, file organization, error handling |
| `testing.md` | Untested code, flaky tests, missing coverage |
| `git-workflow.md` | Messy commits, unclear PRs, broken branches |

Claude reads these once per session and applies them to every change it makes.

**`design/` (optional)** — Structured design methodology for architectural decisions. This is not required for simple features, but becomes valuable when:

- **Facing significant architectural decisions** — Multiple viable approaches exist (e.g., WebSockets vs SSE for real-time features)
- **Unclear implementation path** — Need to explore problem space before solutions
- **High reversal cost** — Decision will be expensive or complex to change later
- **Cross-cutting changes** — Affects multiple modules or establishes patterns others will follow

The design workflows guide you through 6 phases: Exploration → Requirements → Options → Decision → Detail → Validation. Use `/start-design-session` to begin, iterate through phases with `/load-design-phase <phase>`, then transition to implementation with `/finalize-design`.

**Design complements Superpowers:**

| Flow Stage | Tool | What It Does |
|------------|------|--------------|
| Initial exploration | `/brainstorm` (Superpowers) | Socratic questioning |
| Structured design | `/load-design-phase` (cc-bootstrap) | Architecture iteration |
| Implementation planning | `/write-plan` (Superpowers) | Detailed plan creation |
| TDD implementation | `/execute-plan` (Superpowers) | Test-driven coding |

See [docs/design/design-workflow-guide.md](docs/design/design-workflow-guide.md) for when to use design vs. implementation workflows, and [docs/design-integration.md](docs/design-integration.md) for how design workflows integrate with Superpowers.

### Enhanced CLAUDE.md

Add these custom commands to your existing `CLAUDE.md`:

```markdown
## Custom Commands

- `/load-module <name>` — Read `.claude/modules/<name>.md` for deep context on a specific component
- `/load-workflow <name>` — Read `.claude/workflows/<name>.md` before starting that type of work
- `/verify-context` — List which documentation files have been loaded this session
- `/audit` — Review all `.claude/` documentation for accuracy against current code
- `/start-design-session` — Begin structured design with Opus model (for architectural decisions)
- `/load-design-phase <phase>` — Load specific design phase workflow (exploration, requirements, options, decision, detail, validation)
- `/finalize-design` — Transition from design to implementation, create ADRs, update architecture.md
```

These commands give you explicit control over what Claude knows during a session. Load only what you need, verify what's loaded, and audit for staleness.

### Install the Superpowers plugin

[Superpowers](https://github.com/obra/superpowers) by Jesse Vincent adds disciplined development methodology on top of your project knowledge:

```bash
/plugin marketplace add obra/superpowers-marketplace
/plugin install superpowers@superpowers-marketplace
```

| This template provides | Superpowers provides |
|------------------------|---------------------|
| Project knowledge (what) | Development methodology (how) |
| `/load-module`, `/load-workflow`, `/audit` | `/brainstorm`, `/write-plan`, `/execute-plan` |
| Documentation structure | TDD enforcement, systematic debugging |

Together they mean Claude knows both your codebase and a disciplined way to work on it. See [docs/superpowers-integration.md](docs/superpowers-integration.md) for configuration details.

### Setup steps

1. **Create the directory structure:**
   ```bash
   mkdir -p .claude/modules .claude/workflows .claude/conventions
   ```

2. **Create `architecture.md`** — Start a Claude session and ask:
   ```
   Analyze this codebase and create .claude/architecture.md covering:
   - High-level component overview
   - Data flow between components
   - Key architectural decisions and trade-offs
   ```

3. **Create module docs** — For each major component:
   ```bash
   cp .claude/modules/_template.md .claude/modules/<component-name>.md
   ```
   Then ask Claude to fill it in by analyzing the relevant code.

4. **Customize workflows** — Edit each workflow file in `.claude/workflows/` to match your team's process (branching strategy, review requirements, deploy steps).

5. **Set conventions** — Document your actual standards in `.claude/conventions/`. Be specific: naming patterns, test file locations, commit message format.

6. **Add custom commands to CLAUDE.md** — Copy the commands section above into your existing `CLAUDE.md`.

7. **Install Superpowers** — Run the plugin install commands above inside a Claude Code session.

### What this enables

- **Consistent development process** — Every feature, bug fix, and refactor follows documented steps instead of ad-hoc prompting
- **On-demand context loading** — Claude reads only what's relevant, keeping responses focused and reducing hallucination
- **Team-wide standards** — Conventions are enforced automatically, not remembered manually
- **Session independence** — Any team member starts a Claude session and gets the same structured approach, no tribal knowledge required
- **Composable methodology** — Your project knowledge (this template) combined with development discipline (Superpowers) covers both what to build and how to build it
<!-- TIER 2 END -->

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

## Customization Checklist

### After Tier 1

- [ ] Replace placeholders in `CLAUDE.md` with your project details
- [ ] Update build/test/lint commands
- [ ] Review permissions in `.claude/settings.local.json`

### After Tier 2

- [ ] Create module docs for your main components in `.claude/modules/`
- [ ] Update `.claude/architecture.md` with your system design
- [ ] Customize conventions in `.claude/conventions/` for your team
- [ ] Install Superpowers plugin
- [ ] Try `/load-workflow feature-development` on your first task
- [ ] (Optional) Review design templates in `.claude/design/templates/` for architectural decision documentation
- [ ] (Optional) Try `/start-design-session` on your next complex architectural decision

### After Tier 3

- [ ] Enable GitHub Actions (`mv .template` to `.yml`, add `ANTHROPIC_API_KEY` secret)
- [ ] Initialize Beads for issue tracking
- [ ] Configure hooks in `.claude/settings.json`
- [ ] (Optional) Set up Gas Town agents

---

## Custom Commands Reference

Commands defined in `CLAUDE.md` for on-demand context loading (Tier 2+):

| Command | Description |
|---------|-------------|
| `/verify-context` | Show what documentation Claude currently has loaded |
| `/load-module <name>` | Load a specific module doc from `.claude/modules/` |
| `/load-workflow <name>` | Load a workflow guide before starting a task |
| `/read-all-context` | Load all documentation at once (use sparingly — high token cost) |
| `/audit` | Run a comprehensive documentation health audit |
| `/start-design-session` | Begin structured design session with Opus model (architectural decisions) |
| `/load-design-phase <phase>` | Load specific design phase: exploration, requirements, options, decision, detail, validation |
| `/finalize-design` | Transition from design to implementation, create ADRs, update architecture |

---

## Companion Plugin: Superpowers

The [superpowers](https://github.com/obra/superpowers) plugin by Jesse Vincent adds disciplined development methodology on top of this template's project knowledge structure.

| ccbootstrap provides | Superpowers provides |
|----------------------|----------------------|
| Project knowledge organization | Development methodology |
| Documentation structure & context loading | Behavioral workflows (TDD, verification) |
| `/audit`, `/verify-context`, `/load-module` | `/brainstorm`, `/write-plan`, `/execute-plan` |

**Install:**
```bash
/plugin marketplace add obra/superpowers-marketplace
/plugin install superpowers@superpowers-marketplace
```

See [docs/superpowers-integration.md](docs/superpowers-integration.md) for detailed setup and usage.

---

## Documentation Index

| Document | Description |
|----------|-------------|
| [CLAUDE.md](CLAUDE.md) | Primary Claude Code configuration — project overview, commands, rules |
| [docs/permissions-guide.md](docs/permissions-guide.md) | Recommended permission patterns by platform |
| [docs/git-setup.md](docs/git-setup.md) | Git configuration for Claude Code workflows |
| [docs/gh-cli-setup.md](docs/gh-cli-setup.md) | GitHub CLI setup for PR creation |
| [docs/superpowers-integration.md](docs/superpowers-integration.md) | Superpowers plugin setup and usage guide |
| [docs/gastown-integration.md](docs/gastown-integration.md) | Gas Town multi-agent orchestration guide |
| [docs/design/design-workflow-guide.md](docs/design/design-workflow-guide.md) | When to use design vs. implementation workflows |
| [docs/design/design-integration.md](docs/design/design-integration.md) | Design methodology + Superpowers integration |
| [docs/design/design-phase-reference.md](docs/design/design-phase-reference.md) | Quick reference for the 6 design phases |
| [docs/design/adr-guide.md](docs/design/adr-guide.md) | ADR best practices and writing guide |
| [docs/response-style-guidelines.md](docs/response-style-guidelines.md) | Personal response style preferences (`~/.claude/CLAUDE.md`) |
| [.github/SETUP.md](.github/SETUP.md) | GitHub Actions documentation audit setup |

---

## Contributing

Contributions are welcome. Please open an issue or submit a pull request.

## License

MIT License — use this template for any project.
