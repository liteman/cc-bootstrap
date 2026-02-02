# Design Workflow Guide

A practical guide for deciding when to use design workflows vs. implementation workflows, and how to integrate design thinking into your development process.

---

## Table of Contents

1. [When to Use Design Workflows](#when-to-use-design-workflows)
2. [Design vs. Implementation](#design-vs-implementation-workflows)
3. [The Design → Implementation Flow](#the-design--implementation-flow)
4. [Example Scenarios](#example-scenarios)
5. [Working with Superpowers](#working-with-superpowers)
6. [Best Practices](#best-practices)
7. [Measuring Success](#measuring-success)

---

## When to Use Design Workflows

### Use Design Workflows When

- [ ] **Solution approach isn't obvious** — Multiple paths exist, unclear which is best
- [ ] **Multiple architectural options** — Need to compare fundamentally different approaches
- [ ] **High reversal cost** — Decision is difficult or expensive to change later (database choice, framework, core architecture)
- [ ] **Cross-team alignment needed** — Multiple stakeholders need to agree on direction
- [ ] **Technology evaluation required** — Comparing unfamiliar technologies or approaches
- [ ] **Impact spans multiple modules** — Changes affect several parts of the system
- [ ] **Genuinely uncertain** — You don't know what you're solving yet

**Key question**: "If we get this wrong, how painful is it to fix?"
- Very painful → Design first
- Easy to change → Implement directly

### Skip to Implementation When

- [ ] **Pattern exists in codebase** — Similar problem solved before, follow the pattern
- [ ] **Localized to one module** — Change doesn't ripple beyond a single component
- [ ] **Requirements crystal clear** — No ambiguity about what needs to be built
- [ ] **Low-risk and reversible** — Easy to change if wrong (two-way door decision)
- [ ] **Time-critical and low-stakes** — Need to ship fast and failure cost is acceptable

**Key question**: "Can we easily change this later if needed?"
- Yes → Implement directly
- No → Design first

---

## Design vs. Implementation Workflows

| Aspect | Design Session | Feature Development |
|--------|---------------|---------------------|
| **When** | Before approach is clear | After design is validated |
| **Model** | Opus (deep reasoning) | Sonnet (fast execution) |
| **Duration** | 3-6 sessions (spread over days) | Continuous (hours to days) |
| **Output** | Design doc + ADRs | Working, tested code |
| **Focus** | Options & trade-offs | Implementation quality |
| **Workflow** | `/start-design-session`<br>`/load-design-phase <phase>` | `/load-workflow feature-development` |
| **Cost** | Higher per-session cost (Opus) | Lower per-session cost (Sonnet) |
| **Value** | Prevents expensive rewrites | Delivers working features |

**Rule of thumb**: Invest 3-6 Opus sessions in design to avoid 20+ Sonnet sessions debugging the wrong approach.

---

## The Design → Implementation Flow

### Complete Flow

```
┌─────────────────────────────────────────────────────────────┐
│                    DESIGN PHASE (Opus)                      │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  1. /start-design-session                                   │
│     ↓                                                       │
│  2. Iterate through phases:                                 │
│     • Exploration    → Understand problem                   │
│     • Requirements   → Define boundaries                    │
│     • Options        → Survey approaches                    │
│     • Decision       → Choose deliberately                  │
│     • Detail         → Flesh out components                 │
│     • Validation     → Find gaps                            │
│     ↓                                                       │
│  3. Create artifacts:                                       │
│     • Design document (docs/design/)                        │
│     • ADRs for key decisions (docs/adr/)                    │
│     • Update architecture.md                                │
│     ↓                                                       │
│  4. /finalize-design                                        │
│                                                             │
└─────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────┐
│                   PLANNING PHASE (Opus)                     │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  5. /write-plan (Superpowers)                               │
│     • Reference design doc                                  │
│     • Create step-by-step implementation plan               │
│     • Define test scenarios                                 │
│                                                             │
└─────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────┐
│                IMPLEMENTATION PHASE (Sonnet)                │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  6. Switch to Sonnet model                                  │
│     ↓                                                       │
│  7. /load-workflow feature-development                      │
│     ↓                                                       │
│  8. /execute-plan (Superpowers)                             │
│     • Implement with TDD                                    │
│     • Reference design doc & ADRs                           │
│     • Follow implementation workflow                        │
│     ↓                                                       │
│  9. Test, review, ship                                      │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### Phase Breakdown

#### Phase 1: Design (3-6 Opus sessions)

**Goal**: Validated architecture with documented decisions

**Activities**:
- Explore problem space
- Define requirements and constraints
- Compare architectural options
- Make decisions with explicit rationale
- Detail component design
- Validate design for gaps/risks

**Artifacts**:
- Design document with all phases completed
- ADRs for significant decisions
- Updated architecture.md

**Model**: Opus (deep reasoning required)

---

#### Phase 2: Planning (1 Opus session)

**Goal**: Step-by-step implementation plan

**Activities**:
- Break design into implementation tasks
- Define test scenarios
- Identify dependencies
- Sequence work

**Artifacts**:
- Implementation plan (via Superpowers `/write-plan`)

**Model**: Opus (architectural planning)

---

#### Phase 3: Implementation (Sonnet, duration varies)

**Goal**: Working, tested code

**Activities**:
- Follow feature development workflow
- Implement with TDD
- Reference design artifacts
- Test and validate

**Artifacts**:
- Production code
- Tests
- Updated module documentation

**Model**: Sonnet (cost-effective code generation)

---

## Example Scenarios

### Scenario 1: New Authentication System

**Situation**: Need to add OAuth to existing password-based auth

#### Design Path (Recommended)

**Why design first?**
- Multiple OAuth provider options
- Security-critical decision (high cost if wrong)
- Affects multiple modules (auth, user, session)
- Requires migration strategy for existing users

**Design Sessions**:

**Session 1 - Exploration** (Opus, ~1 hour)
```
/load-design-phase exploration

Questions to explore:
- What providers? (Google, GitHub, enterprise SSO?)
- Social login only or enterprise SSO too?
- How to handle existing password users?
- What's the current pain point OAuth solves?
```

**Output**: Refined problem statement, scope boundaries

---

**Session 2 - Requirements** (Opus, ~1 hour)
```
/load-design-phase requirements

Requirements to define:
- Security requirements (token storage, session management)
- User experience requirements (account linking, merging)
- Compliance requirements (data privacy)
- Performance requirements (auth latency)
- Migration requirements (existing user handling)
```

**Output**: Validated requirements table

---

**Session 3 - Options** (Opus, ~1.5 hours)
```
/load-design-phase options

Options to compare:
- OAuth library: Passport.js vs Auth0 vs custom
- Session storage: JWT vs server-side sessions vs hybrid
- Account merging: Email-based vs manual vs automatic
```

**Output**: 3-4 options with trade-offs documented

---

**Session 4 - Decision** (Opus, ~1 hour)
```
/load-design-phase decision

Decisions to make:
- Choose OAuth library → Passport.js (team familiarity, flexibility)
- Choose session approach → JWT with refresh tokens (scalability)
- Choose account merging → Email-based with user confirmation (safety)
```

**Output**: ADRs for each decision

---

**Session 5 - Detail** (Opus, ~1.5 hours)
```
/load-design-phase detail

Details to flesh out:
- OAuth flow step-by-step
- Token refresh mechanism
- Error handling for failed OAuth
- Migration script for existing users
```

**Output**: Detailed component design

---

**Session 6 - Validation** (Opus, ~1 hour)
```
/load-design-phase validation

Validation questions:
- What happens when OAuth provider is down?
- What if user's email changes?
- How do we handle OAuth token revocation?
- Security review of token storage?
```

**Output**: Risk assessment with mitigations

---

**Transition to Implementation**:
```
/finalize-design
/write-plan
/load-workflow feature-development
[Switch to Sonnet]
/execute-plan
```

**Implementation** (Sonnet, 2-3 days):
- Implement Passport strategies (TDD)
- Build session management
- Create migration script
- Test & deploy

**Time Investment**:
- Design: 6 Opus sessions (~8 hours total)
- Implementation: 2-3 days with Sonnet

**Payoff**: Security-critical system built right the first time, no expensive rewrites

---

### Scenario 2: Simple CRUD Feature

**Situation**: Add "favorites" feature to existing product list

#### Implementation Path (Recommended)

**Why skip design?**
- Pattern exists (other user preferences already implemented)
- Localized change (only product module affected)
- Clear requirements (standard favorites functionality)
- Low risk (easy to modify later if needed)
- Fast time-to-market desired

**Path**:
```
/load-workflow feature-development
[Follow existing patterns]
[Implement with Sonnet]
```

**Time Investment**: Half day with Sonnet

**Payoff**: Fast delivery, no design overhead for simple pattern matching

---

### Scenario 3: Technology Evaluation

**Situation**: Database is approaching limits, considering alternatives

#### Design Path (Recommended)

**Why design first?**
- Multiple fundamentally different options (PostgreSQL scaling vs. NoSQL vs. sharding vs. caching)
- High reversal cost (database is foundational)
- Requires data on current performance bottlenecks
- Needs team buy-in for new technology

**Design Sessions**:

**Session 1-2 - Exploration + Requirements** (Opus, ~2 hours)
```
/load-design-phase exploration

Questions:
- What's actually slow? (Specific queries, write throughput, etc.)
- Have we optimized current database? (Indexes, queries, hardware)
- What's the growth projection?
- What's the team's experience with alternatives?
```

**Session 3 - Options** (Opus, ~2 hours)
```
/load-design-phase options

Options:
1. Vertical scaling (bigger PostgreSQL instance)
2. Read replicas + caching (Redis)
3. Sharding (horizontal PostgreSQL scaling)
4. Hybrid (PostgreSQL + MongoDB for specific workloads)
5. Full migration to distributed database (Cassandra/DynamoDB)
```

**Session 4 - Decision** (Opus, ~1 hour)
```
/load-design-phase decision

Decision: Read replicas + Redis caching
Rationale:
- Solves current read bottleneck (90% of traffic)
- Team knows PostgreSQL and Redis
- Lowest risk (no data migration required)
- Postpones expensive sharding decision
- Reversible if it doesn't work

Create ADR documenting this choice
```

**Outcome**: Informed decision with documented rationale, avoided expensive full migration

---

### Scenario 4: Emergency Bug Fix

**Situation**: Production is down, users can't checkout

#### Implementation Path (Recommended)

**Why skip design?**
- Time-critical emergency
- Narrow scope (fix the bug)
- Can iterate after stability restored

**Path**:
```
/load-workflow bug-fixes
[Identify root cause]
[Apply minimal fix]
[Deploy]
[Create issue for proper fix later]
```

**Design later** (if needed):
```
[After production is stable]
/start-design-session
[Design proper solution to underlying issue]
```

**Principle**: Fix fast, design properly later when not under pressure

---

## Working with Superpowers

The design methodology and [Superpowers](../superpowers-integration.md) plugin complement each other at different stages.

### Division of Labor

| Tool | Provides | Stage |
|------|---------|-------|
| **Superpowers `/brainstorm`** | Socratic exploration, open-ended questioning | Initial exploration |
| **Design workflows** | Structured iteration through design phases | Design refinement |
| **Superpowers `/write-plan`** | Implementation planning with TDD | Planning |
| **Superpowers `/execute-plan`** | TDD implementation with checkpoints | Implementation |
| **cc-bootstrap workflows** | Project context (modules, conventions, architecture) | Throughout |

### Integrated Flow

#### Stage 1: Initial Exploration (Opus + Superpowers)

```
/brainstorm

[Socratic questions help frame the problem]
[User gains clarity on what they're solving]
```

**Output**: Initial problem understanding

---

#### Stage 2: Structured Design (Opus + Design Workflows)

```
/load-design-phase exploration

[Build on brainstorm insights]
[Structured iteration through 6 phases]
[Create design doc + ADRs]
```

**Output**: Validated design with documented decisions

---

#### Stage 3: Implementation Planning (Opus + Superpowers)

```
/finalize-design
/write-plan

[Reference design doc as input]
[Create step-by-step plan with test scenarios]
```

**Output**: Implementation plan

---

#### Stage 4: Implementation (Sonnet + Superpowers + cc-bootstrap)

```
[Switch to Sonnet]
/load-workflow feature-development
/execute-plan

[TDD enforcement from Superpowers]
[Project context from cc-bootstrap]
[Reference design artifacts]
```

**Output**: Working, tested code

---

### When to Use Each Tool

#### Use `/brainstorm` (Superpowers) When

- Starting completely fresh with vague problem
- Need Socratic questioning to frame the problem
- Want open-ended exploration
- Problem definition is very unclear

**Example**: "I think users are struggling with X but I'm not sure exactly what the problem is"

---

#### Use Design Phases (cc-bootstrap) When

- Need structured iteration through design
- Comparing specific architectural options
- Making decisions with documented rationale
- Building on initial brainstorm insights

**Example**: "I understand the problem (from brainstorm), now I need to compare 3 database options"

---

#### Use Both When

- Complex architectural project
- Start with `/brainstorm` to frame problem
- Transition to design phases to solve it

**Flow**:
```
/brainstorm → Understand problem
  ↓
/load-design-phase exploration → Refine understanding
  ↓
[Iterate through design phases]
  ↓
/write-plan → Plan implementation
  ↓
/execute-plan → Build it
```

---

## Best Practices

### During Design

#### 1. Use Opus for Design Sessions

**Why**: Design requires deep reasoning, trade-off analysis, and creative exploration

**Cost**: ~$2-5 per session
**Savings**: Avoiding one architecture rewrite pays for 50+ design sessions

---

#### 2. Take Session Notes

**Use**: `.claude/design/templates/SESSION_NOTES.md`

**Why**: Design spans multiple sessions, context preservation is critical

**Template provides**:
- Session outcomes capture
- Questions answered/raised tracking
- Handoff context for next session (copy-paste ready)

---

#### 3. Document Decisions Immediately

**Don't**: Wait until design is "done" to create ADRs
**Do**: Create ADR when decision is made

**Why**: Rationale is fresh in your mind, easier to document

---

#### 4. Challenge Assumptions

**Technique**: Explicitly list assumptions, then question each

**Prompt**:
```
"I'm assuming [X]. Is that safe? What breaks if it's wrong?"
```

**Why**: Unchallenged assumptions become hidden risks

---

#### 5. Don't Rush Through Phases

**Bad**: Jumping from Exploration to Decision (skipping Requirements, Options)
**Good**: Systematic progression through all phases

**Why**: Each phase builds on the previous, skipping creates gaps

**Exception**: Can skip phases for small decisions, but document why

---

#### 6. Reference Design During Implementation

**Keep open during implementation**:
- Design document (overall approach)
- ADRs (decision rationale)
- Architecture.md (current system)

**Why**: Implementation questions often answered in design artifacts

---

### Transitioning to Implementation

#### 1. Finalize Artifacts

Before switching to implementation:

- [ ] Design document complete (all sections filled)
- [ ] ADRs created for significant decisions
- [ ] Architecture.md updated with new design
- [ ] Module guides created/updated
- [ ] Risks have mitigation plans

**Command**: `/finalize-design` (checks completion)

---

#### 2. Create Implementation Plan

**With Superpowers**:
```
/write-plan
```

Reference design document when creating plan

**Without Superpowers**:
Create manual plan in `docs/plans/[feature]-plan.md`

---

#### 3. Switch Models

**Explicitly switch** from Opus to Sonnet:

```
"Let's switch to Sonnet for implementation now that design is validated"
```

**Why**: Sonnet is faster and cheaper for code generation

---

#### 4. Load Implementation Context

```
/load-workflow feature-development
```

**Then begin** (with Superpowers):
```
/execute-plan
```

---

### When Design Goes Wrong

#### Symptom 1: Reimplementing After Failure

**Cause**: Skipped design or rushed to implementation

**Fix**:
1. Pause implementation
2. Run `/start-design-session`
3. Go through validation phase on current approach
4. Identify gaps, revise design
5. Create ADRs documenting new decisions
6. Resume implementation with validated design

---

#### Symptom 2: Major Issues in Code Review

**Cause**: Skipped options or validation phase

**Fix**:
1. Pause development
2. Run `/load-design-phase validation`
3. Challenge the design with reviewer's concerns
4. Update design document with findings
5. Create ADR if approach changes
6. Update implementation

---

#### Symptom 3: Analysis Paralysis (6+ sessions, no progress)

**Cause**: Over-designing, fear of making decisions

**Fix**:
1. Recognize the stall
2. Identify the blocking decision
3. Make decision with current information
4. Document it as "two-way door" (reversible)
5. Move forward, learn by implementing
6. Be willing to change later if needed

**Quote**: "Make reversible decisions quickly, irreversible decisions slowly"

---

#### Symptom 4: Team Disagreement

**Cause**: Decisions made without documenting rationale

**Fix**:
1. Create ADR for controversial decision
2. Explicitly state decision drivers (what's most important)
3. Document all options considered (not just chosen one)
4. Explain rationale tied to drivers
5. Acknowledge trade-offs honestly
6. Share ADR for review/discussion

---

## Measuring Success

### Good Design Process Indicators

When the design process is working well, you'll see:

- [ ] **Clear rationale for every major decision** (documented in ADRs)
- [ ] **Identified risks have mitigation plans** (not just "we'll deal with it later")
- [ ] **Implementation proceeds smoothly** (few architectural surprises)
- [ ] **Team aligned on approach** (no debates about fundamental direction)
- [ ] **Documented decisions aid future maintenance** ("Oh, that's why we did it that way!")
- [ ] **Faster iteration** (design catches issues before implementation)

---

### Poor Design Process Indicators

When the design process isn't working, you'll see:

- [ ] **Decisions made "by committee" without clear rationale** ("We all agreed on X" but no documentation why)
- [ ] **Surprises during implementation require redesign** ("We didn't think about Y")
- [ ] **Team confusion about architectural direction** ("I thought we were doing X?")
- [ ] **No record of why choices were made** (frustrates future developers)
- [ ] **Skipped phases led to missed considerations** ("We should have thought about scale")
- [ ] **Frequent rewrites** (indicates inadequate design validation)

---

### Time Investment Analysis

#### Example: Authentication System

**With design**:
- Design: 6 Opus sessions (~8 hours) = ~$30
- Implementation: 2 days (smooth, validated) = ~$15
- **Total**: 2.5 days, ~$45

**Without design**:
- Implementation attempt 1: 3 days (wrong approach) = ~$25
- Debugging: 1 day (performance issues) = ~$5
- Redesign: 1 day (team meetings, arguing) = ~$0 (wasted time)
- Implementation attempt 2: 2 days (right approach) = ~$15
- **Total**: 7 days, ~$45, lots of frustration

**Savings**: 4.5 days of wasted effort avoided

---

### Decision Quality Metrics

**High-quality decisions** (via design process):
- Multiple options considered (≥3)
- Trade-offs explicitly documented
- Rationale ties to specific decision drivers
- Consequences acknowledged (both positive and negative)
- Reversibility assessed
- Success criteria defined

**Low-quality decisions** (ad-hoc):
- Only one option considered
- "It seemed like a good idea"
- No documented rationale
- Consequences ignored until they happen
- No plan for validation

---

## Summary

### When to Design

**Decision framework**:

```
Is the decision reversible? ──Yes──> Implement directly
         │
         No
         ↓
Are multiple approaches viable? ──No──> Implement (but document why in ADR)
         │
         Yes
         ↓
Design first (iterate through phases)
```

### Core Workflow

```
Design (Opus) → Plan (Opus) → Implement (Sonnet)
```

### Key Commands

| Command | Purpose |
|---------|---------|
| `/brainstorm` | (Superpowers) Initial problem exploration |
| `/start-design-session` | Begin structured design |
| `/load-design-phase <phase>` | Load specific phase workflow |
| `/finalize-design` | Verify design completeness |
| `/write-plan` | (Superpowers) Create implementation plan |
| `/load-workflow feature-development` | Load implementation workflow |
| `/execute-plan` | (Superpowers) Implement with TDD |

### Time Investment

**Design**: 3-6 Opus sessions (spread over days/weeks)
**Payoff**: Avoid 10+ Sonnet sessions debugging wrong approach

### Success Metrics

- Decisions have documented rationale (ADRs)
- Risks identified early with mitigations
- Smooth implementation (few surprises)
- Team alignment
- Future developers understand "why"

---

## Additional Resources

**cc-bootstrap Documentation**:
- `.claude/design/workflows/design-session.md` — Design workflow
- `.claude/design/conventions/design-thinking.md` — Claude behavior during design
- `.claude/design/templates/` — Design doc, ADR, session notes templates
- `docs/design-integration.md` — Superpowers integration details

**External Resources**:
- [ADR GitHub Organization](https://adr.github.io/) — ADR best practices
- [Design Docs at Google](https://www.industrialempathy.com/posts/design-docs-at-google/) — Industry practices
