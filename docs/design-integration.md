# Design Methodology + Superpowers Integration

How cc-bootstrap design workflows and Superpowers plugin work together.

---

## Overview

| Component | Provides | Phase |
|-----------|---------|-------|
| **Design workflows** | Structured architecture thinking | Before implementation |
| **Superpowers `/brainstorm`** | Socratic exploration | Design exploration |
| **Superpowers `/write-plan`** | Implementation planning | After design |
| **Superpowers `/execute-plan`** | TDD implementation | Implementation |

---

## The Complete Flow

### 1. Initial Exploration (Superpowers)

```
/brainstorm
```

Superpowers guides open-ended exploration through Socratic questions.

**Output**: Initial understanding of problem space

### 2. Structured Design (cc-bootstrap)

```
/start-design-session
```

cc-bootstrap design workflows provide structure.

**Iterate through phases**:
- Exploration → Requirements → Options → Decision → Detail → Validation

**Output**: Design document + ADRs

### 3. Implementation Planning (Superpowers)

```
/finalize-design
/write-plan
```

Create detailed implementation plan based on validated design.

**Output**: Step-by-step implementation plan

### 4. Implementation (Superpowers + cc-bootstrap)

```
/load-workflow feature-development
/execute-plan
```

Implement with TDD enforcement (Superpowers "Iron Law").

**Output**: Working, tested code

---

## Model Selection Across Flow

| Stage | Model | Tool | Rationale |
|-------|-------|------|-----------|
| Exploration | **Opus** | `/brainstorm`, design phases | Deep reasoning needed |
| Design iteration | **Opus** | Design phases | Complex trade-off analysis |
| Planning | **Opus** | `/write-plan` | Architectural planning |
| Implementation | **Sonnet** | `/execute-plan` | Fast code generation |
| Review | **Haiku** | `/audit` | Quick doc checks |

---

## When to Use Each Tool

### Use `/brainstorm` (Superpowers) When

- Starting completely fresh
- Problem definition very unclear
- Need Socratic questioning
- Want open-ended exploration

### Use Design Phases (cc-bootstrap) When

- Need structured iteration
- Comparing specific options
- Making decisions with documented rationale
- Building on brainstorm insights

### Use Both When

- Complex architectural projects
- Start with `/brainstorm`, transition to design phases

---

## Example: Adding Real-Time Features

### Stage 1: Exploration (Opus + Superpowers)

```
User: /brainstorm
Claude: [Socratic questioning about real-time needs]

User: /load-design-phase exploration
Claude: [Structured exploration of WebSocket vs SSE vs polling]
```

### Stage 2: Design Iteration (Opus + cc-bootstrap)

```
User: /load-design-phase options
Claude: [Present 3-4 architectural approaches with trade-offs]

User: /load-design-phase decision
Claude: [Help evaluate, play devil's advocate]

User: /load-design-phase validation
Claude: [Challenge design, identify risks]
```

**Artifacts**:
- `docs/design/real-time-features.md`
- `docs/adr/ADR-015-websocket-architecture.md`
- Updated `.claude/architecture.md`

### Stage 3: Planning (Opus + Superpowers)

```
User: /finalize-design
Claude: [Verify completeness]

User: /write-plan
Claude: [Create plan with test scenarios]
```

### Stage 4: Implementation (Sonnet + Superpowers + cc-bootstrap)

```
User: /load-workflow feature-development
User: /execute-plan

Claude: [Implements with TDD, following plan]
```

---

## Smooth Transitions

**Brainstorm → Design**:
- Save brainstorm insights to design doc's problem statement

**Design → Planning**:
- Reference design doc when running `/write-plan`

**Planning → Implementation**:
- Load feature-development workflow before `/execute-plan`

---

## See Also

- `docs/superpowers-integration.md` - Full Superpowers setup guide
- `.claude/design/workflows/design-session.md` - Design workflow details
- `docs/design/design-workflow-guide.md` - When to design vs. implement
