Transition from design to implementation.

1. Check for design documents in `docs/design/` - verify one exists and assess completeness
2. Review any ADR files in `docs/adr/` and identify decisions that still need ADRs
3. Read `.claude/architecture.md` and identify sections that need updating based on the design
4. Suggest the transition to implementation workflow

Respond with:

```
Design finalization checklist:

Design Document: [Found | Not found]
- Phase: [Current phase]
- Completeness: [Assessment]

ADRs to create:
- [ ] [Decision 1]
- [ ] [Decision 2]

Architecture updates needed:
- [ ] [Update needed 1]
- [ ] [Update needed 2]

Ready to implement?
1. Create ADRs listed above
2. Update .claude/architecture.md
3. Run: /load-workflow feature-development
4. Switch to Sonnet model for implementation
```
