# Claude Code Bootstrap — Beginner

Get Claude Code working effectively in your project with just **two files** and **five minutes**.

## What You'll Set Up

```
your-project/
├── CLAUDE.md                       # Project context for Claude Code
└── .claude/
    └── settings.local.json         # Safe permission defaults
```

These two files give Claude Code the context it needs to understand your project and the permissions to run your standard tools without asking every time.

## Quick Start

### Option A: Use the setup script

```bash
# From inside cc-bootstrap/deployments/beginner/
./setup.sh /path/to/your-project
```

The script copies the template files into your project and walks you through customization.

### Option B: Manual setup

1. Copy `CLAUDE.md.template` to your project root as `CLAUDE.md`
2. Copy `.claude/settings.local.json` to your project's `.claude/` directory
3. Replace the `[BRACKETED]` placeholders with your project details

### Option C: Let Claude generate it

Start a Claude Code session in your project and use this prompt:

```
Analyze this project and create a CLAUDE.md file in the project root.
Include: a one-sentence project description, the tech stack, the commands
to install dependencies / run the dev server / run tests / lint / build,
the key directories with short descriptions, and 2-3 critical rules
for working in this codebase.
```

## CLAUDE.md — Tell Claude About Your Project

`CLAUDE.md` is the first file Claude Code reads when it starts a session. It tells Claude what your project is, how to build and test it, and what rules to follow. See `CLAUDE.md.template` for the full template.

**Key sections:**
- **Project Overview** — Tech stack and one-sentence description
- **Commands** — How to install, build, test, lint
- **Project Structure** — Key directories and their purpose
- **Critical Rules** — Constraints Claude must follow

Be specific — the more accurate this file is, the better Claude Code performs.

## settings.local.json — Safe Permission Defaults

Pre-approve common safe commands so Claude Code doesn't ask for permission on every build or test run. See `.claude/settings.local.json` for the defaults.

Adjust the `allow` list to match your project's toolchain:
- **Node.js**: `Bash(npm run:*)`, `Bash(npx:*)`
- **Python**: `Bash(python:*)`, `Bash(pip:*)`
- **Rust**: `Bash(cargo:*)`
- **Go**: `Bash(go:*)`

The `deny` list blocks commands you never want Claude to run without asking.

## Validate Your Setup

After creating both files, start Claude Code and try:

```
Read CLAUDE.md and confirm you understand the project. Then run the
test suite and tell me if anything fails. If tests pass, summarize
the project structure in your own words.
```

## What This Enables

- **Understand your project** — tech stack, structure, and conventions from `CLAUDE.md`
- **Run your tools** — build, test, and lint without permission prompts
- **Follow your rules** — critical constraints are front-and-center every session
- **Stay safe** — denied commands require explicit approval

## Next Level

When you're ready for structured workflows, conventions, and on-demand documentation, see the **intermediate** deployment in `../intermediate/`.
