# Design Phase Quick Reference

Quick reference for the 6 design phases. For detailed workflows, see `.claude/design/workflows/`.

---

## Phase Overview

| Phase | Goal | Command | Duration |
|-------|------|---------|----------|
| **Exploration** | Understand problem | `/load-design-phase exploration` | 1-2 sessions |
| **Requirements** | Define boundaries | `/load-design-phase requirements` | 1 session |
| **Options** | Survey approaches | `/load-design-phase options` | 1-2 sessions |
| **Decision** | Choose deliberately | `/load-design-phase decision` | 1 session |
| **Detail** | Flesh out components | `/load-design-phase detail` | 1-2 sessions |
| **Validation** | Find gaps | `/load-design-phase validation` | 1 session |

---

## Exploration Phase

**Goal**: Understand what you're solving before thinking about solutions

**Key Prompts**:
- "What are we actually solving?"
- "Challenge my assumptions"
- "Who is affected?"

**Outputs**:
- Refined problem statement
- Scope boundaries
- Success criteria

**Ready to advance when**:
- Problem is clear and specific
- Assumptions are explicit
- Success criteria are measurable

---

## Requirements Phase

**Goal**: Define boundaries without implementation

**Key Prompts**:
- "What must this DO?" (functional)
- "What must this BE?" (non-functional)
- "What must we work within?" (constraints)

**Outputs**:
- Functional requirements (prioritized)
- Non-functional requirements (measurable)
- Constraints documented
- Assumptions validated

**Ready to advance when**:
- Requirements are testable
- Constraints are explicit
- Assumptions have validation plan

---

## Options Phase

**Goal**: Survey solution landscape objectively

**Key Prompts**:
- "What are fundamentally different approaches?"
- "What are trade-offs of each?"
- "When would each option be best?"

**Outputs**:
- 3-5 options per decision
- Explicit trade-offs
- Decision drivers
- Conditions favoring each

**Ready to advance when**:
- Multiple viable options documented
- Trade-offs are specific
- Decision drivers clear

---

## Decision Phase

**Goal**: Choose with documented rationale

**Key Prompts**:
- "I'm leaning toward X, challenge that"
- "Is this reversible?"
- "What's the cost of being wrong?"

**Outputs**:
- Clear decision
- Rationale tied to drivers
- ADRs created
- Trade-offs acknowledged

**Ready to advance when**:
- All major decisions made
- Rationale documented
- Success criteria defined

---

## Detail Phase

**Goal**: Flesh out component specifics

**Key Prompts**:
- "Walk me through the data flow"
- "What's the interface between A and B?"
- "How do we handle [edge case]?"

**Outputs**:
- Component specifications
- Interface definitions
- Data flows
- Edge case handling

**Ready to advance when**:
- All components detailed
- Interfaces defined
- Module guides created

---

## Validation Phase

**Goal**: Find gaps before implementing

**Key Prompts**:
- "What could go wrong?"
- "Where are single points of failure?"
- "Does this meet all requirements?"

**Outputs**:
- Risk assessment
- Requirements trace
- Security review
- Go/no-go decision

**Ready to implement when**:
- All requirements traced
- Critical risks mitigated
- No major gaps

---

## Phase Flow

```
Exploration → Requirements → Options → Decision → Detail → Validation → Implement
```

You can skip phases for simple decisions but document why.
