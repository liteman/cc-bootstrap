# Design Session Workflow

> **When to read**: Before starting architectural design, exploring solution spaces, or making significant technical decisions
>
> **Tags**: `design`, `architecture`, `planning`
>
> **With Superpowers**: Use `/brainstorm` for initial exploration, then this workflow for structured design iteration
>
> **Recommended Model**: Opus (deep reasoning for design decisions)

---

## Overview

This workflow guides you through structured design sessions using the iterative design methodology. Use this when:

- [ ] Solution approach isn't obvious
- [ ] Multiple architectural options exist
- [ ] Decision has significant reversal cost (database, framework, architecture)
- [ ] Cross-team alignment needed
- [ ] Technology evaluation required
- [ ] Impact spans multiple modules
- [ ] You're genuinely unsure what you're solving

**Skip to implementation workflows when**:
- [ ] Pattern already exists in codebase
- [ ] Change is localized to one module
- [ ] Requirements are crystal clear
- [ ] Solution is low-risk and reversible

See `docs/design/design-workflow-guide.md` for detailed decision framework.

---

## The Design Process

Design work flows through 6 phases:

| Phase | Goal | Duration | Output |
|-------|------|----------|--------|
| **Exploration** | Understand the problem | 1-2 sessions | Refined problem statement |
| **Requirements** | Define boundaries | 1 session | Requirements doc |
| **Options** | Survey approaches | 1-2 sessions | 3-5 alternatives with trade-offs |
| **Decision** | Choose deliberately | 1 session | Decision + rationale (ADR) |
| **Detail** | Flesh out components | 1-2 sessions | Component specs |
| **Validation** | Find gaps | 1 session | Risk assessment |

**Total time investment**: 3-6 Opus sessions (vs. 10+ Sonnet sessions debugging wrong approach)

---

## Pre-Session Checklist

Before starting any design session:

- [ ] Identify design need (new feature, refactor, technology evaluation)
- [ ] Determine current phase (or start at Exploration)
- [ ] Switch to Opus model for deep reasoning
- [ ] Create design document from template: `.claude/design/templates/DESIGN_DOCUMENT.md`
- [ ] Save design document to: `docs/design/[project-name]-design.md`

---

## Session Flow

### Step 1: Set Design Mode

Load design context and set collaborative thinking mode:

```
/start-design-session
```

**What this does**:
- Loads design session workflow (this file)
- Loads design thinking conventions
- Loads current architecture from `.claude/architecture.md`
- Recommends Opus model
- Asks which phase you're in

**Alternative**: Load specific phase directly:

```
/load-design-phase exploration
/load-design-phase requirements
/load-design-phase options
/load-design-phase decision
/load-design-phase detail
/load-design-phase validation
```

---

### Step 2: Explicitly Set Expectations

Tell Claude what kind of interaction you want:

**During Exploration/Requirements/Options phases**:
```
"Let's explore options without deciding yet."
"I'm not ready to decide - help me understand trade-offs."
"Don't solve it, help me think through it."
```

**During Decision phase**:
```
"I need to make a decision on [X]. Here's what I'm considering..."
"I'm leaning toward [choice]. Play devil's advocate - why might this be wrong?"
```

**During Detail/Validation phases**:
```
"Let's go deep on [specific component]."
"What could go wrong with this design?"
"Challenge my assumptions."
```

---

### Step 3: Work the Phase

Each phase has specific goals and techniques. Load the phase workflow for detailed guidance:

- **Exploration**: `/load-design-phase exploration` — Understand problem before solutions
- **Requirements**: `/load-design-phase requirements` — Define boundaries and constraints
- **Options**: `/load-design-phase options` — Survey architectural approaches neutrally
- **Decision**: `/load-design-phase decision` — Choose with documented rationale
- **Detail**: `/load-design-phase detail` — Flesh out component specifics
- **Validation**: `/load-design-phase validation` — Find gaps and risks

**Phase workflow files** (read for detailed prompts and techniques):
- `.claude/design/workflows/exploration-phase.md`
- `.claude/design/workflows/requirements-phase.md`
- `.claude/design/workflows/options-phase.md`
- `.claude/design/workflows/decision-phase.md`
- `.claude/design/workflows/detail-phase.md`
- `.claude/design/workflows/validation-phase.md`

---

### Step 4: Document Outcomes

As you work, update your design document:

**During session**:
- [ ] Update problem statement (Exploration)
- [ ] Add/refine requirements (Requirements)
- [ ] Document options considered (Options)
- [ ] Record decisions made (Decision)
- [ ] Detail component specs (Detail)
- [ ] List risks identified (Validation)

**At end of session**:
- [ ] Create session notes using `.claude/design/templates/SESSION_NOTES.md`
- [ ] Update design document status
- [ ] Identify what's needed for next session

**When decisions are made**:
- [ ] Create ADR using `.claude/design/templates/ADR_TEMPLATE.md`
- [ ] Save to `docs/adr/ADR-NNN-short-title.md`
- [ ] Link ADR from design document

---

### Step 5: Plan Next Session

**Prepare handoff context** (especially important for multi-session designs):

1. Copy session notes template: `.claude/design/templates/SESSION_NOTES.md`
2. Fill out session outcomes
3. Identify next phase or continuation
4. Prepare context block for next session

**Example handoff**:
```
Continuing architecture for [project].
Current phase: Options
Session 3 focus: Comparing database choices

Key context:
- Must support multi-tenancy (Requirement from Session 1)
- 10M+ rows expected (Non-functional requirement)
- Team familiar with PostgreSQL, not MongoDB

Open questions:
- How to handle cross-tenant queries?
- Schema versioning strategy?

Mode: Options exploration (don't recommend yet)
```

---

## Transitioning to Implementation

When design is validated and ready for implementation:

### Step 1: Finalize Design

```
/finalize-design
```

**What this does**:
- Verifies design document completeness
- Lists decisions that need ADRs
- Identifies `.claude/architecture.md` updates needed
- Suggests transition to implementation planning

---

### Step 2: Create ADRs

For each significant decision:

- [ ] Copy template: `.claude/design/templates/ADR_TEMPLATE.md`
- [ ] Fill out: context, options considered, decision, rationale, consequences
- [ ] Save to: `docs/adr/ADR-NNN-title.md`
- [ ] Link from design document

**Tip**: Create ADRs as you decide, not all at the end.

---

### Step 3: Update Architecture

- [ ] Update `.claude/architecture.md` with finalized design
- [ ] Add new components to architecture overview
- [ ] Link to relevant ADRs in ADR Index table
- [ ] Update affected module guides in `.claude/modules/`

---

### Step 4: Create Implementation Plan

**With Superpowers**:
```
/write-plan
```

Reference your design document when creating the plan.

**Without Superpowers**:
Create implementation plan manually in `docs/plans/[feature-name]-plan.md`

---

### Step 5: Begin Implementation

**Switch model**: Opus → Sonnet for cost-effective implementation

**Load implementation workflow**:
```
/load-workflow feature-development
```

**With Superpowers**:
```
/execute-plan
```

**Reference during implementation**:
- Design document: Overall architecture and rationale
- ADRs: Specific decision context
- Architecture.md: Current system structure

---

## Integration with Superpowers

When both design workflows and Superpowers are available, use this flow:

### Phase 1: Initial Exploration
```
/brainstorm
```
Superpowers guides Socratic exploration.

### Phase 2: Structured Design
```
/load-design-phase exploration
```
cc-bootstrap provides structure to exploration. Iterate through phases.

### Phase 3: Implementation Planning
```
/finalize-design
/write-plan
```
Superpowers creates detailed plan based on finalized design.

### Phase 4: Implementation
```
/load-workflow feature-development
/execute-plan
```
Superpowers enforces TDD while cc-bootstrap provides project context.

**See**: `docs/design-integration.md` for detailed Superpowers integration guide.

---

## Common Patterns

### Pattern 1: Quick Design Review

For small decisions that don't need full design process:

```
/load-design-phase options
[Present 2-3 alternatives]
/load-design-phase decision
[Make decision with brief rationale]
```

**Total time**: 1 session, skip full design doc

---

### Pattern 2: Technology Evaluation

Structured approach to "should we use X or Y?":

```
/load-design-phase requirements
[Define what technology must do]
/load-design-phase options
[Survey 3-5 options neutrally]
/load-design-phase decision
[Evaluate with decision drivers]
[Create ADR]
```

**Artifact**: ADR documenting technology choice

---

### Pattern 3: Major Feature Design

Full design process for complex, high-stakes features:

```
Session 1: /load-design-phase exploration
Session 2: /load-design-phase requirements
Session 3-4: /load-design-phase options
Session 5: /load-design-phase decision
Session 6: /load-design-phase detail
Session 7: /load-design-phase validation
```

**Artifacts**: Design document + multiple ADRs + updated architecture.md

---

## Design Session Best Practices

### DO

1. **Use Opus for design** — Deep reasoning is worth the cost
2. **Take session notes** — Context preservation is critical
3. **Document decisions immediately** — Create ADRs when decisions are made, not later
4. **Challenge assumptions** — Ask "what if this is wrong?"
5. **Don't rush** — Extra session on design beats rewrite later
6. **Reference design during implementation** — Keep design doc open

### DON'T

1. **Don't skip to implementation** — Validate design first
2. **Don't accept first suggestion** — Explore alternatives
3. **Don't skip ADRs** — Future you needs the rationale
4. **Don't design forever** — 6+ sessions without progress = make a decision
5. **Don't ignore validation** — Finding gaps early is cheaper

---

## When Design Goes Wrong

### Symptom: Reimplementing after initial attempt failed

**Cause**: Skipped design or rushed to implementation

**Fix**: Go back to design. Run validation phase on current approach.

---

### Symptom: Major issues discovered during code review

**Cause**: Skipped options or validation phase

**Fix**: Pause implementation. Run `/load-design-phase validation` on current design.

---

### Symptom: Analysis paralysis (6+ sessions, no progress)

**Cause**: Over-designing, no decisions being made

**Fix**: Make a decision with current information. Use "two-way door" decisions (easily reversible). Create prototype to learn.

---

### Symptom: Team disagreement on direction

**Cause**: Decisions made without documenting rationale

**Fix**: Create ADRs that explicitly state decision drivers, options considered, and trade-offs accepted. Share for review.

---

## Measuring Success

### Good Design Process Indicators

- [ ] Clear rationale for every major decision (documented in ADRs)
- [ ] Identified risks have mitigation plans
- [ ] Implementation proceeds smoothly (few architectural surprises)
- [ ] Team aligned on approach
- [ ] Documented decisions aid future maintenance

### Poor Design Process Indicators

- [ ] Decisions made "by committee" without clear rationale
- [ ] Surprises during implementation require redesign
- [ ] Team confusion about architectural direction
- [ ] No record of why choices were made (frustrates future developers)
- [ ] Skipped phases led to missed considerations

---

## Quick Reference: Commands

| Command | Purpose |
|---------|---------|
| `/start-design-session` | Begin design session, load all context |
| `/load-design-phase <phase>` | Load specific phase workflow |
| `/finalize-design` | Verify completeness, transition to implementation |
| `/write-plan` | (Superpowers) Create implementation plan |
| `/execute-plan` | (Superpowers) Implement with TDD |
| `/load-workflow feature-development` | Load implementation workflow |

---

## Additional Resources

- **Design Thinking Conventions**: `.claude/design/conventions/design-thinking.md` — How Claude should behave during design
- **Phase Workflows**: `.claude/design/workflows/*-phase.md` — Detailed guidance for each phase
- **Templates**: `.claude/design/templates/` — Design document, ADR, session notes
- **Decision Framework**: `docs/design/design-workflow-guide.md` — When to design vs. implement
- **Superpowers Integration**: `docs/design-integration.md` — How design + Superpowers work together
- **ADR Best Practices**: `docs/design/adr-guide.md` — Writing good ADRs

---

## Summary

**Design sessions = structured thinking before coding**

1. **Start**: `/start-design-session` (Opus model)
2. **Iterate**: Work through phases (Exploration → Validation)
3. **Document**: Design doc + ADRs + session notes
4. **Transition**: `/finalize-design` → `/write-plan` → implementation
5. **Implement**: Reference design artifacts, use Sonnet

**Investment**: 3-6 Opus sessions
**Payoff**: Fewer rewrites, better decisions, documented rationale
