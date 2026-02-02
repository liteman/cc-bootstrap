# ADR-[NNN]: [Short Title of Decision]

> **Template Location**: `.claude/design/templates/ADR_TEMPLATE.md`
>
> **Architecture Impact**: Link to `.claude/architecture.md` section affected
>
> **Related Workflows**: Design Decision Phase, Feature Development
>
> **Purpose**: Architecture Decision Records (ADRs) document significant technical decisions with their context, alternatives, and rationale. Future developers (including your future self) will thank you.

---

## Metadata

| Field | Value |
|-------|-------|
| **Status** | ⬜ Proposed ⬜ Accepted ⬜ Deprecated ⬜ Superseded |
| **Superseded By** | [ADR-XXX] (if applicable) |
| **Date Proposed** | YYYY-MM-DD |
| **Date Decided** | YYYY-MM-DD |
| **Decision Makers** | [Names] |
| **Consulted** | [Names] |
| **Modules Affected** | [List modules from .claude/modules/] |

---

## Context

<!--
What is the situation that requires a decision?
What forces are at play? What constraints exist?
Keep this factual and neutral.

Tip: Reference the design document that led to this decision
-->

[Describe the context here]

### Problem Being Solved

[What specific problem does this decision address?]

### Relevant Constraints

- **Technical**: [e.g., Must work with existing PostgreSQL infrastructure]
- **Team**: [e.g., Team has no experience with technology X]
- **Timeline**: [e.g., Must ship in 2 weeks]
- **Budget**: [e.g., Cannot exceed current infrastructure costs]
- **Compliance**: [e.g., Must be SOC2 compliant]

### Related Decisions

- [ADR-XXX](ADR-XXX-title.md): [How it relates]
- See `.claude/architecture.md` section [X] for current architecture

---

## Decision Drivers

<!-- What factors are most important in making this decision? -->

Prioritized by importance:

1. **[Driver 1]** — [e.g., "Team familiarity with technology"]
2. **[Driver 2]** — [e.g., "Operational simplicity"]
3. **[Driver 3]** — [e.g., "Cost at expected scale"]
4. **[Driver 4]** — [e.g., "Alignment with existing infrastructure"]

**Note**: Rationale section must tie back to these drivers.

---

## Options Considered

<!--
Present at least 3 options unless genuinely impossible.
Use /load-design-phase options for guidance on neutral presentation.
-->

### Option 1: [Name]

**Description**: [What is this option? 2-3 sentences]

**Pros**:
- [Pro 1 - be specific]
- [Pro 2]
- [Pro 3]

**Cons**:
- [Con 1 - be honest]
- [Con 2]
- [Con 3]

**Estimated Effort**: ⬜ Low ⬜ Medium ⬜ High

**Technical Risks**:
- [Risk 1]
- [Risk 2]

**Best suited for**: [Conditions that would make this the right choice]

---

### Option 2: [Name]

**Description**: [What is this option? 2-3 sentences]

**Pros**:
- [Pro 1]
- [Pro 2]
- [Pro 3]

**Cons**:
- [Con 1]
- [Con 2]
- [Con 3]

**Estimated Effort**: ⬜ Low ⬜ Medium ⬜ High

**Technical Risks**:
- [Risk 1]
- [Risk 2]

**Best suited for**: [Conditions that would make this the right choice]

---

### Option 3: [Name]

**Description**: [What is this option? 2-3 sentences]

**Pros**:
- [Pro 1]
- [Pro 2]
- [Pro 3]

**Cons**:
- [Con 1]
- [Con 2]
- [Con 3]

**Estimated Effort**: ⬜ Low ⬜ Medium ⬜ High

**Technical Risks**:
- [Risk 1]
- [Risk 2]

**Best suited for**: [Conditions that would make this the right choice]

---

## Decision

<!--
State the decision clearly and unambiguously.
This should be copy-paste clear for someone implementing it.
-->

**We have decided to use [Option X]: [Name].**

---

## Rationale

<!--
Why this option over the others? Be specific.
Reference the decision drivers explicitly.
Future readers should understand your reasoning without needing to ask.
-->

We chose **[Option X]** because:

1. **[Reason 1]** — Ties to Decision Driver #1: [driver name]
   - [Specific evidence or reasoning]

2. **[Reason 2]** — Ties to Decision Driver #2: [driver name]
   - [Specific evidence or reasoning]

3. **[Reason 3]** — Ties to Decision Driver #3: [driver name]
   - [Specific evidence or reasoning]

### Why Not Option 2: [Name]?

- [Specific reason tied to decision drivers]
- [What this option failed to provide]

### Why Not Option 3: [Name]?

- [Specific reason tied to decision drivers]
- [What this option failed to provide]

---

## Consequences

### Positive
<!-- What becomes easier or better? -->

- [Positive consequence 1 - be specific about impact]
- [Positive consequence 2]
- [Positive consequence 3]

### Negative
<!-- What becomes harder or worse? What are we accepting? BE HONEST. -->

- [Negative consequence 1 - don't hide trade-offs]
- [Negative consequence 2]
- [Negative consequence 3]

### Neutral
<!-- Other effects that aren't clearly good or bad -->

- [Neutral consequence - e.g., "Changes our build process but not necessarily better/worse"]

---

## Implications

### What We're Committing To

<!-- What does this decision lock in? -->

- [Commitment 1 - e.g., "Using PostgreSQL for all new services"]
- [Commitment 2 - e.g., "Maintaining backward compatibility with v1 API"]

### What We're Giving Up

<!-- What options are we closing off? -->

- [Closed option 1 - e.g., "Cannot easily switch to NoSQL without rewrite"]
- [Closed option 2 - e.g., "Foregoing potential performance gains of Option 2"]

### Follow-up Actions Required

<!-- What needs to happen as a result of this decision? -->

#### Documentation Updates
- [ ] Update `.claude/architecture.md` section [X]
- [ ] Create/update `.claude/modules/[module].md` for affected modules
- [ ] Link this ADR in ADR Index table in architecture.md

#### Technical Tasks
- [ ] [Technical task 1 - e.g., "Provision PostgreSQL instance"]
- [ ] [Technical task 2 - e.g., "Migrate existing data"]
- [ ] [Technical task 3 - e.g., "Update deployment pipeline"]

#### Team Actions
- [ ] [Team action 1 - e.g., "Train team on new technology"]
- [ ] [Team action 2 - e.g., "Update coding standards"]

---

## Reversibility

<!--
How hard would it be to change this decision later?
Be realistic - helps with risk assessment.
-->

**Reversibility**: ⬜ Easy ⬜ Moderate ⬜ Difficult ⬜ Very Difficult

### To Reverse This Decision

**We would need to**:
1. [Step 1 - e.g., "Migrate all data from PostgreSQL to new database"]
2. [Step 2 - e.g., "Rewrite data access layer"]
3. [Step 3 - e.g., "Test all existing functionality"]
4. [Step 4 - e.g., "Coordinate deployment across all services"]

**Estimated cost of reversal**: ⬜ Low ⬜ Medium ⬜ High ⬜ Very High

**Why it's [easy/moderate/difficult]**:
[Explain what makes this decision easy or hard to reverse]

---

## Implementation Notes

<!-- Practical guidance for implementation -->

### Critical Files/Modules

**Files to change**:
- [Path to file 1]
- [Path to file 2]

**Modules affected** (see `.claude/modules/`):
- [Module 1]
- [Module 2]

### Migration Path

**For new code**:
- [How to apply this decision in new features]

**For existing code**:
- [ ] [Migration step 1]
- [ ] [Migration step 2]

### Configuration Changes

```yaml
# Example configuration reflecting this decision
setting: value
```

### Monitoring/Validation

**Metrics to watch post-implementation**:
- [Metric 1 - e.g., "Query latency p99"]
- [Metric 2 - e.g., "Error rate"]

**Success indicators**:
- [Indicator 1]
- [Indicator 2]

---

## Validation

<!-- How will we know if this was the right decision? -->

### Success Criteria

**This decision is successful if**:
- [ ] [Criterion 1 - measurable]
- [ ] [Criterion 2 - measurable]
- [ ] [Criterion 3 - measurable]

**Measurement approach**:
- [How to measure criterion 1]
- [How to measure criterion 2]

### When to Re-evaluate

**This decision should be revisited if**:
- [Condition 1 - e.g., "Traffic exceeds 10M requests/day"]
- [Condition 2 - e.g., "Team size grows beyond 50 engineers"]
- [Condition 3 - e.g., "New technology emerges that addresses our main cons"]

**Review schedule**: [e.g., "Quarterly" or "After 6 months" or "When condition X occurs"]

---

## References

### Design Documentation

- **Design Doc**: [Link to design doc in docs/design/]
- **Session Notes**: [Link to session notes from decision phase]

### External Resources

- [Link to technology documentation]
- [Link to relevant blog post or paper]
- [Link to benchmark or comparison]

### Related ADRs

- [ADR-XXX](ADR-XXX-title.md): [Relationship - builds on / contradicts / complements]

### cc-bootstrap Integration

- **Architecture**: `.claude/architecture.md` section [X]
- **Affected Modules**: `.claude/modules/[module].md`
- **Conventions**: `.claude/conventions/[convention].md` (if decision impacts coding standards)

---

## Changelog

| Date | Author | Change | Status Change |
|------|--------|--------|---------------|
| YYYY-MM-DD | [Name] | Initial proposal | → Proposed |
| YYYY-MM-DD | [Name] | Updated based on feedback | Proposed |
| YYYY-MM-DD | [Name] | Decision accepted | → Accepted |

---

## Usage Guide

### When to Create an ADR

Create an ADR when a decision:
- [ ] Has significant impact on system structure
- [ ] Involved evaluation of multiple viable options
- [ ] Has meaningful reversal cost
- [ ] Will make future developers ask "why did we do it this way?"
- [ ] Affects multiple modules or cross-cutting concerns
- [ ] Establishes a pattern others should follow

### ADR Workflow

1. **During design**: Use `/load-design-phase options` to explore alternatives
2. **Make decision**: Use `/load-design-phase decision` for evaluation
3. **Create ADR**: Copy this template immediately (don't wait)
4. **Fill out**: Complete all sections, especially rationale
5. **Save**: To `docs/adr/ADR-NNN-title.md`
6. **Link**: From design document and architecture.md
7. **Implement**: Use as reference during implementation

### Writing Tips

**Good rationale**:
- Ties explicitly to decision drivers
- Explains why alternatives were rejected
- Includes specific evidence or data

**Bad rationale**:
- "Option X is better"
- "Industry best practice"
- "I like it more"

**Good consequences**:
- Specific and measurable
- Includes both positive AND negative
- Honest about trade-offs

**Bad consequences**:
- Only lists positives
- Vague generalizations
- Hides downsides
