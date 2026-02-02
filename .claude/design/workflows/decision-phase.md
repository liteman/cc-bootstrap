# Decision Phase Workflow

> **Goal**: Choose deliberately with documented rationale
>
> **Duration**: Usually 1 session per major decision
>
> **Outputs**: Decisions made, ADRs created
>
> **Model**: Opus (decision reasoning required)

---

## When to Use This Phase

Use Decision phase after Options when:

- [ ] Options have been explored
- [ ] Trade-offs are understood
- [ ] Decision drivers are clear
- [ ] Ready to choose and commit
- [ ] Need documented rationale

**Key principle**: Make decisions explicitly, document why

---

## Setting Decision Mode

Load this phase:

```
/load-design-phase decision
```

Tell Claude:

```
"I need to decide on [X]. Here's what I'm considering: [options].
Help me think through the implications of each choice."
```

---

## Conversation Techniques

### Productive Prompts

| Say This | To Get This |
|----------|-------------|
| "Help me make this decision..." | Decision analysis |
| "I'm leaning toward X, challenge that" | Devil's advocate |
| "What would I regret about choosing X?" | Consequence analysis |
| "Is this reversible or irreversible?" | Risk assessment |
| "What's the cost of being wrong?" | Failure mode analysis |

---

## Step-by-Step Process

### Step 1: Review Decision Context

Recap what led to this decision point.

**Checklist**:
- [ ] Problem statement is clear
- [ ] Requirements are documented
- [ ] Options have been explored (3-5)
- [ ] Trade-offs are explicit
- [ ] Decision drivers are prioritized

**If any missing**: Return to earlier phase to fill gaps

---

### Step 2: State Your Current Thinking

Share which option you're leaning toward (if any) and why.

**Prompt template**:
```
"I'm leaning toward [Option X] because:
- [Reason 1 - tied to decision driver]
- [Reason 2 - tied to decision driver]
- [Reason 3]

But I'm concerned about:
- [Concern 1]
- [Concern 2]

Help me think through whether this is the right choice."
```

**If no lean yet**:
```
"I'm genuinely torn between [Option A] and [Option B].
[Option A] is better for [driver 1] but [Option B] is
better for [driver 2]. How should I think about this trade-off?"
```

---

### Step 3: Apply Decision Framework

Use decision drivers to evaluate options.

**Prompt**:
```
"Our decision drivers are (in priority order):
1. [Driver 1 - most important]
2. [Driver 2]
3. [Driver 3]

How does each option score against these drivers?"
```

**Create decision matrix**:

| Option | Driver 1 | Driver 2 | Driver 3 | Total Score |
|--------|----------|----------|----------|-------------|
| Option A | ++  | -- | + | Medium |
| Option B | + | ++ | + | High |
| Option C | -- | + | ++ | Medium |

Legend: ++ (excellent), + (good), - (poor), -- (very poor)

**Winner**: Option with highest score on top-priority drivers

---

### Step 4: Play Devil's Advocate

Challenge your leading option.

**Prompt**:
```
"I'm leaning toward [Option X]. Play devil's advocate -
why might this be wrong? What am I not seeing?"
```

**Claude should challenge**:
- Hidden assumptions
- Overlooked downsides
- Conditions that might change
- Alternative interpretations

**Example**:
```
User: "I'm choosing PostgreSQL because the team knows SQL"

Claude: "Let me challenge that. A few points:

1. Assumption: 'Team knows SQL' = 'PostgreSQL is best'
   - But does team know PostgreSQL-specific features? (JSONB,
     full-text search, etc.)
   - Could team learn MongoDB in a week if it's clearly better?

2. Forward-looking concern:
   - You mentioned 50M rows in 1 year
   - What's the plan when PostgreSQL hits limits?
   - Is this decision locking you into vertical scaling only?

3. Hidden cost:
   - PostgreSQL schema migrations can block deploys
   - Have you factored that into development velocity?

I'm not saying PostgreSQL is wrong - just ensuring you've
considered these angles before deciding."
```

---

### Step 5: Assess Reversibility

How hard to change this decision later?

**Prompt**:
```
"Is this a one-way door or two-way door decision?
How hard would it be to reverse if we're wrong?"
```

**Two-Way Door** (easily reversible):
- Low commitment, can change later
- Example: CSS framework choice, feature flag experiment
- Strategy: Decide quickly, iterate

**One-Way Door** (hard to reverse):
- High commitment, expensive to change
- Example: Database choice, programming language, cloud provider
- Strategy: Decide carefully, validate thoroughly

**Assessment criteria**:
- Migration effort (data, code, config)
- Team retraining needed
- User impact
- Cost of reversal

---

### Step 6: Consider Future Optionality

What doors does this open or close?

**Prompt**:
```
"If we choose [Option X], what options does that open
or close for the future?"
```

**Example**:
```
Decision: Serverless (AWS Lambda) vs. Kubernetes

Choose Serverless:
- Opens: Auto-scaling, pay-per-use, no infrastructure mgmt
- Closes: Custom runtime control, long-running processes,
           easy multi-cloud portability

Choose Kubernetes:
- Opens: Full control, multi-cloud, any runtime
- Closes: Simplicity, some auto-scaling ease

Which future matters more: simplicity or flexibility?
```

---

### Step 7: Define Success Criteria

How will you know if this decision was right?

**Prompt**:
```
"How will we measure whether this decision was successful?
What does good look like?"
```

**Template**:

**Success looks like**:
- [ ] [Measurable criterion 1]
- [ ] [Measurable criterion 2]
- [ ] [Measurable criterion 3]

**Failure indicators**:
- [ ] [Red flag 1]
- [ ] [Red flag 2]

**Review timeline**: [When to re-evaluate]

---

### Step 8: Make the Decision

State it clearly and unambiguously.

**Template**:
```
Decision: We will use [Option X: Name]

Rationale:
1. [Reason tied to driver 1]
2. [Reason tied to driver 2]
3. [Reason tied to driver 3]

We are NOT choosing [Option Y] because:
- [Specific reason]

We are NOT choosing [Option Z] because:
- [Specific reason]

Trade-offs we accept:
- [Downside 1 - we acknowledge and accept]
- [Downside 2 - we acknowledge and accept]

Reversibility: [Easy/Moderate/Difficult]
Cost if wrong: [Low/Medium/High]
```

---

## Creating ADRs

For significant decisions, create Architecture Decision Records.

### When to Create ADR

Create ADR when decision:
- [ ] Has significant impact on system structure
- [ ] Involved evaluation of multiple options
- [ ] Has meaningful reversal cost
- [ ] Will make future developers ask "why?"
- [ ] Affects multiple modules
- [ ] Establishes pattern others should follow

### ADR Workflow

1. Copy template: `.claude/design/templates/ADR_TEMPLATE.md`
2. Fill out all sections:
   - Context (why decision needed)
   - Decision drivers (what matters)
   - Options considered (3+ with pros/cons)
   - Decision (what was chosen)
   - Rationale (why this over alternatives)
   - Consequences (positive and negative)
   - Reversibility (how hard to change)
3. Save to: `docs/adr/ADR-NNN-title.md`
4. Link from design document

**Do this immediately**, while rationale is fresh.

---

## Documenting Outcomes

### Update Design Document

**Section 4: Decisions Made**

| ID | Decision | Choice | Rationale | ADR |
|----|----------|--------|-----------|-----|
| D-1 | Database | PostgreSQL | Team familiarity, ACID needs | [ADR-001](../../adr/ADR-001-postgresql.md) |

**Section 5: Options Under Consideration**
- [ ] Move decided option from "under consideration" to "decisions made"
- [ ] Remove from options list

---

### Create Session Notes

**Decisions Made**:
- [Decision 1]: [Choice] - [Brief rationale]

**ADRs Created**:
- [ADR-NNN]: [Link]

**Next Session Focus**: Detail phase or next decision

---

## Moving to Next Phase

### If More Decisions Needed

Loop back within Decision phase for each major decision.

**Pattern**:
```
Decision 1: Database choice → ADR-001
Decision 2: Caching strategy → ADR-002
Decision 3: API design → ADR-003
```

---

### When All Decisions Made

Advance to Detail phase:

```
/load-design-phase detail
```

---

## Examples

### Example 1: Decision with Clear Winner

```
User: "I need to decide: PostgreSQL vs. MongoDB"

Claude: "Let's apply your decision drivers:

Decision Drivers (your priorities):
1. Team familiarity (High priority)
2. ACID transactions (High priority)
3. Flexibility for schema changes (Medium priority)

Evaluation:

PostgreSQL:
- Driver 1: ++ (team knows SQL well)
- Driver 2: ++ (full ACID support)
- Driver 3: - (schema migrations required)

MongoDB:
- Driver 1: - (team needs to learn)
- Driver 2: - (weaker consistency guarantees)
- Driver 3: ++ (schema-less)

PostgreSQL wins on your top 2 drivers. The schema flexibility
trade-off is real, but given your priorities, PostgreSQL
appears to be the right choice.

Let me challenge this though: Are you sure ACID transactions
are truly required for your use case? If not, that changes
the calculation."

User: "Yes, we handle financial transactions - ACID is required"

Claude: "Then PostgreSQL is clearly the right choice. Create
ADR documenting:
- Decision: PostgreSQL
- Key driver: ACID requirements for financial transactions
- Acknowledged trade-off: Schema migration complexity
- Mitigation: Use migration tools like Flyway"
```

---

### Example 2: Close Decision

```
User: "I'm torn between Option A and Option B"

Claude: "When it's close, focus on your #1 decision driver.

Your top driver: Development velocity

Option A: Faster to build initially (2 weeks)
Option B: Faster to iterate long-term (easier changes)

Question: What matters more - time to first launch or
iteration speed over next year?

Also consider reversibility:
- Option A → Option B migration: Moderate effort (2-3 days)
- Option B → Option A migration: Difficult (1-2 weeks)

If uncertain, choose the more reversible option (A) and
iterate."
```

---

### Example 3: Decision Under Uncertainty

```
User: "I don't have enough data to decide confidently"

Claude: "When you lack data, you have a few strategies:

**Strategy 1: Gather data first**
- Prototype both options (1 day each)
- Load test with realistic data
- Measure actual performance
- Then decide based on evidence

**Strategy 2: Make reversible decision**
- Choose the easier-to-reverse option
- Ship it
- Gather real-world data
- Pivot if needed

**Strategy 3: Defer decision**
- Abstract behind interface
- Implement simplest option
- Swap implementation later when you have data

Which aligns with your timeline and risk tolerance?"
```

---

## Common Pitfalls

### Pitfall 1: Deciding Without Rationale

**Symptom**: "We chose X" but no documented why

**Fix**: Force explicit rationale:
```
"Why X over Y? Tie reasoning to decision drivers.
What would you tell a developer asking 'why X?' in 6 months?"
```

---

### Pitfall 2: Ignoring Trade-offs

**Symptom**: Only listing positives, hiding negatives

**Fix**: Explicitly acknowledge downsides:
```
"What are we giving up by choosing X?
What will be harder with X vs. alternatives?"
```

**Good ADR**: Lists both positive AND negative consequences

---

### Pitfall 3: Analysis Paralysis

**Symptom**: Endless evaluation, no decision

**Fix**: Set decision deadline:
```
"We've analyzed thoroughly. Given current information,
what's the best choice? We can course-correct later if
needed (it's a two-way door decision)."
```

---

### Pitfall 4: Overconfidence

**Symptom**: "This is obviously the best choice"

**Fix**: Force devil's advocate:
```
"Play devil's advocate. Why might this be wrong?
What am I not seeing?"
```

---

## Integration with cc-bootstrap

### After Decision Phase

- [ ] Create ADRs for significant decisions
- [ ] Update design document
- [ ] Link ADRs in design doc
- [ ] Transition to detail phase for next major component
- [ ] Keep Opus model

---

## Quick Reference

**Phase Goal**: Choose deliberately with documented rationale

**Key Prompts**:
- "I'm leaning toward X, challenge that"
- "Is this reversible?"
- "What's the cost of being wrong?"
- "How will we measure success?"

**Outputs**:
- Clear decision statement
- Explicit rationale tied to drivers
- ADR for significant decisions
- Acknowledged trade-offs

**Ready to Advance When**:
- All major decisions made
- Rationale documented in ADRs
- Trade-offs explicitly accepted
- Success criteria defined

**Next Phase**: `/load-design-phase detail`
