# Exploration Phase Workflow

> **Goal**: Understand the problem space before proposing solutions
>
> **Duration**: Usually 1-2 sessions
>
> **Outputs**: Refined problem statement, scope boundaries, initial questions
>
> **Model**: Opus (deep reasoning required)

---

## When to Use This Phase

Start with Exploration when:

- [ ] Problem statement is vague or unclear
- [ ] Starting a new feature with unclear architecture
- [ ] Multiple stakeholders with different needs
- [ ] Unsure what success looks like
- [ ] Haven't validated the problem is worth solving
- [ ] Solution space is wide open

**Key principle**: No solutions yet. Pure problem understanding.

---

## Setting Exploration Mode

Tell Claude explicitly:

```
"Before we discuss solutions, help me understand the problem space.
What questions should we answer first?"
```

Or load this phase:

```
/load-design-phase exploration
```

---

## Conversation Techniques

### Productive Prompts

| Say This | To Get This |
|----------|-------------|
| "What are we actually solving?" | Problem framing |
| "Challenge my assumptions" | Assumption identification |
| "What am I missing?" | Gap analysis |
| "Who is affected?" | Stakeholder identification |
| "What happens if we don't solve this?" | Impact assessment |
| "What's the current pain point?" | Root cause exploration |

### Anti-Patterns to Avoid

❌ **Don't**: "Design a solution for X" (skips exploration)

✅ **Do**: "Help me understand what X really needs to do"

❌ **Don't**: "I need to build a microservices architecture"

✅ **Do**: "We're having scaling issues. Help me understand the problem before we discuss solutions"

---

## Step-by-Step Process

### Step 1: State Initial Understanding

Share your current (possibly incomplete) understanding:

**Prompt template**:
```
"Here's my understanding of the problem:
- [What you think the problem is]
- [Why you think it needs solving]
- [Who it affects]

What am I missing? What assumptions am I making?"
```

**Claude should respond with**: Clarifying questions, not solutions

---

### Step 2: Frame the Problem

Work with Claude to refine the problem statement.

**Good prompts**:
```
"I think I need to build [X]. Before we design anything, help me
understand the problem. What questions should I be asking?"
```

```
"The current pain point is [X]. Is that the root problem or
a symptom of something else?"
```

**What to capture** (in design document):
- Problem statement (user/business terms, not technical)
- Who is affected (users, stakeholders, teams)
- Why it matters (impact if unsolved)
- Current workarounds (what people do now)

---

### Step 3: Identify Stakeholders

**Prompt**:
```
"Who is affected by this problem? Who cares if we solve it?"
```

**What to capture**:
- Primary users (who directly experiences the problem)
- Secondary stakeholders (who benefits from solution)
- Affected systems/teams (what depends on this)

**Example**:
- Primary: End users can't complete checkout
- Secondary: Customer support gets complaints
- Affected: Payment system, order processing team

---

### Step 4: Challenge Assumptions

Explicitly list assumptions, then question them.

**Prompt**:
```
"Let me list my assumptions:
- [Assumption 1]
- [Assumption 2]
- [Assumption 3]

Which of these should I validate before proceeding?"
```

**For each assumption, ask**:
```
"I'm assuming [X]. Is that safe? What breaks if it's wrong?"
```

**What to capture** (in design document):
| Assumption | Risk if Wrong | Validated? |
|------------|---------------|------------|
| [Assumption] | [Impact] | ⬜ Yes ⬜ No |

---

### Step 5: Define Scope Boundaries

What's IN scope and what's OUT.

**Prompt**:
```
"Help me define boundaries. What should be in scope for solving
this problem, and what should explicitly be out of scope?"
```

**Template**:
```
In scope:
- [Item 1]
- [Item 2]

Out of scope (for now):
- [Item 1 - and why]
- [Item 2 - and why]

Maybe in scope (decide later):
- [Item 1]
```

**Why OUT is important**: Prevents scope creep, focuses effort

---

### Step 6: Define Success Criteria

How will you know the problem is solved?

**Prompt**:
```
"What does success look like? How will we measure whether
this problem is actually solved?"
```

**What to capture**:
- Measurable outcomes (not "better", but "X% improvement in Y")
- User impact (what changes for users)
- Business impact (what changes for organization)

**Example**:
- Users can complete checkout in < 30 seconds (vs. current 2 minutes)
- Checkout abandonment drops from 40% to <10%
- Support tickets about checkout drop by 80%

---

### Step 7: Validate the Problem

Before moving to solutions, confirm the problem is worth solving.

**Prompts**:
```
"Is this problem worth solving? What's the cost of NOT solving it?"
```

```
"Are there simpler ways to address the pain without building anything new?"
```

**Reality check questions**:
- Is this a real problem or a perceived problem?
- Is it widespread or affecting only a few users?
- What's the business case?
- Are there workarounds that might be "good enough"?

---

## Documenting Outcomes

### Update Design Document

In your design document (`.claude/design/templates/DESIGN_DOCUMENT.md`):

**Section 1: Problem Statement**
- [ ] What Are We Solving? (refined through exploration)
- [ ] Why Does This Matter? (impact if unsolved)
- [ ] What's NOT In Scope? (boundaries)

**Section 2: Requirements & Constraints**
- [ ] Assumptions table (with validation status)

**Section 3: Open Questions**
- [ ] List questions raised during exploration

**Section 8: Session Log**
- [ ] Document this session's focus and outcomes

---

### Create Session Notes

Use `.claude/design/templates/SESSION_NOTES.md`:

**What We Learned**:
- [New understanding gained]

**Open Questions Identified**:
- [Questions that need answers]

**Next Session Focus**: Requirements phase

---

## Moving to Next Phase

### Ready to Advance When

- [ ] Problem statement is clear and specific (not vague)
- [ ] Scope boundaries are defined (in/out of scope)
- [ ] Stakeholder needs are identified
- [ ] Core assumptions are explicit
- [ ] Success criteria are measurable
- [ ] Problem is validated as worth solving

### Not Ready If

- [ ] Still unclear what problem you're solving
- [ ] Assumptions hidden or unexamined
- [ ] Scope is unbounded ("make everything better")
- [ ] No clear success criteria

**If not ready**: Continue exploration for another session

---

### Transition Command

```
/load-design-phase requirements
```

---

## Examples

### Example 1: Good Exploration Conversation

```
User: "I want to add real-time notifications to our app"

Claude: "Before we discuss how to implement notifications, let me
make sure I understand the problem. A few questions:

- What triggers these notifications? User actions, time-based
  events, external systems?
- Who receives them? All users, specific segments?
- Where do they appear? In-app only, email, push, SMS?
- How time-sensitive? Real-time, near-real-time, eventual?
- What's the current pain point that notifications would solve?"

User: "Good questions. Currently users miss important updates
because they have to manually refresh. We want to notify them
immediately when something changes in their account."

Claude: "OK, so the root problem is users miss important updates
due to manual refresh requirement. Let's dig deeper:

- What kind of updates? Account changes, new messages,
  system events?
- How often do users miss these? Is this a frequent pain point?
- What's the impact when they miss an update? Annoyance or
  actual harm?
- Have users asked for this, or is it assumed they want it?"

[Conversation continues until problem is well-understood]
```

**Outcome**: Clear problem statement before any solution discussion

---

### Example 2: Poor Exploration (What Not to Do)

```
User: "I want to add real-time notifications"

Claude: "I recommend using WebSockets with Socket.io. Here's
how we'll architect it..."
```

❌ **Problem**: Jumped to solution without understanding the problem

**Should have**: Asked clarifying questions first

---

### Example 3: Challenging Assumptions

```
User: "We need microservices because we're scaling"

Claude: "Let me challenge that assumption. You mentioned scaling
as the reason for microservices. A few questions:

- What specifically isn't scaling? Database? Compute?
  Development velocity?
- What's your current team size?
- Have you tried vertical scaling or optimizing current
  architecture?
- What's your current request volume and what's the target?"

User: "Good point. Our issue is actually slow database queries,
not compute. Team is 5 people."

Claude: "With a 5-person team and a database performance issue,
microservices might add more complexity than they solve. Let's
explore the database problem specifically. What queries are slow?"
```

**Outcome**: Identified real problem (database queries) vs. assumed solution (microservices)

---

## Common Pitfalls

### Pitfall 1: Solution-Oriented Exploration

**Symptom**: Conversation drifts to "how to build" instead of "what to solve"

**Fix**: Redirect with:
```
"Let's pause on solutions. I still don't fully understand the
problem. Can we explore [aspect] more?"
```

---

### Pitfall 2: Accepting First Problem Statement

**Symptom**: Taking initial problem statement at face value

**Fix**: Ask "why" repeatedly:
```
"You mentioned [problem]. Why is that a problem?"
[Answer]
"And why is that important?"
[Answer]
"What's the root cause?"
```

**Example**:
- "We need faster page load" (symptom)
  - Why? "Users complain it's slow"
  - Why do they complain? "They abandon before conversion"
  - Root problem: **Conversion loss due to performance**

---

### Pitfall 3: Skipping Validation

**Symptom**: Assuming problem is worth solving without evidence

**Fix**: Ask:
```
"Before we invest in solving this, what evidence do we have
that it's a real problem? How many users are affected?
What's the cost of not solving it?"
```

---

## Integration with cc-bootstrap

### Loading Context

Before exploration, load relevant context:

```
/load-module [relevant-module]
```

This helps understand existing architecture that might be affected.

---

### After Exploration

- [ ] Update design document with refined problem statement
- [ ] Create session notes
- [ ] Transition to requirements phase
- [ ] Keep Opus model (still in design mode)

---

## Quick Reference

**Phase Goal**: Understand problem before solutions

**Key Prompts**:
- "What are we actually solving?"
- "Challenge my assumptions"
- "What am I missing?"

**Outputs**:
- Refined problem statement
- Scope boundaries (in/out)
- Explicit assumptions
- Success criteria

**Ready to Advance When**:
- Problem is clear
- Scope is defined
- Assumptions are explicit
- Success is measurable

**Next Phase**: `/load-design-phase requirements`
