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

<!-- TIER 2: Intermediate section (cc-rwq.2) -->

---

<!-- TIER 3: Power User section (cc-rwq.3) -->

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
| [docs/response-style-guidelines.md](docs/response-style-guidelines.md) | Personal response style preferences (`~/.claude/CLAUDE.md`) |
| [.github/SETUP.md](.github/SETUP.md) | GitHub Actions documentation audit setup |

---

## Contributing

Contributions are welcome. Please open an issue or submit a pull request.

## License

MIT License — use this template for any project.
