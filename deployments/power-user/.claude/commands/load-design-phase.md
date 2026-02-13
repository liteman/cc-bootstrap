Load a specific design phase workflow.

Read these files:
1. `.claude/design/workflows/$ARGUMENTS-phase.md`
2. `.claude/design/conventions/design-thinking.md`

If the phase file does not exist, list the available phases: exploration, requirements, options, decision, detail, validation.

After reading, respond with:

```
Phase loaded: [Phase Name]

Goal: [Phase goal from the workflow]
Duration: [Typical duration]
Key prompts: [list key prompts from the workflow]

Loaded:
- [Phase] phase workflow
- Design thinking conventions

Ready to begin [phase]. [Contextual question to start the phase]
```

Enter phase-specific behavior mode as described in the loaded workflow.
