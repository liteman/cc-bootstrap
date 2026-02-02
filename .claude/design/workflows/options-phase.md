# Options Phase Workflow

> **Goal**: Survey the solution landscape before choosing a direction
>
> **Duration**: Usually 1-2 sessions
>
> **Outputs**: 3-5 alternatives with trade-offs documented
>
> **Model**: Opus (comparative analysis required)

---

## When to Use This Phase

Use Options phase after Requirements when:

- [ ] Requirements are clear
- [ ] Ready to explore solutions
- [ ] Multiple architectural approaches exist
- [ ] Need to compare alternatives objectively
- [ ] Want to avoid anchoring on first idea

**Key principle**: Neutral presentation, no recommendations yet

---

## Setting Options Mode

Load this phase:

```
/load-design-phase options
```

Tell Claude:

```
"Let's explore architectural options without deciding yet.
Present alternatives with trade-offs, no recommendations."
```

---

## Conversation Techniques

### Productive Prompts

| Say This | To Get This |
|----------|-------------|
| "What are fundamentally different approaches?" | Diverse options |
| "Compare X vs. Y for my situation" | Specific comparison |
| "What would push me toward each option?" | Decision criteria |
| "I'm leaning toward X, what alternatives exist?" | Avoid anchoring |
| "What's the spectrum of options?" | Full landscape |

### Anti-Patterns to Avoid

❌ **Don't**: "What's the best way to do X?" (asks for recommendation)

✅ **Do**: "What are different approaches to X with their trade-offs?"

❌ **Don't**: Accept first suggestion as final

✅ **Do**: "Before we commit, what are 2-3 alternatives?"

---

## Step-by-Step Process

### Step 1: Identify Decision Topics

What decisions need architectural options?

**Prompt**:
```
"Based on our requirements, what are the key architectural
decisions we need to make?"
```

**Common decision topics**:
- Data storage approach (SQL, NoSQL, hybrid)
- Communication pattern (sync, async, event-driven)
- Deployment model (monolith, microservices, serverless)
- Caching strategy (where, what, how)
- Authentication approach (sessions, JWT, OAuth)

**For each topic**: Explore options separately

---

### Step 2: Generate Options (3-5 per decision)

**Prompt template**:
```
"For [decision topic], what are 3-5 fundamentally different
approaches? Don't recommend - just present options with when
each makes sense."
```

**What Claude should provide**:

```
Option A: [Name]
- Description: [What it is]
- Works well when: [Conditions]
- Trade-off: [Cost]
- Example: [Concrete scenario]

Option B: [Name]
- Description: [What it is]
- Works well when: [Different conditions]
- Trade-off: [Different cost]
- Example: [Concrete scenario]

Option C: [Name]
- Description: [What it is]
- Works well when: [Third set of conditions]
- Trade-off: [Third cost]
- Example: [Concrete scenario]
```

**Aim for**: 3-5 options that span the solution space

---

### Step 3: Understand Trade-offs

For each option, understand what you gain and lose.

**Prompt**:
```
"For Option [X], what are the specific trade-offs?
What do we gain? What do we give up?"
```

**Trade-off categories**:

**Performance vs. Cost**:
- Faster = More expensive infrastructure
- Example: In-memory cache (fast, expensive) vs. Disk cache (slower, cheap)

**Flexibility vs. Simplicity**:
- Configurable = More complex
- Example: Plugin system (flexible, complex) vs. Built-in (simple, rigid)

**Speed vs. Quality**:
- Fast delivery = Technical debt
- Example: Quick MVP (fast, messy) vs. Proper architecture (slow, clean)

**Consistency vs. Availability**:
- Strong consistency = Lower availability
- Example: ACID database vs. Eventually consistent

---

### Step 4: Identify Decision Drivers

What factors matter most for YOUR situation?

**Prompt**:
```
"Given our constraints and requirements, what should drive
this decision? What matters most?"
```

**Common decision drivers**:
1. Team familiarity (can team maintain it?)
2. Operational simplicity (how hard to run?)
3. Cost at expected scale (affordable?)
4. Performance requirements (fast enough?)
5. Development speed (how fast to build?)
6. Flexibility for future changes (adaptable?)

**Rank by importance** for your situation

---

### Step 5: Map Options to Conditions

When would each option be the right choice?

**Prompt**:
```
"Under what conditions would each option be the best fit?"
```

**Template**:

**Option A** works best when:
- [ ] Condition 1
- [ ] Condition 2
- [ ] Condition 3

**Option B** works best when:
- [ ] Different condition 1
- [ ] Different condition 2

**Your conditions** (from requirements):
- [Check which option matches]

---

### Step 6: Research and Compare

For unfamiliar options, gather information.

**Prompt**:
```
"I'm unfamiliar with [Option X]. What should I know about
it before deciding? What are common pitfalls?"
```

**Research questions**:
- Learning curve (how hard to learn?)
- Community support (active? well-documented?)
- Maturity (production-ready? stable?)
- Lock-in (hard to migrate away from?)
- Hidden costs (licensing, operational complexity?)

---

## Documenting Outcomes

### Update Design Document

**Section 5: Options Under Consideration**

For each decision topic:

**Context**: Why this decision is needed

**Decision Drivers** (ranked):
1. [Most important factor]
2. [Second most important]
3. [Third most important]

**Option A**: [Name]
- Description: [What it is]
- Pros: [Specific benefits]
- Cons: [Specific drawbacks]
- When to choose: [Conditions]

**Option B**: [Name]
- Description: [What it is]
- Pros: [Specific benefits]
- Cons: [Specific drawbacks]
- When to choose: [Conditions]

**Option C**: [Name]
- Description: [What it is]
- Pros: [Specific benefits]
- Cons: [Specific drawbacks]
- When to choose: [Conditions]

**Current Lean**: [Which option you're leaning toward and why]

**Blocking Question**: [What you need to answer to decide]

---

### Create Session Notes

**Options Explored**:
- [List options for each decision]

**Trade-offs Identified**:
- [Key trade-offs discovered]

**Decision Drivers**:
- [What matters most in this decision]

**Next Session Focus**: Decision phase

---

## Moving to Next Phase

### Ready to Advance When

- [ ] 3+ viable options identified for each major decision
- [ ] Trade-offs explicitly documented for each option
- [ ] Decision drivers are clear and prioritized
- [ ] Conditions favoring each option are understood
- [ ] Enough information to make informed choice

### Not Ready If

- [ ] Only one option considered
- [ ] Trade-offs unclear or generic
- [ ] Don't understand when each option fits
- [ ] Missing critical information about options

**If not ready**: Continue exploring options

---

### Transition Command

```
/load-design-phase decision
```

---

## Examples

### Example 1: Database Options

```
User: "We need to choose a database"

Claude: "Let's explore options without deciding yet. Based on
your requirements (relational data, 10M+ rows, complex queries),
here are the main approaches:

**Option A: PostgreSQL (Relational SQL)**
- Description: Traditional RDBMS with ACID guarantees
- Works well when: Complex joins, strong consistency needed,
  team knows SQL, structured data
- Trade-off: Harder to scale horizontally, schema migrations
  can be complex
- Example: E-commerce with orders/products/users relationships

**Option B: MongoDB (Document NoSQL)**
- Description: Schema-flexible document database
- Works well when: Rapidly changing schema, nested data,
  horizontal scaling needed, eventual consistency OK
- Trade-off: Weaker consistency guarantees, complex joins
  are harder, team needs to learn new query language
- Example: Content management with varying document structures

**Option C: PostgreSQL + Read Replicas + Redis Cache**
- Description: Hybrid approach with read scaling and caching
- Works well when: Read-heavy workload, can accept slightly
  stale data for reads, PostgreSQL skills exist
- Trade-off: Operational complexity (managing replicas and
  cache), cache invalidation challenges
- Example: News site with heavy reads, occasional writes

Given your requirements - what's your read/write ratio?
How often does your schema change? How critical is
strong consistency?"
```

**Outcome**: 3 diverse options with clear trade-offs and decision questions

---

### Example 2: Comparing Specific Options

```
User: "Compare WebSockets vs. Server-Sent Events for real-time updates"

Claude: "Let me compare these options for your use case:

**WebSockets**
- Bidirectional, persistent connections
- Works well when:
  - Need client→server communication (not just server→client)
  - Very low latency required (< 100ms)
  - Many updates per second
  - Example: Collaborative editing, gaming, chat
- Trade-offs:
  - More complex to implement and scale
  - Connection management overhead
  - Proxy/firewall issues possible
  - Higher operational complexity

**Server-Sent Events (SSE)**
- Unidirectional (server→client only), HTTP-based
- Works well when:
  - Only server→client updates needed
  - Simpler than WebSockets is valuable
  - Automatic reconnection wanted
  - Example: Live feeds, stock tickers, notifications
- Trade-offs:
  - Unidirectional only (no client→server over same connection)
  - Browser connection limits (6 per domain typically)
  - Slightly higher latency than WebSockets

Decision drivers for your case:
1. Do you need client→server real-time? (WebSockets) or
   only server→client? (SSE OK)
2. How many updates per second? (<10 = SSE OK, 100+ = WebSockets better)
3. What's your latency requirement? (<50ms = WebSockets, <500ms = SSE OK)

What's your update frequency and do you need bidirectional?"
```

**Outcome**: Specific comparison with decision criteria

---

### Example 3: Avoiding Anchoring

```
User: "I think we should use microservices"

Claude: "Before we commit to microservices, let's explore the
full spectrum of options for your scaling problem:

**Option A: Optimized Monolith**
- Description: Improve current architecture with caching,
  better queries, vertical scaling
- Works well when: Problem is localized, team is small (<10),
  current architecture isn't fundamentally broken
- Trade-off: Doesn't solve if issue is team scaling or
  true architectural limits
- Effort: Low

**Option B: Modular Monolith**
- Description: Maintain single deployment but with strict
  module boundaries internally
- Works well when: Want better organization, easier testing,
  but don't need distributed deployment
- Trade-off: Still single deployment unit, all modules
  scale together
- Effort: Medium

**Option C: Selective Microservices**
- Description: Extract only the problematic parts as services,
  keep rest as monolith
- Works well when: Specific bottleneck identified, want to
  scale just that part independently
- Trade-off: Distributed system complexity, but only where
  needed
- Effort: Medium-High

**Option D: Full Microservices**
- Description: Break entire system into independently
  deployable services
- Works well when: Large team (20+), need independent scaling,
  clear bounded contexts exist
- Trade-off: Distributed system complexity (eventual consistency,
  network failures, monitoring), operational overhead
- Effort: High

What specifically isn't scaling in your current architecture?
What's your team size?"
```

**Outcome**: Prevented anchoring on initial idea, explored full spectrum

---

## Common Pitfalls

### Pitfall 1: Premature Recommendation

**Symptom**: Claude recommends option during options phase

**Fix**: Redirect to neutral presentation:
```
"Don't recommend yet. Present 2-3 more alternatives so I can
compare trade-offs objectively."
```

---

### Pitfall 2: Generic Trade-offs

**Symptom**: Vague pros/cons like "more flexible" or "easier"

**Fix**: Ask for specifics:
```
"What specifically is more flexible? Flexible in what way?
Easier for whom - developers or operators?"
```

✅ Better:
- "Schema changes don't require migrations" (specific flexibility)
- "Familiar to developers who know SQL" (specific ease)

---

### Pitfall 3: Only Considering One Option

**Symptom**: Jumping to "the obvious solution"

**Fix**: Force consideration of alternatives:
```
"Before we commit to [X], what are 2-3 fundamentally different
approaches? I want to understand what we're giving up."
```

---

### Pitfall 4: Analysis Paralysis

**Symptom**: Exploring too many options, no clear decision path

**Fix**: Focus on decision drivers:
```
"We've explored many options. Given our top 3 decision drivers -
[driver 1, 2, 3] - which 2-3 options best fit those drivers?"
```

Narrow from 5-7 options to top 2-3 before decision phase.

---

## Integration with cc-bootstrap

### Loading Context

Reference existing patterns:

```
/load-module [module]
```

See what options exist in codebase already.

---

### After Options Phase

- [ ] Update design document with options tables
- [ ] Document decision drivers clearly
- [ ] Narrow to top 2-3 options
- [ ] Prepare for decision phase
- [ ] Keep Opus model

---

## Quick Reference

**Phase Goal**: Survey solution landscape objectively

**Key Prompts**:
- "What are fundamentally different approaches?"
- "What are trade-offs of each?"
- "When would each option be best fit?"

**Outputs**:
- 3-5 options per major decision
- Explicit trade-offs for each
- Decision drivers (prioritized)
- Conditions favoring each option

**Ready to Advance When**:
- Multiple viable options documented
- Trade-offs are specific, not generic
- Decision drivers are clear
- Understand when each option fits

**Next Phase**: `/load-design-phase decision`
