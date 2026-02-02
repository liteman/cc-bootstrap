# Session Notes: [Project Name]

## Session [N] — YYYY-MM-DD

> **Template Location**: `.claude/design/templates/SESSION_NOTES.md`
>
> **Purpose**: Capture session outcomes and prepare handoffs for multi-session designs
>
> **When to use**: At end of each design session

---

## Session Overview

| Field | Value |
|-------|-------|
| **Project** | [Project name] |
| **Session Number** | [N] |
| **Date** | YYYY-MM-DD |
| **Duration** | [Approximate time] |
| **Phase** | ⬜ Exploration ⬜ Requirements ⬜ Options ⬜ Deciding ⬜ Detailing ⬜ Validation |
| **Model Used** | Opus / Sonnet / Haiku |
| **Participants** | [Names/tools used] |

---

## Session Focus

**Planned Focus**: [What we intended to cover]

**Actual Focus**: [What we actually covered — may differ from plan]

**Deviation Reason** (if different): [Why we pivoted]

---

## Key Outcomes

### What We Learned
<!-- New understanding gained this session -->

- [Learning 1 - new insight about problem/solution]
- [Learning 2 - understanding of trade-offs]
- [Learning 3 - constraint discovered]

### What We Decided
<!-- Decisions finalized this session -->

| Decision | Choice | Rationale | ADR |
|----------|--------|-----------|-----|
| [Topic] | [Choice] | [Brief why] | [ADR-NNN] or — |

### What We Ruled Out
<!-- Options we eliminated and why -->

- **[Option A]**: [Why ruled out - specific reason tied to requirements]
- **[Option B]**: [Why ruled out]

### What We Identified
<!-- New questions, risks, or considerations discovered -->

**Risks**:
- [Risk 1]
- [Risk 2]

**Assumptions**:
- [Assumption 1 - needs validation]

**Constraints**:
- [Constraint discovered]

---

## Questions Addressed

| Question | Answer | Confidence |
|----------|--------|------------|
| [Question we came in with] | [Answer] | ⬜ High ⬜ Medium ⬜ Low |

---

## New Questions Raised

| Question | Priority | Blocking? | Assign To |
|----------|----------|-----------|-----------|
| [New question] | ⬜ High ⬜ Med ⬜ Low | Yes / No | [Phase or person] |

---

## Action Items

<!-- Things to do before or during next session -->

**Before Next Session**:
- [ ] [Action 1 - validation needed] — Owner: [Name]
- [ ] [Action 2 - research required] — Owner: [Name]

**During Next Session**:
- [ ] [Action 3 - decision to make] — Session focus
- [ ] [Action 4 - component to detail] — Session focus

---

## Design Document Updates

<!-- What should be updated in the living design doc -->

**Immediate Updates** (do now):
- [ ] Update design document section [N]: [What changed]
- [ ] Add decision to decisions table: [Decision topic]
- [ ] Add/answer question: [Q-ID]
- [ ] Update session log with this session

**Deferred Updates** (do later):
- [ ] Update architecture diagram: [What changed]
- [ ] Create ADR for [decision]: [Link when created]

---

## cc-bootstrap Integration

<!-- Updates needed in other cc-bootstrap docs -->

**Architecture**:
- [ ] Update `.claude/architecture.md` section [X]: [What needs updating]

**Modules**:
- [ ] Create `.claude/modules/[new-module].md` for [component]
- [ ] Update `.claude/modules/[existing-module].md`: [What changed]

**ADRs**:
- [ ] Create `docs/adr/ADR-NNN-[title].md` for [decision]

---

## Next Session Planning

### Recommended Focus

[What should the next session tackle?]

**Specific goals**:
- [ ] Goal 1
- [ ] Goal 2

### Prerequisites

**Must be done before next session**:
- [ ] [Prerequisite 1 - research, validation, etc.]
- [ ] [Prerequisite 2]

**Optional but helpful**:
- [ ] [Optional prep 1]

### Suggested Phase

⬜ **Exploration** — Open-ended discovery, problem understanding
⬜ **Requirements** — Define boundaries and constraints
⬜ **Options** — Compare architectural approaches
⬜ **Decision** — Finalize a pending choice
⬜ **Detail** — Deep dive on component specifics
⬜ **Validation** — Challenge and validate design

### Estimated Duration

[X hours / Y sessions to complete next phase]

---

## Context for Next Session

> **Copy this section when starting your next design conversation.**
>
> **How to use**: Paste this at the start of your next Claude session to restore context

```
/start-design-session

Continuing architecture for [PROJECT NAME].

**Current phase**: [Phase name]

**Session [N+1] focus**: [Recommended focus from above]

**Key context from previous sessions**:
- [Important decision 1 - with brief rationale]
- [Important decision 2]
- [Important constraint or requirement]
- [Assumption we're operating under]

**Open questions to address this session**:
- [Priority question 1]
- [Priority question 2]

**Mode**: [Exploration / Options / Decision / Detail / Validation]

[Additional guidance: "Don't finalize - I want to explore options first" or "Ready to decide - help me evaluate trade-offs"]
```

---

## Raw Notes

<!-- Optional: paste any rough notes from the session here -->

```
[Raw notes, transcript excerpts, or scratch work that might be useful later]

Examples:
- Claude's explanations that were particularly insightful
- Prompts that worked well
- Links to external resources consulted
- Calculations or estimates made
```

---

## Retrospective

<!-- Optional: brief reflection on the session itself -->

### What Worked Well

- [What was productive about this session]
- [Effective prompts or techniques used]
- [Good decisions made]

### What Could Improve

- [What was frustrating or inefficient]
- [Areas where we got stuck]
- [Information we wish we had earlier]

### Process Adjustments

- [Changes to try next session]
- [Different approach to consider]

---

## Related Documents

**Design Document**: `docs/design/[project]-design.md`

**ADRs Created This Session**:
- [ADR-NNN](../../adr/ADR-NNN-title.md): [Decision title]

**Phase Workflows Referenced**:
- [`.claude/design/workflows/[phase]-phase.md`]

**Modules Referenced**:
- [`.claude/modules/[module].md`]

---

## Session Cost Tracking

<!-- Optional: track design session costs -->

**Model Used**: [Opus / Sonnet / Haiku]

**Approximate Tokens**: [Input tokens / Output tokens]

**Estimated Cost**: $[X.XX]

**Total Design Cost So Far**: $[Y.YY] across [N] sessions

---

## Tips for Using This Template

### During Session

1. Keep this template open
2. Fill in "Key Outcomes" as you go
3. Note questions as they arise
4. Track decisions immediately

### End of Session

1. Complete all sections
2. Prepare "Context for Next Session"
3. Update design document
4. Create any ADRs needed

### Start of Next Session

1. Copy "Context for Next Session" block
2. Paste into Claude
3. Reference this session's notes as needed
4. Continue where you left off

### Multi-Session Designs

For designs spanning 3+ sessions:
- Keep all session notes in same directory
- Number sequentially (Session 1, 2, 3...)
- Cross-reference between sessions
- Track cumulative decisions across sessions

### Storage Location

Save session notes to:
- `docs/design/sessions/[project-name]-session-[N].md`

Or keep with design document:
- `docs/design/[project-name]-design.md` (main design doc)
- `docs/design/[project-name]-session-1.md` (session 1 notes)
- `docs/design/[project-name]-session-2.md` (session 2 notes)
