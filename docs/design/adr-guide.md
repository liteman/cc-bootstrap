# ADR Best Practices Guide

How to write effective Architecture Decision Records (ADRs).

---

## When to Create an ADR

Create an ADR when a decision:
- [ ] Has significant impact on system structure
- [ ] Involved evaluation of multiple options
- [ ] Has meaningful reversal cost
- [ ] Will make future developers ask "why?"
- [ ] Affects multiple modules
- [ ] Establishes a pattern to follow

**Don't create ADRs for**:
- Trivial implementation details
- Obvious choices with no alternatives
- Easily reversible decisions

---

## ADR Template

Use: `.claude/design/templates/ADR_TEMPLATE.md`

Save to: `docs/adr/ADR-NNN-short-title.md`

---

## Writing Good ADRs

### Good Context Section

✅ **Do**: Explain the situation requiring a decision
```
We need to store user session data. Current approach (in-memory)
fails when server restarts, causing user logout. We expect 10K
concurrent users by Q4, requiring persistent session storage.
```

❌ **Don't**: Jump to solution
```
We need Redis for sessions.
```

### Good Options Section

✅ **Do**: Present 3+ options with specific pros/cons
```
Option A: Redis
- Pro: Fast (<5ms latency), mature, team knows it
- Con: Additional infrastructure, single point of failure

Option B: PostgreSQL sessions table
- Pro: Already have PostgreSQL, transactional consistency
- Con: Slower (20-50ms latency), doesn't scale as well

Option C: JWT tokens (stateless)
- Pro: No server-side storage, infinite horizontal scale
- Con: Can't invalidate tokens, larger payload size
```

❌ **Don't**: List vague pros/cons
```
Option A: Fast and reliable
Option B: Simpler
Option C: More flexible
```

### Good Rationale Section

✅ **Do**: Tie to decision drivers
```
We chose Redis because:
1. Speed: <5ms latency meets our <10ms session lookup requirement
2. Team familiarity: Team has Redis experience (Decision Driver #1)
3. Scale: Handles expected 10K concurrent users easily

We did NOT choose PostgreSQL because latency doesn't meet requirement.
We did NOT choose JWT because we need ability to invalidate sessions.
```

❌ **Don't**: Provide no rationale
```
We chose Redis because it's better.
```

### Good Consequences Section

✅ **Do**: List both positive AND negative
```
Positive:
- Session lookups will be <5ms
- Easy to scale horizontally

Negative:
- Additional operational complexity (Redis cluster management)
- New infrastructure cost (~$50/month)
- Potential data loss if Redis crashes (need persistence)
```

❌ **Don't**: Only list positives
```
Everything will be faster and better!
```

---

## ADR Workflow

1. **During design session**: Identify decision that needs ADR
2. **During decision phase**: Copy ADR template
3. **Immediately after deciding**: Fill out ADR while rationale is fresh
4. **Save**: To `docs/adr/ADR-NNN-title.md`
5. **Link**: From design document and architecture.md
6. **Review**: Have teammate review before implementing

**Don't wait!** Create ADRs immediately after decisions.

---

## ADR Numbering

- **Format**: `ADR-001-title.md`, `ADR-002-title.md`, etc.
- **Zero-padded**: Use 3 digits (001, not 1)
- **Sequential**: Number in order created
- **Never reuse**: If ADR is superseded, create new number

---

## ADR Status Lifecycle

**Proposed** → **Accepted** → **Deprecated** / **Superseded**

- **Proposed**: Under discussion
- **Accepted**: Decision made and implemented
- **Deprecated**: No longer recommended, but still in use
- **Superseded**: Replaced by newer ADR (link to replacement)

---

## Linking ADRs

### In architecture.md

Add to ADR Index table:

| ADR | Title | Status | Date | Modules |
|-----|-------|--------|------|---------|
| [ADR-001](adr/ADR-001-redis-sessions.md) | Redis for Sessions | Accepted | 2026-01-15 | Auth, API Gateway |

### In Design Documents

Reference in Decisions table:

| Decision | Choice | Rationale | ADR |
|----------|--------|-----------|-----|
| Session storage | Redis | Speed, scale | [ADR-001](../adr/ADR-001-redis-sessions.md) |

### Between ADRs

```
Related Decisions:
- ADR-002: Builds on this decision
- ADR-010: Contradicts this (supersedes it)
```

---

## Common Mistakes

### Mistake 1: Generic Trade-offs

❌ **Bad**: "More flexible, easier to use"

✅ **Good**: "Allows schema changes without migrations (flexible for evolving data model), but requires learning MongoDB query language (training cost)"

### Mistake 2: Hidden Bias

❌ **Bad**: Only presenting option you want

✅ **Good**: Presenting 3+ viable options neutrally

### Mistake 3: Missing Reversibility

❌ **Bad**: No discussion of how hard to change

✅ **Good**: "Migration from Redis to PostgreSQL would require 2-3 days (moderate difficulty). Migration cost is acceptable given benefits."

---

## Review Checklist

Before finalizing ADR:

- [ ] Context explains WHY decision needed
- [ ] At least 3 options presented
- [ ] Pros/cons are specific, not generic
- [ ] Decision clearly stated
- [ ] Rationale ties to decision drivers
- [ ] Both positive AND negative consequences listed
- [ ] Reversibility assessed
- [ ] Success criteria defined
- [ ] Links to related ADRs included

---

## Examples

See `.claude/design/templates/ADR_TEMPLATE.md` for full template.

For examples, create your first few ADRs and they become examples for future ones.

---

## Further Reading

- [ADR GitHub Organization](https://adr.github.io/)
- [Michael Nygard's ADR article](http://thinkrelevance.com/blog/2011/11/15/documenting-architecture-decisions)
