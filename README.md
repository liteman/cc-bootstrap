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

## Key Directories

| Directory | Purpose | Details |
|-----------|---------|---------|
| `.claude/modules/` | Per-component documentation, loaded on demand | Use `/load-module <name>` |
| `.claude/workflows/` | Step-by-step guides for features, bugs, refactoring | Use `/load-workflow <name>` |
| `.claude/conventions/` | Code style, testing, and git standards | Loaded automatically via CLAUDE.md |
| `.github/` | Documentation audit workflow and scripts | See [.github/SETUP.md](.github/SETUP.md) |
| `docs/` | Project docs: permissions, git setup, integrations | See [Documentation](#documentation) below |

Custom commands (`/audit`, `/verify-context`, `/load-module`, `/load-workflow`, `/read-all-context`) are defined in CLAUDE.md.

---

## GitHub Actions

Automated documentation audits via Claude API. The workflow ships as a `.template` file — rename to `.yml` to enable. See [.github/SETUP.md](.github/SETUP.md) for setup instructions.

---

## Configuration

- **Permissions**: Pre-configured in `.claude/settings.local.json`. See [docs/permissions-guide.md](docs/permissions-guide.md) for recommended settings.
- **Response style**: Personal preferences go in `~/.claude/CLAUDE.md`. See [docs/response-style-guidelines.md](docs/response-style-guidelines.md).

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

## Contributing

Contributions are welcome! Please feel free to submit issues or pull requests.

## License

MIT License - feel free to use this template for any project.
