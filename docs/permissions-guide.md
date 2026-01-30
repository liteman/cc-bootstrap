# Claude Code Permissions Guide

This guide suggests low-risk commands to add to Claude Code's permissions, allowing Claude to run them without prompting for approval each time.

## What Are Permissions?

Permissions allow you to pre-approve specific commands or command patterns. When configured, Claude can execute these without interrupting your workflow for approval.

## How to Configure

This template includes a `.claude/settings.json` file with recommended safe permissions pre-configured. You can:

1. **Use the template as-is** - The included permissions are low-risk and suitable for most development workflows
2. **Add project-specific permissions** - Edit `.claude/settings.json` to add build/test commands specific to your project
3. **Override locally** - Create `.claude/settings.local.json` for personal preferences (this file is gitignored)

### Settings Files

- **`.claude/settings.json`** - Project template (committed to git, shared with team)
- **`.claude/settings.local.json`** - Local overrides (gitignored, personal preferences)

### Permission Format

Permissions use the pattern:
```
Bash(command:pattern)
```

Example:
```json
{
  "permissions": {
    "allow": ["Bash(ls:*)", "Bash(git status:*)"],
    "deny": [],
    "ask": []
  }
}
```

## Pre-Configured Deny Rules

This template's `.claude/settings.json` blocks these destructive commands by default:

### File Deletion
```
Bash(rm -rf:*)
Bash(rm -fr:*)
Bash(rm -r:*)
Bash(rmdir:*)
Bash(del:*)
```
Denied because: Recursive file deletion is irreversible and the most common source of catastrophic data loss.

### Permission Changes
```
Bash(chmod:*)
Bash(chown:*)
```
Denied because: Rarely needed in development workflows; can break file access or introduce security issues.

### Git History Destruction
```
Bash(git push --force:*)
Bash(git push -f:*)
Bash(git reset --hard:*)
Bash(git clean -fd:*)
Bash(git checkout -- .:*)
```
Denied because: These rewrite or discard history/changes irreversibly. Force-push can destroy teammates' work; hard reset and clean permanently delete uncommitted changes.

### Not Denied (by design)

| Command | Why it's not denied |
|---------|---------------------|
| `rm` (without `-r`) | Single-file removal is a normal dev operation |
| `mv`, `cp` | Common file operations; blocking would be overly restrictive |
| `npm install`, `pip install` | Frequently needed; better handled via `ask` if desired |
| `git push` (without `--force`) | Normal workflow; only force-push is dangerous |

---

## Pre-Configured Permissions

This template's `.claude/settings.json` includes these safe permissions:

### File System Operations (Read-Only)
```
Bash(ls:*)
Bash(pwd:*)
Bash(tree:*)
Bash(file:*)
Bash(which:*)
Bash(whereis:*)
Bash(mkdir:*)
Bash(mkdir -p:*)
```

### Git Operations (Read-Only)
```
Bash(git status:*)
Bash(git diff:*)
Bash(git log:*)
Bash(git show:*)
Bash(git branch:*)
Bash(git remote:*)
Bash(git config --get:*)
Bash(git config --list:*)
```

### System Information
```
Bash(date:*)
Bash(uname:*)
Bash(hostname:*)
Bash(whoami:*)
```

## Additional Low-Risk Permissions

You may want to add these permissions based on your project needs:

### macOS/Linux

#### Package Manager Information
```
Bash(npm list:*)
Bash(npm outdated:*)
Bash(yarn list:*)
Bash(pip list:*)
Bash(pip show:*)
Bash(cargo --version:*)
Bash(bundle list:*)
```
Safe because: These only query package information without installing or modifying.

#### Build & Test (Project-Specific)
```
Bash(npm run build:*)
Bash(npm test:*)
Bash(npm run lint:*)
Bash(yarn build:*)
Bash(yarn test:*)
Bash(make test:*)
Bash(pytest:*)
Bash(cargo test:*)
Bash(go test:*)
```
Moderate risk: These execute project code. Only add if you trust your test scripts. Good for CI-like workflows.

#### System Information
```
Bash(date:*)
Bash(uname:*)
Bash(hostname:*)
Bash(whoami:*)
```
Safe because: Read-only system information.

#### Directory Creation (Low-Risk)
```
Bash(mkdir:*)
Bash(mkdir -p:*)
```
Low risk: Only creates directories. Claude already has this pre-approved by default for certain patterns.

### Windows

#### File System Operations
```
Bash(dir:*)
Bash(where:*)
```
Safe because: Read-only file system information.

#### Git Operations (Read-Only)
```
Bash(git status:*)
Bash(git diff:*)
Bash(git log:*)
Bash(git show:*)
Bash(git branch:*)
```
Same as Unix: Only read operations.

#### Package Manager Information
```
Bash(npm list:*)
Bash(npm outdated:*)
Bash(choco list:*)
```
Safe because: Query-only operations.

## Commands to AVOID Auto-Approving

### High-Risk Commands
Never auto-approve these without careful consideration:

```
# Dangerous - Can delete files
Bash(rm:*)
Bash(del:*)

# Dangerous - Can modify files
Bash(mv:*)
Bash(cp:*)

# Dangerous - Can change permissions
Bash(chmod:*)
Bash(chown:*)

# Dangerous - Can modify git history
Bash(git push:*)
Bash(git push --force:*)
Bash(git reset --hard:*)

# Dangerous - Can install software
Bash(npm install:*)
Bash(pip install:*)
Bash(apt install:*)
Bash(brew install:*)

# Dangerous - Executes arbitrary commands
# Note: pipe patterns (curl | sh) can't be expressed as deny rules,
# but Claude Code will prompt before running these commands
Bash(curl:*)
Bash(wget:*)
```

## Recommended Starter Configuration

For a typical development workflow, consider starting with:

### Minimal Safe Set
```
Bash(mkdir:*)
Bash(git status:*)
Bash(git diff:*)
Bash(git log:*)
Bash(npm test:*)
Bash(npm run build:*)
```

### Expanded Development Set
Add to the above:
```
Bash(ls:*)
Bash(pwd:*)
Bash(which:*)
Bash(git branch:*)
Bash(git show:*)
Bash(npm list:*)
Bash(npm outdated:*)
```

## Project-Specific Permissions

For specific project types, you might add:

### Node.js Projects
```
Bash(npm run lint:*)
Bash(npm run format:*)
Bash(npm run typecheck:*)
```

### Python Projects
```
Bash(pytest:*)
Bash(python -m pytest:*)
Bash(flake8:*)
Bash(black --check:*)
```

### Rust Projects
```
Bash(cargo build:*)
Bash(cargo test:*)
Bash(cargo check:*)
Bash(cargo clippy:*)
```

### Go Projects
```
Bash(go test:*)
Bash(go build:*)
Bash(go fmt:*)
Bash(go vet:*)
```

## Superpowers Plugin

If you're using the [superpowers](https://github.com/obra/superpowers) plugin alongside this template, no additional permissions are typically required. The plugin's skills, commands, and hooks work within Claude Code's existing permission model.

The plugin uses:
- Slash commands (`/brainstorm`, `/write-plan`, `/execute-plan`) - no special permissions needed
- Session hooks - managed by Claude Code's plugin system
- Skill tool invocations - handled internally

If you're developing custom skills that use external tools, you may need to add specific permissions for those tools.

See [superpowers-integration.md](superpowers-integration.md) for more details on using superpowers with this template.

## Gastown Multi-Agent Orchestration

If you're using [Gastown](https://github.com/steveyegge/gastown) for multi-agent orchestration, consider adding these permissions:

### Gastown CLI
```
Bash(gt:*)
```
Covers all `gt` subcommands including workspace management (`gt rig list`, `gt convoy show`), agent queries (`gt agents`), and orchestration (`gt sling`, `gt mayor attach`).

**Note:** Commands like `gt mayor attach` and `gt sling` spawn new Claude Code sessions, which consume API credits and system resources. Pre-approving `gt:*` is convenient but be aware of the cost implications of agent-spawning commands.

### Beads Issue Tracking
```
Bash(bd:*)
```
Covers beads commands for issue/work item management. Beads manages structured work items in git-backed storage.

### Go Runtime (Read-Only)
```
Bash(go version:*)
```
Safe because: Read-only system information to verify Go runtime availability.

See [gastown-integration.md](gastown-integration.md) for more details on using Gastown with this template.

## Best Practices

1. **Start Conservative**: Begin with minimal permissions and add more as needed
2. **Project-Specific**: Configure permissions per project, not globally
3. **Review Regularly**: Periodically review your permissions list
4. **Understand Commands**: Only approve commands you understand
5. **Test First**: Run commands manually before auto-approving them
6. **Consider CI/CD**: If it runs safely in CI, it's probably safe to auto-approve

## Notes

- Claude Code already has some built-in permissions like `mkdir:*` for specific patterns
- Permissions are case-sensitive
- Wildcards (`*`) match any arguments
- More specific patterns are safer than broad wildcards
