# Requirements Phase Workflow

> **Goal**: Define boundaries and non-negotiables before exploring solutions
>
> **Duration**: Usually 1 session
>
> **Outputs**: Validated requirements, constraints, assumptions
>
> **Model**: Opus (deep reasoning required)

---

## When to Use This Phase

Use Requirements phase after Exploration when:

- [ ] Problem is understood
- [ ] Need to define what solution must DO (functional)
- [ ] Need to define what solution must BE (non-functional)
- [ ] Need to identify constraints (must work within)
- [ ] Need to validate assumptions

**Key principle**: Define boundaries without discussing implementation

---

## Setting Requirements Mode

Load this phase:

```
/load-design-phase requirements
```

Tell Claude:

```
"Let's define requirements and constraints without discussing
implementation yet. Challenge my assumptions."
```

---

## Conversation Techniques

### Productive Prompts

| Say This | To Get This |
|----------|-------------|
| "What are the must-haves vs. nice-to-haves?" | Requirement prioritization |
| "What non-functional requirements matter?" | Performance, security, scale needs |
| "What constraints does my environment impose?" | Team, tech, budget limitations |
| "Which requirements are assumptions?" | Assumption identification |
| "How will we validate this requirement?" | Testability check |

---

## Step-by-Step Process

### Step 1: Define Functional Requirements

What must the system **DO**?

**Prompt**:
```
"What are the functional requirements for [system]?
Let's list them without discussing implementation."
```

**Template** (in design document):

| ID | Requirement | Priority | Status |
|----|-------------|----------|--------|
| FR-1 | [Specific requirement] | Must | ⬜ Confirmed ⬜ Assumed |
| FR-2 | [Specific requirement] | Should | ⬜ Confirmed ⬜ Assumed |
| FR-3 | [Specific requirement] | Could | ⬜ Confirmed ⬜ Assumed |

**Priority levels**:
- **Must**: Non-negotiable, system fails without it
- **Should**: Important but system works without it
- **Could**: Nice-to-have, future enhancement

**Writing good requirements**:
- ✅ Specific: "User can reset password via email"
- ❌ Vague: "Authentication works well"

---

### Step 2: Define Non-Functional Requirements

What must the system **BE**?

**Categories to consider**:

**Performance**:
```
"What are the performance requirements?
- Expected request volume?
- Acceptable latency (p50, p99)?
- Throughput requirements?"
```

**Scalability**:
```
"What scale are we designing for?
- Current users/requests?
- Expected growth over 1 year? 3 years?
- Peak load scenarios?"
```

**Security**:
```
"What security requirements exist?
- Authentication/authorization needs?
- Data encryption requirements?
- Compliance standards (GDPR, SOC2, etc.)?"
```

**Availability**:
```
"What availability is required?
- Acceptable downtime?
- Recovery time objective (RTO)?
- Recovery point objective (RPO)?"
```

**Maintainability**:
```
"What are maintainability concerns?
- Team size and skills?
- Operational complexity tolerance?
- Debugging/monitoring needs?"
```

**Template**:

| ID | Requirement | Target | Status |
|----|-------------|--------|--------|
| NFR-1 | Latency (p99) | < 200ms | ⬜ Confirmed ⬜ Assumed |
| NFR-2 | Availability | 99.9% | ⬜ Confirmed ⬜ Assumed |
| NFR-3 | Security | SOC2 compliant | ⬜ Confirmed ⬜ Assumed |

---

### Step 3: Identify Constraints

What must you **work within**?

**Technical Constraints**:
```
"What technical constraints exist?
- Must use existing database?
- Must deploy to specific infrastructure?
- Must integrate with specific systems?"
```

**Team Constraints**:
```
"What team constraints exist?
- Current team skills?
- Team size and availability?
- Learning curve tolerance?"
```

**Timeline Constraints**:
```
"What timeline constraints exist?
- Hard deadlines (regulatory, market)?
- Preferred timeline?
- Negotiable vs. non-negotiable dates?"
```

**Budget Constraints**:
```
"What budget constraints exist?
- Infrastructure cost limits?
- Licensing costs?
- Can we add new paid services?"
```

**Template**:

| Constraint | Description | Negotiable? |
|------------|-------------|-------------|
| Technical | Must deploy to AWS | No |
| Team | Team knows Python, not Go | Partially |
| Timeline | MVP needed in 8 weeks | Yes |
| Budget | No new infrastructure costs | No |

---

### Step 4: Challenge Assumptions

Explicitly list and validate assumptions.

**Prompt**:
```
"Let's list all assumptions we're making:
- [Assumption 1]
- [Assumption 2]

For each: What's the risk if this assumption is wrong?
Which should we validate before proceeding?"
```

**Template**:

| ID | Assumption | Risk if Wrong | Validated? |
|----|------------|---------------|------------|
| A-1 | Users have modern browsers | Site breaks for 20% of users | ⬜ Yes ⬜ No |
| A-2 | Traffic doubles in 6 months | Over-engineering / Under-engineering | ⬜ Yes ⬜ No |

**For critical assumptions**:
```
"This assumption - '[X]' - is critical. How can we validate it
before we build on it?"
```

**Validation strategies**:
- User research
- Analytics review
- Prototype testing
- Stakeholder confirmation

---

### Step 5: Validate Requirements are Testable

Each requirement should be measurable/testable.

**For each requirement, ask**:
```
"How will we verify that this requirement is met?
What does 'done' look like?"
```

**Examples**:

❌ **Bad** (untestable):
- "System should be fast"
- "Security should be good"
- "Users should be happy"

✅ **Good** (testable):
- "API latency p99 < 200ms (tested with k6)"
- "All API endpoints require authentication (tested with security scan)"
- "NPS score > 50 (measured via survey)"

---

### Step 6: Identify Conflicting Requirements

Look for requirements that conflict.

**Prompt**:
```
"Are any of these requirements in conflict?
For example: low latency vs. strong consistency,
low cost vs. high availability?"
```

**Common conflicts**:
- Performance vs. Cost (fast = expensive)
- Speed vs. Quality (fast delivery = technical debt)
- Security vs. Usability (secure = more friction)
- Flexibility vs. Simplicity (configurable = complex)

**When conflicts exist**:
1. Make the conflict explicit
2. Define trade-off decision
3. Document in ADR

**Example**:
```
Conflict: "Sub-100ms latency" vs. "Strong consistency"

Trade-off: Accept eventual consistency for reads,
strong consistency only for writes

Document: Create ADR for consistency model choice
```

---

## Documenting Outcomes

### Update Design Document

**Section 2: Requirements & Constraints**

**Functional Requirements** table:
- [ ] All must-haves identified
- [ ] Priorities assigned
- [ ] Confirmed vs. assumed marked

**Non-Functional Requirements** table:
- [ ] Performance targets
- [ ] Security requirements
- [ ] Scalability targets
- [ ] Availability requirements

**Constraints** table:
- [ ] Technical constraints
- [ ] Team constraints
- [ ] Timeline constraints
- [ ] Budget constraints

**Assumptions** table:
- [ ] All assumptions explicit
- [ ] Risks if wrong identified
- [ ] Validation status marked

---

### Create Session Notes

**What We Defined**:
- [Requirements finalized]

**Assumptions to Validate**:
- [Critical assumptions needing validation]

**Conflicts Identified**:
- [Conflicting requirements and trade-offs]

**Next Session Focus**: Options phase

---

## Moving to Next Phase

### Ready to Advance When

- [ ] Functional requirements are specific and testable
- [ ] Non-functional requirements have measurable targets
- [ ] Constraints are explicit
- [ ] Assumptions are documented with validation plan
- [ ] Requirement conflicts are identified and resolved
- [ ] Priorities are clear (must/should/could)

### Not Ready If

- [ ] Requirements are vague ("should work well")
- [ ] No measurable success criteria
- [ ] Assumptions hidden or unexamined
- [ ] Unclear what's negotiable vs. non-negotiable

**If not ready**: Continue requirements definition

---

### Transition Command

```
/load-design-phase options
```

---

## Examples

### Example 1: Good Requirements Conversation

```
User: "For the notification system, we need it to be fast"

Claude: "Let's make that specific and testable. A few questions:

- What's 'fast' in this context? Milliseconds? Seconds?
- Is this latency (time to deliver) or throughput (notifications/sec)?
- At what scale? 100 users or 100,000 users?
- Is this a hard requirement or a goal?"

User: "Good point. Notifications should be delivered within 5 seconds
of the triggering event, even at peak load of 10,000 concurrent users."

Claude: "Perfect, that's testable. So:

NFR-1: Notification latency < 5 seconds (p99)
NFR-2: Support 10,000 concurrent users

Is 5 seconds confirmed by users or is it an assumption?"

User: "Assumption based on what I think they expect"

Claude: "Let's mark that as an assumption to validate:

A-1: Users expect <5sec notification delivery
Risk if wrong: Over-engineering (if they're OK with 30sec)
              or under-engineering (if they need real-time)
Validation: User survey or interview"
```

**Outcome**: Specific, testable requirement with validation plan

---

### Example 2: Identifying Constraints

```
User: "We need to build this feature"

Claude: "Before we explore solutions, what constraints exist?

Technical: What infrastructure must you use?
Team: What technologies does your team know?
Timeline: Any hard deadlines?
Budget: Any cost limitations?"

User: "We must deploy to our existing Kubernetes cluster,
team knows Node.js and Python but not Go, we need an MVP
in 6 weeks for a demo, and we can't add expensive new services."

Claude: "Let me capture those:

Constraints:
- Technical: Must deploy to existing K8s cluster (non-negotiable)
- Team: Team knows Node.js/Python, not Go (partially negotiable - could learn)
- Timeline: MVP needed in 6 weeks (partially negotiable - demo date might move)
- Budget: No expensive new services (non-negotiable)

These constraints will narrow our options later. For the team
constraint - is there appetite to learn a new language if it's
clearly the best solution, or should we stick to Node/Python?"
```

**Outcome**: Constraints explicitly documented, negotiability clarified

---

### Example 3: Challenging Assumptions

```
User: "We're assuming PostgreSQL can handle our scale"

Claude: "Let's validate that assumption. A few questions:

- What's your current scale? (rows, queries/sec, data size)
- What's your projected scale in 6 months? 1 year?
- What specific operations are you concerned about?
- Have you profiled current performance?

The risk if this assumption is wrong is significant - database
migrations are expensive and disruptive. How can we validate
this before committing to the design?"

User: "Current: 1M rows, 100 QPS. Projected: 50M rows, 1000 QPS
in 1 year. Concerned about complex reporting queries."

Claude: "That's a 50x growth in rows, 10x in QPS. I'd recommend:

Validation strategy:
1. Load test current schema with projected data volume
2. Profile slow queries with realistic data size
3. Research PostgreSQL limits for your query patterns
4. Consider whether read replicas could handle scale

Let's mark this assumption as critical to validate before
choosing architectural options."
```

**Outcome**: Critical assumption identified with validation plan

---

## Common Pitfalls

### Pitfall 1: Implementation Creep

**Symptom**: Discussing HOW instead of WHAT

```
❌ "We'll use Redis for caching..." (HOW)
✅ "Response time must be < 100ms" (WHAT)
```

**Fix**: Redirect to requirements:
```
"Let's not discuss implementation yet. What's the actual
requirement we're trying to meet?"
```

---

### Pitfall 2: Vague Requirements

**Symptom**: Requirements that can't be tested

```
❌ "System should be reliable"
❌ "Performance should be good"
❌ "Users should be satisfied"
```

**Fix**: Make specific and measurable:
```
✅ "System uptime > 99.9%"
✅ "API latency p99 < 200ms"
✅ "NPS score > 50"
```

---

### Pitfall 3: Assuming Requirements are Facts

**Symptom**: Treating assumptions as validated requirements

**Fix**: For each requirement, ask:
```
"Is this confirmed by users/stakeholders, or is it an assumption?"
```

Mark accordingly in requirements table.

---

## Integration with cc-bootstrap

### Loading Context

Reference existing architecture:

```
/load-module [module]
```

Check what requirements existing modules satisfy.

---

### After Requirements

- [ ] Update design document with requirements tables
- [ ] Create validation plan for critical assumptions
- [ ] Prepare constraints for options phase
- [ ] Keep Opus model

---

## Quick Reference

**Phase Goal**: Define boundaries without implementation

**Key Prompts**:
- "What must this DO?" (functional)
- "What must this BE?" (non-functional)
- "What must we work within?" (constraints)
- "Which are assumptions vs. facts?"

**Outputs**:
- Functional requirements (prioritized)
- Non-functional requirements (measurable)
- Constraints (with negotiability)
- Assumptions (with validation plan)

**Ready to Advance When**:
- Requirements are specific and testable
- Assumptions are explicit
- Constraints are documented
- Conflicts are identified

**Next Phase**: `/load-design-phase options`
