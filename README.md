# Claude Code Bootstrap Template

A starter template for projects using [Claude Code](https://claude.ai/code), pre-configured with documentation and best practices for optimal AI-assisted development.

## What's Included

This template provides:

- **CLAUDE.md** - Primary guidance file for Claude Code when working in this repository
- **Setup Guides** - Documentation for git configuration, GitHub CLI, and permissions
- **Best Practices** - Recommended workflows and conventions for Claude Code

## Quick Start

```bash
# Use this template on GitHub or clone it
git clone <repository-url> my-project
cd my-project

# Start Claude Code and try:
# "Initialize a TypeScript Node.js project with Jest and ESLint.
#  Set up TDD workflow with watch mode for tests."
```

## Getting Started

### 1. Clone or Use This Template

```bash
# Clone this template
git clone <repository-url>
cd cc-bootstrap

# Or create a new repository from this template on GitHub
```

### 2. Initialize Your Project

Start Claude Code and use one of the prompts below to begin setting up your project.

### 3. Customize CLAUDE.md

Update `CLAUDE.md` with your project-specific information as you develop.

## Useful Starter Prompts

When starting a new project with Claude Code, try these prompts:

### Project Initialization

```
Initialize a [language/framework] project with a standard structure.
Set up package management, create a basic Hello World example,
and configure appropriate linting and formatting tools.
```

Examples:
- "Initialize a TypeScript Node.js project with ESLint and Prettier"
- "Initialize a Python project with Poetry, pytest, and Black"
- "Initialize a Rust project with standard Cargo structure"
- "Initialize a Next.js project with TypeScript and Tailwind CSS"

### Testing Setup

```
Set up a testing framework for this project with:
- Unit test structure and example tests
- Test running scripts (normal and watch mode)
- Code coverage reporting
- TDD-friendly workflow
Then update CLAUDE.md with the testing commands.
```

### Test-Driven Development (TDD)

```
I want to add [feature description] using TDD. Please:
1. Write failing tests that define the expected behavior
2. Show me the test failures
3. Implement the minimal code to make tests pass
4. Refactor if needed while keeping tests green
5. Run the full test suite to ensure nothing broke
```

Example:
```
I want to add a user authentication module using TDD.
Start by writing tests for login validation, then implement it.
```

### Git and GitHub Setup

```
Initialize git in this repository and set up:
- Appropriate .gitignore for [language/framework]
- Pre-commit hooks for linting and formatting
- GitHub Actions workflow for CI
Then create an initial commit.
```

### Documentation

```
Analyze the current project structure and update CLAUDE.md with:
- Accurate development commands (build, test, lint)
- High-level architecture overview
- Key components and their interactions
```

### Code Quality

```
Set up code quality tools for this [language] project including:
- Linter with recommended rules
- Code formatter
- Pre-commit hooks to run these automatically
- Git hooks configuration
Configure these and update CLAUDE.md with the commands.
```

### CI/CD Pipeline

```
Create a GitHub Actions workflow that:
- Runs on pull requests and pushes to main
- Installs dependencies
- Runs linting
- Runs tests
- Reports coverage
Explain the workflow after creating it.
```

### Understanding Existing Code

If you're adding Claude Code to an existing project:

```
Analyze this codebase and create a comprehensive CLAUDE.md that includes:
- Project overview and purpose
- Development commands (build, test, lint)
- Architecture and key components
- Important conventions and patterns
- Any non-obvious structural decisions
```

### Creating Features

```
I want to add [feature description]. First:
1. Analyze the current architecture
2. Propose an implementation approach
3. Ask any clarifying questions
4. Then implement it using TDD (tests first, then implementation)
```

Or for quick iterations:
```
Add [feature] with comprehensive tests. Use TDD approach where practical.
```

### Exploring Options

When you need to make architectural or implementation decisions:

```
I need to [add feature/solve problem/refactor code].
Please suggest 3-5 different approaches with:
- Brief description of each approach
- Pros and cons
- Complexity estimate
- Your recommendation

Then I'll choose one and we can implement it.
```

Examples:
```
I need to add user authentication. Suggest 3-5 approaches
(JWT, sessions, OAuth, etc.) with pros/cons for each.
```

```
We're having performance issues with [component].
Suggest 3-5 optimization strategies with trade-offs.
```

```
I need to refactor the data layer. Propose 3-5 architectural
patterns we could use and recommend the best fit.
```

## Common Development Workflows

### Adding a New Feature (TDD Approach)
```
I want to add [feature]. Using TDD:
1. First write comprehensive tests for the expected behavior
2. Run tests to confirm they fail
3. Implement the feature to make tests pass
4. Refactor for code quality
5. Update CLAUDE.md if architecture changed
6. Create a git commit with descriptive message
```

### Debugging an Issue
```
There's a bug: [describe the issue]. Please:
1. Write a test that reproduces the bug
2. Analyze the code to find the root cause
3. Fix the bug
4. Verify the test now passes
5. Run full test suite to ensure no regressions
```

For complex issues:
```
We have a problem: [describe issue and symptoms].
Suggest 3-5 possible root causes with:
- How to verify each hypothesis
- Potential fixes
- Impact assessment
Then we'll investigate the most likely causes.
```

### Refactoring Code
```
The [component/module] needs refactoring because [reason]. Please:
1. First ensure there are tests covering current behavior
2. Propose a refactoring approach
3. Refactor incrementally, keeping tests green
4. Improve test coverage if needed
```

### Code Review Preparation
```
I'm ready to create a PR. Please:
1. Run the full test suite
2. Run linting and fix any issues
3. Check for any console.log or debug code
4. Review the git diff for any unintended changes
5. Create a PR with a clear description of changes
```

## Documentation

- **[CLAUDE.md](CLAUDE.md)** - Main guidance for Claude Code
- **[Git Setup Guide](docs/git-setup.md)** - Recommended git configuration
- **[GitHub CLI Setup](docs/gh-cli-setup.md)** - Configure gh CLI for PR creation
- **[Permissions Guide](docs/permissions-guide.md)** - Safe commands to pre-approve

### Documentation Structure

This template uses a structured documentation approach:
- `docs/` - General documentation and guides
- `docs/planning/` - Implementation plans and design documents
- `docs/analysis/` - Code analysis and architecture documentation

Claude Code will automatically save planning documents and analysis to these directories when working on complex tasks.

## Tips for Working with Claude Code

1. **Be Specific**: Clear, detailed prompts yield better results
2. **Use TDD**: Request test-driven development for better code quality and design
3. **Get Options**: Ask for 3-5 suggestions when facing decisions - better choices come from comparing alternatives
4. **Iterate**: Start with planning, then implement incrementally
5. **Use CLAUDE.md**: Keep it updated so Claude understands your project
6. **Leverage Git**: Claude can create commits and PRs - use it!
7. **Trust the Process**: Claude respects git hooks and follows best practices
8. **Watch Mode**: Ask Claude to set up test watch mode for rapid TDD cycles
9. **Ask Questions**: Claude can ask clarifying questions - encourage it!

## Customization

After using this template:

1. Update `CLAUDE.md` with your project specifics
2. Remove placeholder sections that don't apply
3. Add project-specific conventions and patterns
4. Configure permissions for your workflow
5. Update this README with project-specific information

## Contributing

[Add contribution guidelines for your project]

## License

[Add your license information]
