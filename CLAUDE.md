# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

[Describe the purpose and scope of this project in 2-3 sentences]

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

## Architecture

[Describe the high-level architecture and key design decisions that aren't immediately obvious from reading individual files]

### Key Components

[Describe major components and how they interact]

### Project Structure

[Only include non-obvious structural decisions or patterns that span multiple directories]

## Important Conventions

[Document any project-specific conventions, patterns, or constraints that Claude should follow when modifying code]
- When making implementation plans, save new files in docs/planning/
- When performning analysis, save the analysis in docs/analysis/

## Optional Tools

### Git Configuration
For optimal git workflow with Claude Code, see [docs/git-setup.md](docs/git-setup.md) for recommended git configuration settings.

### GitHub CLI
For GitHub operations like creating pull requests and managing issues, Claude Code can use the GitHub CLI (`gh`). See [docs/gh-cli-setup.md](docs/gh-cli-setup.md) for setup instructions.

### Permissions
To streamline your workflow, you can pre-approve safe commands for Claude Code to run without prompting. See [docs/permissions-guide.md](docs/permissions-guide.md) for recommended low-risk permissions organized by platform.

- Once the user selects a language for the codebase, suggest appropriate linters and offer to install and configure git-hooks to use the linters
- For optimimum code development workflows, when possible use a TDD approach