# GitHub CLI Setup for Claude Code

Claude Code uses the GitHub CLI (`gh`) for operations like creating pull requests, managing issues, and interacting with GitHub repositories.

## Installation

### macOS
```bash
brew install gh
```

### Linux
```bash
# Debian/Ubuntu
sudo apt install gh

# Fedora/RHEL
sudo dnf install gh
```

### Windows
```bash
winget install --id GitHub.cli
```

Or download from: https://cli.github.com/

## Authentication

Authenticate with GitHub to allow Claude Code to perform repository operations:

```bash
gh auth login
```

Follow the prompts to:
1. Select GitHub.com (or GitHub Enterprise Server if applicable)
2. Choose HTTPS or SSH protocol
3. Authenticate via web browser or paste an authentication token

## Verify Setup

Check that authentication was successful:

```bash
gh auth status
```

You should see output indicating you're logged in to github.com.

## Required Permissions

For Claude Code to create pull requests and manage issues, ensure your authentication token has these scopes:
- `repo` (full control of private repositories)
- `workflow` (if you need to work with GitHub Actions)

## Common Usage with Claude Code

When you ask Claude Code to create a pull request, it will use `gh pr create` automatically. The setup above ensures this works seamlessly.

Example commands Claude Code may run:
```bash
gh pr create --title "..." --body "..."
gh pr list
gh pr view <number>
gh issue list
```
