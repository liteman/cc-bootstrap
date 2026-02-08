# Agent Team Development Workflow

> **When to read**: When using agent teams for feature development or any multi-agent coordination task.
> **Load with**: `/load-workflow agent-team-development`

## Overview

This workflow guides team-based development using Claude Code's native agent teams feature. The team lead coordinates specialized teammates to parallelize work across research, implementation, and review.

## Prerequisites

- Agent teams enabled (`CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` in `.claude/settings.json`)
- Custom subagents defined in `.claude/agents/`
- Project context populated in `CLAUDE.md` and `.claude/` docs

## Workflow Phases

### Phase 1: Planning (Team Lead — Solo)

1. Understand the feature requirements fully
2. Break work into parallelizable tasks with clear boundaries
3. Identify which subagent roles are needed (researcher, implementer, reviewer)
4. Create the shared task list with dependencies marked
5. Define acceptance criteria for each task

**Checklist:**
- [ ] Requirements are clear and scoped
- [ ] Tasks are independent where possible
- [ ] Each task has specific files/components listed
- [ ] Acceptance criteria defined per task

### Phase 2: Research (Researcher Teammate)

1. Toggle to delegate mode (`Shift+Tab`)
2. Spawn a researcher teammate for exploration tasks
3. Researcher reads codebase, finds patterns, identifies risks
4. Review researcher findings via mailbox messages
5. Refine task list based on discoveries

**When to use:**
- Unfamiliar code area — need orientation before implementation
- Multiple possible approaches — need data to decide
- Cross-cutting change — need to map all affected areas

**When to skip:**
- Well-understood codebase area
- Simple, isolated change
- Clear implementation path already known

### Phase 3: Implementation (Implementer Teammates)

1. Assign implementation tasks from the shared task list
2. Each implementer works on an independent subtask
3. Implementers follow the `feature-development` workflow
4. Monitor progress via task list status updates
5. Handle questions via mailbox messaging

**Best practices:**
- Assign one component/module per implementer to avoid conflicts
- Include relevant file paths in each task description
- Set explicit test requirements per task
- Have implementers run tests before marking tasks complete

### Phase 4: Review (Reviewer Teammate)

1. Spawn a reviewer teammate once implementation tasks complete
2. Reviewer checks conventions, tests, correctness
3. Review findings arrive via mailbox
4. Route fixes back to the relevant implementer
5. Iterate until review passes with no blocking issues

**Review categories:**
- **Blocking** — Must fix before merge (bugs, security, missing tests)
- **Suggestion** — Should fix, improves quality (naming, structure)
- **Nitpick** — Optional, style preference (formatting, comments)

### Phase 5: Integration (Team Lead — Solo)

1. Toggle back to solo mode (`Shift+Tab`)
2. Verify all tasks marked complete on the shared task list
3. Run full test suite across the project
4. Review git log for clean, focused commits
5. Final integration testing of the combined changes

**Checklist:**
- [ ] All tasks completed and reviewed
- [ ] Full test suite passes
- [ ] No merge conflicts between teammate work
- [ ] Commits follow git-workflow conventions
- [ ] Changes match original requirements

## Task List Best Practices

- Write self-contained task descriptions — each task should make sense without reading others
- Include relevant file paths so teammates can start immediately
- Specify acceptance criteria per task (what "done" looks like)
- Order tasks by dependency: independent tasks first, dependent tasks after
- Keep tasks small enough for one teammate to complete in a focused session

## Display Mode Selection

| Mode | Best For |
|------|----------|
| `in-process` | Quick 1-2 teammate tasks, any terminal |
| `tmux` | Multiple teammates, need visibility into parallel work |
| `auto` | Let Claude Code decide based on environment |

## Hook Integration

| Hook | Fires When | Use For |
|------|-----------|---------|
| `TeammateIdle` | Teammate finishes work | Validate output quality before reassigning |
| `TaskCompleted` | Task marked done | Enforce quality gates (exit code 2 blocks completion) |

## Common Team Patterns

### Research-then-Implement
1. Researcher explores → 2. Lead refines plan → 3. Implementers build

### Parallel Implementation
1. Lead breaks work into N independent tasks → 2. N implementers work simultaneously

### Implement-then-Review
1. Implementer builds → 2. Reviewer checks → 3. Implementer fixes → 4. Lead integrates

### Full Pipeline
1. Researcher explores → 2. Implementers build in parallel → 3. Reviewer validates → 4. Lead integrates

## Troubleshooting

### Teammate not picking up project context
- Verify `CLAUDE.md` exists at the project root
- Check that `.claude/agents/<name>.md` has valid YAML frontmatter
- Ensure the tools list in the frontmatter includes what the agent needs

### Task list not syncing between teammates
- Tasks are stored at `~/.claude/tasks/{team-name}/`
- Check team configuration at `~/.claude/teams/{team-name}/config.json`
- Verify all teammates are in the same team

### Teammates stepping on each other's work
- Assign teammates to separate files/modules
- Use the task list to track who owns which files
- Agent teams has built-in file locking — if conflicts occur, check task assignments
