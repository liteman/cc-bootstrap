# Validation Phase Workflow

> **Goal**: Find gaps before implementing
>
> **Duration**: Usually 1 session
>
> **Outputs**: Risk assessment, gap identification, design validation
>
> **Model**: Opus (adversarial thinking required)

---

## When to Use This Phase

Use Validation phase after Detail when:

- [ ] Design appears complete
- [ ] Ready to implement
- [ ] Want to find issues before coding
- [ ] Need final sanity check
- [ ] Want to identify risks

**Key principle**: Challenge the design, find what could go wrong

---

## Setting Validation Mode

Load this phase:

```
/load-design-phase validation
```

Tell Claude:

```
"Here's my complete design: [summary]. Challenge it.
What could go wrong? What am I not thinking about?"
```

---

## Conversation Techniques

### Productive Prompts

| Say This | To Get This |
|----------|-------------|
| "What could go wrong?" | Failure mode analysis |
| "Where are the weak points?" | Vulnerability identification |
| "Challenge this design" | Adversarial review |
| "What happens when X fails?" | Resilience testing |
| "Does this solve the original problem?" | Requirements trace |

---

## Step-by-Step Process

### Step 1: Requirements Trace

Does design actually solve the original problem?

**Prompt**:
```
"Let's verify this design solves our original problem.
Trace each requirement to a component."
```

**Create trace matrix**:

| Requirement | Component | How Satisfied | Verified? |
|-------------|-----------|---------------|-----------|
| FR-1: User authentication | Auth Service | JWT tokens | ✅ |
| FR-2: Password reset | Email Worker | Async jobs | ✅ |
| NFR-1: <200ms latency | Caching layer | Redis cache | ⚠️ Need to validate |

**For each**:
- ✅ Clearly satisfied
- ⚠️ Needs validation/testing
- ❌ Not addressed (gap!)

**If gaps found**: Return to design, address missing requirements

---

### Step 2: Failure Mode Analysis

What can fail and how badly?

**Prompt**:
```
"Walk me through failure scenarios:
- What happens when [component X] fails?
- What happens when database is down?
- What happens when network is slow?
- What happens under high load?"
```

**For each component, identify**:

**Failure modes**:
- Component crashes
- Component slows down
- Component returns errors
- Component is unreachable

**Impact**:
- System fails completely (critical)
- Degraded functionality (major)
- Minor inconvenience (minor)

**Mitigation**:
- Redundancy
- Fallbacks
- Circuit breakers
- Graceful degradation

**Template**:

| Component | Failure Mode | Impact | Likelihood | Mitigation |
|-----------|--------------|--------|------------|------------|
| Auth Service | Crashes | Users can't login | Low | Health checks, auto-restart, redundant instances |
| Database | Slows down | High latency | Medium | Connection pooling, query timeout, read replicas |
| Email Worker | Queue full | Password resets delayed | Medium | Increase queue size, monitoring alerts |

---

### Step 3: Single Point of Failure Analysis

Where are the bottlenecks?

**Prompt**:
```
"Where are the single points of failure in this design?
What component, if it fails, breaks everything?"
```

**Common SPOFs**:
- Single database instance
- Single API server
- Shared authentication service
- Central configuration store
- Single network path

**For each SPOF**:
- [ ] Can we eliminate it? (redundancy)
- [ ] Can we mitigate it? (fallback)
- [ ] Can we accept it? (low probability * low impact = acceptable risk)

---

### Step 4: Security Review

What are the security vulnerabilities?

**Prompt**:
```
"Review this design for security issues. What would
an attacker target? Where are the vulnerabilities?"
```

**Security checklist**:

**Authentication/Authorization**:
- [ ] All endpoints require authentication?
- [ ] Authorization checks at every layer?
- [ ] Token expiry and refresh handled?
- [ ] Password storage secure (bcrypt, not plain text)?

**Input Validation**:
- [ ] All user input validated?
- [ ] SQL injection prevented (parameterized queries)?
- [ ] XSS prevented (output encoding)?
- [ ] CSRF protection in place?

**Data Protection**:
- [ ] Sensitive data encrypted at rest?
- [ ] Sensitive data encrypted in transit (TLS)?
- [ ] PII handling compliant (GDPR, etc.)?
- [ ] Secrets managed securely (not in code)?

**Access Control**:
- [ ] Principle of least privilege applied?
- [ ] API rate limiting in place?
- [ ] Audit logging for sensitive operations?

---

### Step 5: Performance Bottleneck Analysis

Where will this be slow?

**Prompt**:
```
"Where are the performance bottlenecks in this design?
What will be slow under load?"
```

**Common bottlenecks**:

**Database**:
- Complex queries without indexes
- N+1 query problems
- Unbounded result sets
- Lock contention

**Network**:
- Chatty APIs (many small requests)
- Large payloads
- Synchronous calls in sequence
- No caching

**Computation**:
- Heavy processing in request path
- Inefficient algorithms
- No pagination
- Memory leaks

**For each bottleneck**:
- [ ] Measure expected load
- [ ] Identify breaking point
- [ ] Plan mitigation (caching, async, optimization)

---

### Step 6: Operational Complexity Review

How hard will this be to run?

**Prompt**:
```
"Review operational complexity. What will be hard to:
- Deploy?
- Monitor?
- Debug?
- Scale?"
```

**Deployment**:
- How many components to deploy?
- Dependencies between deployments?
- Database migration strategy?
- Rollback procedure?

**Monitoring**:
- What metrics to track?
- How to detect issues?
- Alert thresholds?
- Logging strategy?

**Debugging**:
- Distributed tracing in place?
- How to correlate logs across services?
- How to reproduce issues?
- Access to production data?

**Scaling**:
- Which components scale horizontally?
- Which have state?
- Auto-scaling configured?
- Cost of scaling?

---

### Step 7: Edge Case Review

Are all edge cases handled?

**Prompt**:
```
"What edge cases might we have missed?
- Empty states?
- Maximum limits?
- Race conditions?
- Time-based issues?"
```

**Common missed edge cases**:

**Empty States**:
- What if no data exists?
- What if list is empty?
- What if user has no permissions?

**Boundary Conditions**:
- What's the maximum size?
- What happens at exactly 0?
- What happens at exactly limit?

**Timing Issues**:
- What if request arrives during deployment?
- What if session expires mid-operation?
- What if two users update simultaneously?

**Data Issues**:
- What if data is corrupt?
- What if data violates constraints?
- What if data format changes?

---

### Step 8: Maintainability Review

Will future developers thank or curse you?

**Prompt**:
```
"Will this design be maintainable? Think about:
- Code complexity
- Team skills
- Documentation
- Testing strategy"
```

**Complexity**:
- Is architecture simple enough to understand?
- Are patterns consistent?
- Are abstractions appropriate (not over-engineered)?

**Team Skills**:
- Can current team maintain this?
- What if key person leaves?
- Learning curve for new members?

**Documentation**:
- Are decisions documented (ADRs)?
- Are interfaces clear?
- Are edge cases documented?

**Testing**:
- Can components be tested independently?
- Are test scenarios defined?
- Is test data available?

---

## Documenting Outcomes

### Update Design Document

**Section 7: Risks & Mitigations**

| ID | Risk | Likelihood | Impact | Mitigation | Status |
|----|------|------------|--------|------------|--------|
| R-1 | Database SPOF | Low | High | Add read replicas | ⬜ Open |
| R-2 | Password reset queue overflow | Medium | Low | Increase queue size, monitor | ⬜ Mitigated |

**For each risk**:
- Identify
- Assess (likelihood × impact)
- Plan mitigation
- Track status (Open / Mitigated / Accepted)

---

### Create Session Notes

**Risks Identified**:
- [List risks discovered]

**Gaps Found**:
- [Requirements not met]
- [Missing components]

**Validation Status**:
- ✅ Design validates
- ⚠️ Issues found, need addressing
- ❌ Major gaps, return to earlier phase

---

## Moving to Implementation

### When Validation Passes

```
/finalize-design
```

This checks:
- [ ] All requirements traced to components
- [ ] Major risks have mitigations
- [ ] ADRs created for key decisions
- [ ] Architecture documented

**Then transition**:
- [ ] Update `.claude/architecture.md`
- [ ] Create/update module guides
- [ ] Run `/write-plan` (Superpowers)
- [ ] Switch to Sonnet model
- [ ] Load `/load-workflow feature-development`

---

### When Validation Fails

**If critical gaps found**: Return to earlier phase

- Missing requirements → Back to Requirements phase
- Unclear decisions → Back to Decision phase
- Insufficient detail → Back to Detail phase

**Fix gaps**, then re-validate

---

## Examples

### Example 1: Failure Mode Analysis

```
User: "Validate my authentication design"

Claude: "Let's test failure scenarios:

**Scenario 1: Auth Service crashes**
- Impact: All login attempts fail immediately
- Current design: Single instance
- Recommendation: Add redundant instances with load balancer
- Mitigation status: ⚠️ Need to add

**Scenario 2: Database connection pool exhausted**
- Impact: Auth requests hang, then timeout
- Current design: No connection limit
- Recommendation: Set pool size limit, implement queue with timeout
- Mitigation status: ⚠️ Need to add

**Scenario 3: Token signing key compromised**
- Impact: Attacker can forge tokens
- Current design: Single key, no rotation
- Recommendation: Implement key rotation, revocation list
- Mitigation status: ❌ Critical gap

You have 1 critical gap (key management) that must be addressed
before implementation."
```

---

### Example 2: Security Review

```
User: "Is this design secure?"

Claude: "Security review findings:

✅ **Strengths**:
- Passwords hashed with bcrypt
- HTTPS enforced
- Input validation present

⚠️ **Concerns**:
- No rate limiting on login endpoint (brute force vulnerability)
- Session tokens don't expire (XSS impact)
- No CSRF protection on state-changing operations

❌ **Critical Issues**:
- Database connection string in code (credentials exposed)
- No SQL injection prevention (uses string concatenation)

Before implementing, you must:
1. Move secrets to environment variables
2. Use parameterized queries (critical)
3. Add rate limiting (important)
4. Add token expiry (important)
5. Consider CSRF tokens (nice-to-have)"
```

---

### Example 3: Requirements Trace

```
User: "Does this design meet all requirements?"

Claude: "Let's trace each requirement:

| Requirement | Met? | How? | Validation Needed? |
|-------------|------|------|-------------------|
| FR-1: User login | ✅ | Auth Service | Test with load |
| FR-2: Password reset | ✅ | Email Worker | Verify email delivery |
| NFR-1: <200ms latency | ⚠️ | Caching planned | Need load test to confirm |
| NFR-2: 99.9% uptime | ❌ | No redundancy | Gap: Need HA architecture |

Gap identified: NFR-2 (99.9% uptime) not met with current design.

Recommendation: Add redundancy to critical components before
proceeding to implementation."
```

---

## Common Pitfalls

### Pitfall 1: Yes-Man Validation

**Symptom**: Only confirming design is good, not finding issues

**Fix**: Force adversarial thinking:
```
"Don't tell me it's good. Tell me what's wrong.
What will break? What did I miss?"
```

---

### Pitfall 2: Superficial Review

**Symptom**: Generic issues like "could be more scalable"

**Fix**: Demand specifics:
```
"What specifically will break at scale? At what point?
What exact component? What exact failure mode?"
```

---

### Pitfall 3: Ignoring Operational Complexity

**Symptom**: Design looks good on paper, nightmare to run

**Fix**: Review operational aspects:
```
"How will we:
- Deploy this?
- Monitor for issues?
- Debug production problems?
- Scale under load?"
```

---

## Integration with cc-bootstrap

### After Validation

- [ ] Update risks table in design document
- [ ] Address critical gaps
- [ ] Create final ADRs if needed
- [ ] Run `/finalize-design`
- [ ] Update architecture.md
- [ ] Transition to implementation

---

## Quick Reference

**Phase Goal**: Find gaps before implementing

**Key Prompts**:
- "What could go wrong?"
- "Where are single points of failure?"
- "What security vulnerabilities exist?"
- "Does this meet all requirements?"

**Outputs**:
- Risk assessment with mitigations
- Requirements trace (all requirements met)
- Security review findings
- Failure mode analysis
- Go/no-go decision

**Ready to Implement When**:
- All requirements traced
- Critical risks mitigated
- Security review passed
- No major gaps identified

**Next**: `/finalize-design` → Implementation
