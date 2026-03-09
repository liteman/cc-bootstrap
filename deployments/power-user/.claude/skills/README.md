# Skills Directory

Place custom Claude Code skills here. Each skill gets its own subdirectory with a `SKILL.md` file.

## Structure

```
skills/
├── {skill-name}/
│   └── SKILL.md    # Skill definition with YAML frontmatter
└── README.md       # This file
```

## Creating a Skill

A skill is a markdown file with YAML frontmatter that defines when and how it should be triggered:

```yaml
---
name: my-skill
description: >
  Brief description of what this skill does and when to trigger it.
  Include keywords that should activate it.
---

# Skill Title

Instructions for Claude when this skill is active...
```

## Examples

- **Documentation audit**: Scan project docs for staleness, gaps, and inconsistencies
- **Prompt injection defense**: Harden sessions against injection attacks in untrusted data
- **Security review**: Focused security audit with structured findings

See the kitchen-sink deployment for a complete audit skill example.
