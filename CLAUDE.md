# [PROJECT NAME]

> **Note**: This is a template. Replace placeholders in [BRACKETS] with your project-specific information.

## Quick Start

When starting a new session:
1. Tell me what you're working on (feature, bug fix, refactoring, etc.)
2. I'll suggest relevant documentation to load
3. Confirm the context before we begin

Type `/verify-context` anytime to see what guides I have loaded.

---

## Project Overview

**Tech Stack**: [e.g., Next.js 14, PostgreSQL, Redis, Tailwind CSS]
**Primary Language**: [e.g., TypeScript]
**Deployment**: [e.g., Vercel, AWS]

### Key Directories
```
[PROJECT ROOT]/
├── src/               # [Description]
├── tests/             # [Description]
├── docs/              # Project documentation
└── .claude/           # Claude Code documentation
```

---

## Best Practices

- **Use TDD**: When implementing features, prefer test-driven development - write tests first, then implementation
- **Multiple Options**: When facing architectural or implementation decisions, suggest 3-5 approaches with pros/cons
- **Linters & Hooks**: Once project language is established, proactively suggest and configure appropriate linters and git hooks

### Model Selection

Use the appropriate model for each phase of work to balance quality and cost:

| Phase | Model | Rationale |
|-------|-------|-----------|
| **Planning** (architecture, design, complex reasoning) | **Opus** | Deep reasoning for design decisions, trade-off analysis, and plan creation |
| **Implementation** (writing code, editing files, executing plans) | **Sonnet** | Fast, capable code generation with good cost efficiency |
| **Review** (audits, code review, documentation review) | **Haiku** | Quick, cost-effective analysis for structured review tasks |

**When spawning sub-agents via the Task tool**, set the `model` parameter accordingly:
- `model: "opus"` — Plan mode, architectural decisions, complex debugging
- `model: "sonnet"` — Code implementation, file edits, test writing
- `model: "haiku"` — Audit scans, code review, linting checks

---

## Documentation Structure

Detailed documentation is organized in the `.claude/` directory:

### Modules
When working on specific modules, read the relevant guide:
- **[Module 1]**: Read `.claude/modules/[module-1].md`
- **[Module 2]**: Read `.claude/modules/[module-2].md`
- **[Module 3]**: Read `.claude/modules/[module-3].md`

### Workflows
Before starting work, read the appropriate workflow:
- **New Feature**: Read `.claude/workflows/feature-development.md`
- **Bug Fix**: Read `.claude/workflows/bug-fixes.md`
- **Refactoring**: Read `.claude/workflows/refactoring.md`

### Conventions
For coding standards and practices:
- **Code Style**: `.claude/conventions/code-style.md`
- **Testing**: `.claude/conventions/testing.md`
- **Git Workflow**: `.claude/conventions/git-workflow.md`

### Documentation Organization
- **Implementation plans**: Save in `docs/plans/`
- **Code analysis**: Save in `docs/analysis/`

---

## Custom Commands

### Context Loading

#### /verify-context
Summarize what documentation I have loaded for this session.

Response format:
```
Context loaded:
- Guides read: [list of .md files]
- Module focus: [current module]
- Workflow: [current workflow]
- Key constraints: [list 3-5 critical rules]

Ready to proceed? Let me know if I should load additional context.
```

#### /load-module <name>
Load the specified module guide from `.claude/modules/<name>.md`

Example: `/load-module auth` reads `.claude/modules/auth.md`

#### /load-workflow <name>
Load the specified workflow guide from `.claude/workflows/<name>.md`

Example: `/load-workflow feature-development`

#### /read-all-context
For complex work spanning multiple areas, read:
1. Relevant module guides
2. Applicable workflow
3. Related conventions

Use sparingly - only when truly needed for cross-cutting work.

#### /audit [quick|full]
Perform a comprehensive audit of the `.claude/` documentation structure. Implemented as a skill in `.claude/skills/audit/SKILL.md`.

**Usage**:
- `/audit` or `/audit full` - Complete 5-phase audit with remediation options
- `/audit quick` - Fast scan focusing on critical/high priority issues only

**When to use**:
- Monthly quick checks (`/audit quick`)
- Quarterly full audits (`/audit full`)
- After major refactoring or architecture changes
- When documentation feels stale or hard to navigate

See `.claude/AUDIT_COMMAND.md` for quick reference and `.claude/workflows/documentation-audit.md` for detailed workflow.

### Session Start Protocol

At the beginning of each session, I should:
1. Ask what area of the codebase you're working on
2. Suggest reading the relevant guide(s)
3. Wait for confirmation before loading
4. Summarize loaded context
5. Proceed with the work

Example interaction:
```
User: I need to add OAuth support
Claude: I should load the authentication module guide. Should I read
        `.claude/modules/auth.md` and `.claude/workflows/feature-development.md`?
User: Yes
Claude: [loads guides] Context loaded: [summary]. Ready to proceed?
```

---

## Development Commands

### Setup
```bash
# Add installation/setup commands here
```

### Build
```bash
# Add build commands here
```

### Testing
```bash
# Run all tests

# Run a single test file

# Run tests in watch mode
```

### Linting
```bash
# Add linting commands here
```

---

## Architecture

[Describe the high-level architecture and key design decisions that aren't immediately obvious from reading individual files]

See `.claude/architecture.md` for detailed architecture documentation.

### Key Components

[Describe major components and how they interact]

### Project Structure

[Only include non-obvious structural decisions or patterns that span multiple directories]

---

## Critical Rules

> These rules apply to ALL work, regardless of context.

### Code Quality
- [ ] All code must pass linting and type checks
- [ ] Tests required for new features and bug fixes
- [ ] Code reviews required before merging
- [ ] [Add project-specific rules]

### Git Workflow
- [ ] Use conventional commits (feat:, fix:, docs:, etc.)
- [ ] Branch naming: `[type]/[description]` (e.g., `feat/oauth-login`)
- [ ] Squash commits before merging
- [ ] Update CHANGELOG.md for user-facing changes
- [ ] [Add project-specific rules]

### Testing
- [ ] Unit tests for business logic
- [ ] Integration tests for API endpoints
- [ ] E2E tests for critical user flows
- [ ] [Add project-specific rules]

### Documentation
- [ ] Update relevant .md files when changing architecture
- [ ] Add JSDoc/comments for complex logic
- [ ] Update API documentation for endpoint changes
- [ ] [Add project-specific rules]

---

## Important Conventions

[Document any project-specific conventions, patterns, or constraints that Claude should follow when modifying code]

---

## Common Patterns

### [Pattern 1 Name]
```
[Brief description]
[Example code or reference]
```

### [Pattern 2 Name]
```
[Brief description]
[Example code or reference]
```

---

## Quick Reference

### Build & Run
```bash
[Add your build commands]
npm install
npm run dev
npm run build
npm test
```

### Common Commands
```bash
[Add project-specific commands]
npm run lint
npm run type-check
npm run test:watch
```

### Environment Setup
```bash
[Add setup instructions]
cp .env.example .env
# Edit .env with your values
```

---

## Troubleshooting

### [Common Issue 1]
**Problem**: [Description]
**Solution**: [How to fix]

### [Common Issue 2]
**Problem**: [Description]
**Solution**: [How to fix]

---

## Setup & Configuration

### Git Configuration
For optimal git workflow with Claude Code, see [docs/git-setup.md](docs/git-setup.md) for recommended git configuration settings.

### GitHub CLI
For GitHub operations like creating pull requests and managing issues, Claude Code can use the GitHub CLI (`gh`). See [docs/gh-cli-setup.md](docs/gh-cli-setup.md) for setup instructions.

### Permissions
To streamline your workflow, you can pre-approve safe commands for Claude Code to run without prompting. See [docs/permissions-guide.md](docs/permissions-guide.md) for recommended low-risk permissions organized by platform.

### GitHub Actions
For automated documentation audits, see [.github/ACTIONS.md](.github/ACTIONS.md) and [.github/SETUP.md](.github/SETUP.md) for setup instructions. Note: The workflow file is provided as `.yml.template` and must be renamed to `.yml` to enable it.

### Response Style Guidelines
For personal response style preferences, see [docs/response-style-guidelines.md](docs/response-style-guidelines.md) for guidelines you can add to your user-specific `~/.claude/CLAUDE.md`.

---

## Getting Help

- **Documentation**: See `.claude/` directory for detailed guides
- **Architecture**: Read `.claude/architecture.md`
- **Module-specific**: Check `.claude/modules/`
- **Workflows**: Review `.claude/workflows/`
- **Conventions**: See `.claude/conventions/`

**Remember**: Start each session by loading the right context!

---

## Recommended Plugins

### Superpowers (Optional but Recommended)

[Superpowers](https://github.com/obra/superpowers) is a skills library that provides disciplined development workflows. It complements this template:

- **This template** provides WHAT Claude needs to know (documentation, context)
- **Superpowers** provides HOW Claude should work (methodology, workflows)

**Installation:**
```bash
/plugin marketplace add obra/superpowers-marketplace
/plugin install superpowers@superpowers-marketplace
```

**Key Skills:**
- `/brainstorm` - Interactive design refinement
- `/write-plan` - Create detailed implementation plans
- `/execute-plan` - Execute plans with checkpoints
- TDD enforcement ("Iron Law")
- Systematic debugging
- Two-stage code review

**How it works with this template:**
When both are installed, superpowers handles the development methodology (brainstorming, planning, TDD enforcement) while this template provides project-specific context through modules, workflows, and conventions.

**Security Note:** Superpowers uses aggressive instruction patterns. For proprietary projects, consider version pinning and reviewing updates before adoption. See [docs/superpowers-integration.md](docs/superpowers-integration.md) for detailed integration guide and security considerations.

### Gastown (Optional - Multi-Agent Orchestration)

[Gastown](https://github.com/steveyegge/gastown) is a multi-agent orchestration system that manages coordinated workflows across multiple Claude Code agents. It complements this template:

- **This template** provides per-project documentation and context
- **Gastown** orchestrates multiple agents across projects with persistent state

**Installation:**
```bash
brew install gastown          # Homebrew (recommended)
npm install -g @gastown/gt   # npm
go install github.com/steveyegge/gastown/cmd/gt@latest  # Go
```

**Quick Start:**
```bash
gt install ~/gt --git
gt rig add myproject https://github.com/you/repo.git
gt crew add yourname --rig myproject
gt mayor attach
```

**Key Commands:**
- `gt mayor attach` - Start the Mayor coordinator
- `gt rig add` - Add a project repository
- `gt sling` - Assign work to an agent
- `gt convoy create` - Create a tracked work bundle
- `gt agents` - List active agents

**How it works with this template:**
Gastown operates at the workspace level (orchestrating agents across projects) while this template operates at the project level (structuring documentation and context). Agents spawned by Gastown automatically benefit from cc-bootstrap's `.claude/` documentation when working in a project rig.

**When to use:** Large features, parallel workstreams, complex refactors, or multi-project coordination where multiple agents working simultaneously adds value. See [docs/gastown-integration.md](docs/gastown-integration.md) for the full integration guide.
