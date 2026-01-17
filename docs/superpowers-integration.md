# Superpowers Integration Guide

This guide explains how to use the [superpowers](https://github.com/obra/superpowers) plugin alongside this Claude Code bootstrap template for enhanced AI-assisted development.

## Overview

**Superpowers** is a skills library by Jesse Vincent that provides disciplined development workflows for Claude Code. It complements this template:

| This Template | Superpowers |
|---------------|-------------|
| Provides WHAT Claude needs to know | Provides HOW Claude should work |
| Documentation structure & context | Development methodology & workflows |
| `/audit`, `/verify-context`, `/load-module` | `/brainstorm`, `/write-plan`, `/execute-plan` |
| Recommends TDD | Enforces TDD as "Iron Law" |

Together they create a complete development environment where Claude knows both what your project contains and how to work on it effectively.

## Installation

### Prerequisites

- Claude Code installed and working
- This bootstrap template configured for your project

### Install Superpowers

```bash
# Register the marketplace
/plugin marketplace add obra/superpowers-marketplace

# Install the plugin
/plugin install superpowers@superpowers-marketplace

# Verify installation
/help
# Should show: /superpowers:brainstorm, /superpowers:write-plan, /superpowers:execute-plan
```

### Update Superpowers

```bash
/plugin update superpowers
```

## How They Work Together

### Session Flow

1. **Session starts** → Superpowers activates skill checking
2. **User describes task** → Superpowers triggers brainstorming skill
3. **Design validated** → Load cc-bootstrap module context for project-specific info
4. **Implementation** → TDD enforced by superpowers, context from cc-bootstrap workflows/conventions

### Typical Workflow Example

```
User: I want to add OAuth support to the authentication system

# Superpowers takes over the HOW
Claude: [Activates brainstorming skill]
        Let me understand what you're trying to build...
        [Asks clarifying questions one at a time]
        [Presents design in digestible sections]
        [Saves design to docs/plans/]

User: Design looks good, let's implement

# CC-Bootstrap provides the WHAT
Claude: Before I start, let me load the project context.
        /load-module auth
        [Loads authentication module documentation]
        [Understands existing patterns, APIs, conventions]

# Both work together during implementation
Claude: [Creates git worktree per superpowers workflow]
        [Writes tests first per TDD Iron Law]
        [Follows cc-bootstrap code conventions]
        [Uses subagent-driven development]
        [Reviews against plan and conventions]
```

## When to Use Each

| Task | Tool | Command |
|------|------|---------|
| Understand existing patterns | CC-Bootstrap | `/load-module <name>` |
| Plan a new feature approach | Superpowers | `/brainstorm` |
| Check testing conventions | CC-Bootstrap | Load `.claude/conventions/testing.md` |
| Debug a complex issue | Superpowers | systematic-debugging skill |
| Run documentation audit | CC-Bootstrap | `/audit` |
| Execute implementation plan | Superpowers | `/execute-plan` |
| Verify loaded context | CC-Bootstrap | `/verify-context` |

## Superpowers Skills Reference

### Core Workflow Skills

| Skill | Purpose |
|-------|---------|
| **brainstorming** | Interactive design refinement through Socratic questioning |
| **writing-plans** | Creates detailed implementation plans with bite-sized tasks |
| **executing-plans** | Batch execution with human checkpoints |
| **subagent-driven-development** | Fresh subagent per task with two-stage review |

### Quality Skills

| Skill | Purpose |
|-------|---------|
| **test-driven-development** | Enforces RED-GREEN-REFACTOR cycle |
| **systematic-debugging** | 4-phase root cause analysis |
| **verification-before-completion** | Evidence-based completion claims |
| **requesting-code-review** | Pre-review checklist |

### Infrastructure Skills

| Skill | Purpose |
|-------|---------|
| **using-git-worktrees** | Parallel development branches |
| **finishing-a-development-branch** | Merge/PR decision workflow |
| **dispatching-parallel-agents** | Concurrent subagent workflows |

## Alignment Notes

### Plan Storage

Both systems use `docs/plans/` for storing implementation plans and designs. This ensures consistency when superpowers saves a design document that cc-bootstrap workflows reference later.

### TDD Approach

- **CC-Bootstrap**: Recommends TDD in workflows and conventions
- **Superpowers**: Enforces TDD as non-negotiable ("Iron Law")

When both are installed, superpowers' enforcement takes precedence, which strengthens the TDD practice already recommended by this template.

### Code Review

- **CC-Bootstrap**: Provides code review checklists in conventions
- **Superpowers**: Has two-stage review (spec compliance + code quality)

The superpowers review process complements cc-bootstrap's checklists by providing structured automation.

## Troubleshooting

### Commands Not Appearing

If superpowers commands don't appear in `/help`:

```bash
# Check if plugin is installed
/plugin list

# Reinstall if needed
/plugin uninstall superpowers
/plugin install superpowers@superpowers-marketplace
```

### Skill Not Activating

Superpowers skills activate automatically based on context. If a skill isn't triggering:

1. Be explicit: "I want to brainstorm a new feature"
2. Use the command directly: `/superpowers:brainstorm`
3. Reference the skill: "Use the systematic-debugging skill"

### Context Conflicts

If Claude seems confused about which approach to use:

1. Be explicit about what you want
2. Load specific context: `/load-module <name>`
3. Reference specific workflow: `/load-workflow feature-development`

## Resources

- **Superpowers Repository**: https://github.com/obra/superpowers
- **Superpowers Marketplace**: https://github.com/obra/superpowers-marketplace
- **Blog Post**: https://blog.fsck.com/2025/10/09/superpowers/
- **Issues**: https://github.com/obra/superpowers/issues

## License

Superpowers is MIT licensed (Copyright © 2025 Jesse Vincent), compatible with this template's MIT license. Both can be freely used, modified, and distributed together.
