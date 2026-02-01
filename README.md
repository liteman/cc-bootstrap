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

<!-- TIER 1: Beginner section (cc-rwq.1) -->

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
