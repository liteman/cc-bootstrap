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
│   └── conventions/                 # Team coding standards
│       ├── code-style.md
│       ├── testing.md
│       └── git-workflow.md
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

### Enhanced CLAUDE.md

Add these custom commands to your existing `CLAUDE.md`:

```markdown
## Custom Commands

- `/load-module <name>` — Read `.claude/modules/<name>.md` for deep context on a specific component
- `/load-workflow <name>` — Read `.claude/workflows/<name>.md` before starting that type of work
- `/verify-context` — List which documentation files have been loaded this session
- `/audit` — Review all `.claude/` documentation for accuracy against current code
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
