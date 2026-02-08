# Git Configuration for Claude Code

This guide covers git configuration settings that optimize your workflow when using Claude Code.

## Essential Configuration

### User Identity

Set your name and email - these will appear as the primary author on commits created by Claude Code:

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

Claude Code adds a co-author tag to commits, so your identity remains as the primary author.

### Default Branch Name

Set a consistent default branch name for new repositories:

```bash
git config --global init.defaultBranch main
```

## Recommended Settings

### Pull Behavior

Configure pull to use rebase by default to maintain cleaner history:

```bash
git config --global pull.rebase true
```

Or if you prefer merge:

```bash
git config --global pull.rebase false
```

### Line Endings

For cross-platform projects, configure line ending handling:

```bash
# macOS/Linux
git config --global core.autocrlf input

# Windows
git config --global core.autocrlf true
```

### Push Behavior

Configure push to only push the current branch:

```bash
git config --global push.default current
```

## Optional Configurations

### GPG Commit Signing

If you sign commits, Claude Code will respect your GPG configuration:

```bash
git config --global user.signingkey <your-gpg-key-id>
git config --global commit.gpgsign true
```

### Git Hooks

Claude Code respects git hooks and does NOT use `--no-verify`. This means:
- Pre-commit hooks will run and can modify files (e.g., formatters, linters)
- Commit-msg hooks will validate commit messages
- If hooks fail, the commit will be rejected

This is beneficial for maintaining code quality. Ensure your hooks:
- Run quickly (< 5 seconds ideally)
- Provide clear error messages when they fail
- Auto-fix issues when possible (Claude can amend commits with hook changes)

Popular hook frameworks that work well with Claude Code:
- [Husky](https://typicode.github.io/husky/) for Node.js projects
- [pre-commit](https://pre-commit.com/) for Python and multi-language projects

### Useful Aliases

Add helpful git aliases:

```bash
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.last 'log -1 HEAD'
git config --global alias.unstage 'reset HEAD --'
```

## Repository-Specific Settings

For project-specific configurations, omit `--global` to set local config:

```bash
# Example: Use a different email for work projects
git config user.email "work.email@company.com"
```

## Verification

Check your configuration:

```bash
# View all configuration
git config --list

# View specific setting
git config user.name
git config user.email
```

## How Claude Code Uses Git

Understanding Claude's git workflow:
- **Commits**: Uses `git commit -m` with heredoc for multi-line messages
- **Co-authoring**: Adds `Co-Authored-By: Claude <noreply@anthropic.com>` to commits
- **Hooks**: Respects all git hooks; never uses `--no-verify`
- **Amending**: Only amends when safe (not pushed, same author, or when adding pre-commit hook changes)
- **Push**: Only pushes when explicitly requested by the user
- **Branch creation**: Can create and switch branches as needed
