# Design Document: [Project Name]

> **Template Location**: `.claude/design/templates/DESIGN_DOCUMENT.md`
>
> **Recommended Model**: Opus (for deep reasoning during design)
>
> **See Also**:
> - `.claude/design/workflows/design-session.md` — Design process workflow
> - `.claude/architecture.md` — Final system architecture (update after design)
> - `docs/design/design-workflow-guide.md` — When to use design vs. implementation

---

## Document Status

| Field | Value |
|-------|-------|
| **Phase** | ⬜ Exploration ⬜ Requirements ⬜ Options ⬜ Deciding ⬜ Detailing ⬜ Finalizing |
| **Iteration** | 1 |
| **Last Updated** | YYYY-MM-DD |
| **Design Sessions** | [N sessions] |
| **Author(s)** | [Names] |
| **Reviewers** | [Names] |
| **Model Used** | Opus / Sonnet |

---

## 1. Problem Statement

### What Are We Solving?
<!--
Describe the problem in user/business terms, not technical terms.
Refine this over sessions - your first version is rarely complete.

Load: /load-design-phase exploration
-->

[Describe the problem here]

### Why Does This Matter?
<!--
What happens if we don't solve it? Who is affected?
-->

[Impact description]

### What's NOT In Scope?
<!--
Boundaries are as important as the problem itself.
-->

- [Out of scope item 1]
- [Out of scope item 2]

---

## 2. Requirements & Constraints

<!-- Load: /load-design-phase requirements -->

### Functional Requirements
<!-- What must the system DO? -->

| ID | Requirement | Priority | Status |
|----|-------------|----------|--------|
| FR-1 | [Requirement] | Must | ⬜ Confirmed ⬜ Assumed |
| FR-2 | [Requirement] | Should | ⬜ Confirmed ⬜ Assumed |
| FR-3 | [Requirement] | Could | ⬜ Confirmed ⬜ Assumed |

### Non-Functional Requirements
<!-- What must the system BE? (performance, security, etc.) -->

| ID | Requirement | Target | Status |
|----|-------------|--------|--------|
| NFR-1 | Throughput | [X] req/sec | ⬜ Confirmed ⬜ Assumed |
| NFR-2 | Latency (p99) | [X] ms | ⬜ Confirmed ⬜ Assumed |
| NFR-3 | Availability | [X]% | ⬜ Confirmed ⬜ Assumed |
| NFR-4 | Security | [Standards to meet] | ⬜ Confirmed ⬜ Assumed |
| NFR-5 | Scalability | [Scale targets] | ⬜ Confirmed ⬜ Assumed |

### Constraints
<!-- What must we work within? -->

| Constraint | Description | Negotiable? |
|------------|-------------|-------------|
| Technical | [e.g., Must deploy to existing EKS cluster] | No |
| Team | [e.g., Team knows Python, not Go] | No |
| Timeline | [e.g., MVP needed in 6 weeks] | Partially |
| Budget | [e.g., No new infrastructure costs] | Yes |
| Compliance | [e.g., Must be GDPR compliant] | No |

### Assumptions
<!-- What are we assuming to be true? Validate these! -->

| ID | Assumption | Risk if Wrong | Validated? |
|----|------------|---------------|------------|
| A-1 | [Assumption] | [What breaks] | ⬜ Yes ⬜ No |
| A-2 | [Assumption] | [What breaks] | ⬜ Yes ⬜ No |

**Validation strategy for unconfirmed assumptions**:
- [How to validate assumption A-1]
- [How to validate assumption A-2]

---

## 3. Open Questions

<!-- Load: /load-design-phase exploration -->

<!-- Questions that need answers before/during design -->

| ID | Question | Blocking? | Status |
|----|----------|-----------|--------|
| Q-1 | [Question] | Yes | ⬜ Open ⬜ Answered |
| Q-2 | [Question] | No | ⬜ Open ⬜ Answered |

### Answered Questions
<!-- Move questions here when answered -->

| ID | Question | Answer | Session |
|----|----------|--------|---------|
| Q-X | [Question] | [Answer] | [N] |

---

## 4. Decisions Made

<!-- Load: /load-design-phase decision -->

<!-- Link to ADRs or summarize key decisions -->

| ID | Decision | Choice | Rationale | ADR |
|----|----------|--------|-----------|-----|
| D-1 | [Topic] | [Choice] | [Brief why] | [ADR-001](../../adr/ADR-001-example.md) |
| D-2 | [Topic] | [Choice] | [Brief why] | — |

**Note**: Create ADRs using `.claude/design/templates/ADR_TEMPLATE.md` for significant decisions.

---

## 5. Options Under Consideration

<!-- Load: /load-design-phase options -->

<!-- For decisions not yet made -->

### [Decision Topic 1]

**Context**: [Why this decision is needed]

**Decision Drivers**:
1. [What's most important in this decision?]
2. [Second priority]
3. [Third priority]

#### Option A: [Name]
- **Description**: [What is it?]
- **Pros**:
  - [Pro 1]
  - [Pro 2]
- **Cons**:
  - [Con 1]
  - [Con 2]
- **When to choose**: [Conditions that favor this option]

#### Option B: [Name]
- **Description**: [What is it?]
- **Pros**:
  - [Pro 1]
  - [Pro 2]
- **Cons**:
  - [Con 1]
  - [Con 2]
- **When to choose**: [Conditions that favor this option]

#### Option C: [Name]
- **Description**: [What is it?]
- **Pros**:
  - [Pro 1]
  - [Pro 2]
- **Cons**:
  - [Con 1]
  - [Con 2]
- **When to choose**: [Conditions that favor this option]

**Current Lean**: [Option] because [reason]

**Blocking Question**: [What we need to answer to decide]

---

## 6. Architecture

<!-- Load: /load-design-phase detail -->

### High-Level Overview
<!--
Start with a simple diagram/description.
Add detail in later iterations.
This will eventually move to .claude/architecture.md when finalized.
-->

```
[Simple diagram or description using ASCII art or mermaid]

Example:
┌─────────────┐      ┌─────────────┐      ┌─────────────┐
│   Client    │─────>│   API       │─────>│  Database   │
└─────────────┘      └─────────────┘      └─────────────┘
                            │
                            v
                     ┌─────────────┐
                     │   Cache     │
                     └─────────────┘
```

### Components

| Component | Responsibility | Technology | Status |
|-----------|---------------|------------|--------|
| [Name] | [What it does] | [Tech choices] | ⬜ Designed ⬜ Detailed |

**Note**: After design is finalized, create module guides in `.claude/modules/` for major components.

### Data Flow
<!-- How does data move through the system? -->

```
[Data flow description or diagram]

Example:
1. User request → API Gateway
2. API Gateway → Authentication Service
3. Authenticated request → Business Logic
4. Business Logic → Database + Cache
5. Response → API Gateway → User
```

### Interfaces
<!-- How do components talk to each other? -->

| Interface | From | To | Protocol | Contract |
|-----------|------|-----|----------|----------|
| [Name] | [Component] | [Component] | [HTTP/gRPC/Queue/etc] | [Link to spec or describe] |

### Data Models
<!-- Key data structures -->

```typescript
// Example - use your project's language
interface User {
  id: string;
  email: string;
  // ...
}
```

---

## 7. Risks & Mitigations

<!-- Load: /load-design-phase validation -->

| ID | Risk | Likelihood | Impact | Mitigation | Status |
|----|------|------------|--------|------------|--------|
| R-1 | [Risk] | High/Med/Low | High/Med/Low | [Mitigation] | ⬜ Open ⬜ Mitigated ⬜ Accepted |
| R-2 | [Risk] | High/Med/Low | High/Med/Low | [Mitigation] | ⬜ Open ⬜ Mitigated ⬜ Accepted |

### Risk Categories

**Technical Risks**:
- [e.g., New technology with unknown performance characteristics]

**Operational Risks**:
- [e.g., Complex deployment process may cause downtime]

**Security Risks**:
- [e.g., Authentication bypass if token validation fails]

**Organizational Risks**:
- [e.g., Team lacks expertise in chosen technology]

---

## 8. Session Log

<!-- Track design evolution across sessions -->

### Session 1 — YYYY-MM-DD
**Phase**: [Exploration/Requirements/Options/Decision/Detail/Validation]

**Focus**: [What we discussed]

**Key Outcomes**:
- [Outcome 1]
- [Outcome 2]

**Decisions Made**:
- [Decision]: [Choice]

**Open Questions Identified**:
- [Question 1]

**Next Session Focus**: [Recommendation]

---

### Session 2 — YYYY-MM-DD
**Phase**: [Exploration/Requirements/Options/Decision/Detail/Validation]

**Focus**: [What we discussed]

**Key Outcomes**:
- [Outcome 1]

**Decisions Made**:
- [Decision]: [Choice]

**Questions Answered**:
- Q-1: [Answer]

**Next Session Focus**: [Recommendation]

---

## 9. Implementation Notes

<!-- Add as design solidifies -->

### Transition to Implementation

When design is validated:

- [ ] Run `/finalize-design` to verify completeness
- [ ] Create ADRs for all significant decisions
- [ ] Update `.claude/architecture.md` with finalized architecture
- [ ] Create/update module guides in `.claude/modules/`
- [ ] Run `/write-plan` (Superpowers) or create manual plan
- [ ] Load `/load-workflow feature-development` to begin implementation
- [ ] Switch model from Opus to Sonnet for implementation

### Implementation Phases

#### Phase 1: [Name]
- [ ] [Task 1]
- [ ] [Task 2]

#### Phase 2: [Name]
- [ ] [Task 1]
- [ ] [Task 2]

### Known Challenges
<!-- Things that will be tricky to implement -->

- **[Challenge 1]**: [Notes on approach]
- **[Challenge 2]**: [Notes on approach]

### Success Criteria

**Design is complete when**:
- [ ] Problem statement is validated
- [ ] All blocking questions are answered
- [ ] Major decisions have ADRs
- [ ] Architecture is detailed enough to implement
- [ ] Risks are identified with mitigation plans
- [ ] Team alignment achieved

**Implementation is successful when**:
- [ ] All functional requirements met
- [ ] Non-functional requirements validated (tests/benchmarks)
- [ ] Risks monitored and mitigations working
- [ ] Documentation updated (architecture.md, module guides)

---

## 10. Appendix

### Glossary
| Term | Definition |
|------|------------|
| [Term] | [Definition] |

### References

**External Resources**:
- [Research paper / Blog post / Documentation]

**Internal Documents**:
- [Link to related design doc]
- [Link to relevant ADR]

### Related Documents

**cc-bootstrap Documentation**:
- `.claude/architecture.md` — Current system architecture
- `.claude/modules/[module].md` — Existing module guides
- `.claude/workflows/feature-development.md` — Implementation workflow

**ADRs Created for This Design**:
- [ADR-001](../../adr/ADR-001-example.md) — [Decision title]

---

## Usage Tips

### Starting a New Design

1. Copy this template to `docs/design/[feature-name]-design.md`
2. Run `/start-design-session` to begin
3. Update document as you progress through phases
4. Create session notes using `.claude/design/templates/SESSION_NOTES.md`

### Multi-Session Designs

- Use Session Log section to track progress
- Create session notes at end of each session
- Prepare handoff context for next session
- Reference previous sessions when continuing

### Creating ADRs

When you make a significant decision:
1. Copy `.claude/design/templates/ADR_TEMPLATE.md`
2. Fill out all sections (especially rationale)
3. Save to `docs/adr/ADR-NNN-title.md`
4. Link from this design doc (Section 4: Decisions Made)
5. Link from `.claude/architecture.md` ADR Index

### Finalizing Design

Run `/finalize-design` to check:
- [ ] All sections are complete
- [ ] Decisions have ADRs
- [ ] Architecture.md needs updating
- [ ] Module guides need creating/updating
- [ ] Ready to transition to implementation
