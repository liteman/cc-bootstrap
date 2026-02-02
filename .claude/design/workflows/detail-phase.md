# Detail Phase Workflow

> **Goal**: Flesh out specific components after high-level decisions are made
>
> **Duration**: Usually 1-2 sessions per component
>
> **Outputs**: Component specifications, interfaces, data flows
>
> **Model**: Opus (deep technical reasoning)

---

## When to Use This Phase

Use Detail phase after Decision when:

- [ ] High-level architecture is decided
- [ ] Ready to detail specific components
- [ ] Need to define interfaces
- [ ] Need to work through data flows
- [ ] Need to handle edge cases

**Key principle**: Deep dive on specifics, one component at a time

---

## Setting Detail Mode

Load this phase:

```
/load-design-phase detail
```

Tell Claude:

```
"I've decided on [high-level approach]. Now let's detail
the [specific component]. What does this look like concretely?"
```

---

## Conversation Techniques

### Productive Prompts

| Say This | To Get This |
|----------|-------------|
| "Walk me through the data flow for [scenario]" | Step-by-step flow |
| "What's the interface between A and B?" | Contract definition |
| "How should I handle [edge case]?" | Edge case handling |
| "What are the component responsibilities?" | Clear boundaries |
| "What can go wrong here?" | Failure modes |

---

## Step-by-Step Process

### Step 1: Identify Components

Break architecture into manageable components.

**Prompt**:
```
"Based on our architecture, what are the main components
we need to detail?"
```

**For each component, detail**:
- Responsibility (what it does)
- Dependencies (what it needs)
- Dependents (who needs it)

**Table in design document**:

| Component | Responsibility | Dependencies | Status |
|-----------|---------------|--------------|--------|
| Auth Service | User authentication | User DB | ⬜ Designed ⬜ Detailed |
| API Gateway | Request routing | All services | ⬜ Designed ⬜ Detailed |

**Detail one at a time**: Focus session on single component

---

### Step 2: Define Component Responsibility

What should this component do (and NOT do)?

**Prompt**:
```
"For [Component X], what's its specific responsibility?
What should it do and what should it NOT do?"
```

**Template**:

**Component: [Name]**

**Responsibility**:
- [What it does]

**NOT Responsible For**:
- [What it doesn't do - important for boundaries]

**Example**:

**Component: Auth Service**

**Responsibility**:
- Validate user credentials
- Issue authentication tokens
- Verify token validity

**NOT Responsible For**:
- Authorization/permissions (handled by each service)
- User profile management (separate service)
- Password reset email sending (job queue handles)

---

### Step 3: Define Data Flow

How does data move through this component?

**Prompt**:
```
"Walk me through the data flow for [specific scenario].
What are the steps from input to output?"
```

**Format**: Step-by-step with examples

**Example: Login Flow**

```
1. User submits credentials
   Input: { email: "user@example.com", password: "***" }

2. Auth Service validates credentials
   - Hash password
   - Query user database
   - Compare hashed passwords

3. On success, generate token
   - Create JWT with user ID + expiry
   - Sign with secret key
   Output: { token: "eyJ...", expiresIn: 3600 }

4. On failure, return error
   Output: { error: "Invalid credentials", code: 401 }
```

**Cover**:
- Happy path
- Error paths
- Edge cases

---

### Step 4: Define Interfaces

What's the contract between components?

**Prompt**:
```
"What's the interface between [Component A] and [Component B]?
What's the contract they agree on?"
```

**Template**:

**Interface: [Name]**

**From**: [Component A]
**To**: [Component B]
**Protocol**: [HTTP/gRPC/Queue/etc]

**Request Format**:
```
{
  "field1": "type and description",
  "field2": "type and description"
}
```

**Response Format**:
```
{
  "field1": "type and description",
  "field2": "type and description"
}
```

**Error Handling**:
- Error code 1: Meaning and handling
- Error code 2: Meaning and handling

**Example**:

**Interface: User Authentication**

**From**: API Gateway
**To**: Auth Service
**Protocol**: HTTP POST

**Request**:
```json
{
  "email": "string (required, valid email)",
  "password": "string (required, min 8 chars)"
}
```

**Response (Success - 200)**:
```json
{
  "token": "string (JWT)",
  "expiresIn": "number (seconds)",
  "userId": "string (UUID)"
}
```

**Response (Failure - 401)**:
```json
{
  "error": "Invalid credentials",
  "code": "AUTH_INVALID"
}
```

---

### Step 5: Handle Edge Cases

What happens in unusual scenarios?

**Prompt**:
```
"What edge cases should we handle for [component]?
What could go wrong and how do we handle it?"
```

**Common edge cases**:

**Null/Empty Input**:
- What if required field is missing?
- What if list is empty?
- What if string is blank?

**Timing Issues**:
- What if request times out?
- What if token expires during operation?
- What if two requests happen simultaneously?

**Scale Issues**:
- What if 10,000 requests arrive at once?
- What if database is slow?
- What if downstream service is down?

**Data Issues**:
- What if data is malformed?
- What if data is too large?
- What if data violates constraints?

**For each edge case**:
- [ ] Identify what happens
- [ ] Define handling strategy
- [ ] Document in component spec

---

### Step 6: Define Data Models

What data structures does this component use?

**Prompt**:
```
"What are the key data models for [component]?
What fields, types, and validations?"
```

**Template**:

```typescript
// Example using TypeScript (adapt to your language)

interface User {
  id: string;           // UUID, required
  email: string;        // Valid email, unique, required
  passwordHash: string; // Bcrypt hash, required
  createdAt: Date;      // ISO timestamp, auto-generated
  status: UserStatus;   // Enum: active, suspended, deleted
}

enum UserStatus {
  ACTIVE = "active",
  SUSPENDED = "suspended",
  DELETED = "deleted"
}

// Validation rules
- id: Must be valid UUID v4
- email: Must pass RFC 5322 validation, max 255 chars
- passwordHash: Must be bcrypt hash (60 chars)
- status: Must be one of enum values
```

---

### Step 7: Define Error Handling

How does this component handle and report errors?

**Prompt**:
```
"What errors can occur in [component] and how should
we handle each?"
```

**Error categories**:

**Client Errors (4xx)** - User/caller mistake:
- 400 Bad Request: Invalid input
- 401 Unauthorized: Missing/invalid auth
- 403 Forbidden: Insufficient permissions
- 404 Not Found: Resource doesn't exist
- 409 Conflict: Resource already exists

**Server Errors (5xx)** - System failure:
- 500 Internal Error: Unexpected failure
- 503 Service Unavailable: Dependency down
- 504 Gateway Timeout: Dependency timeout

**Template**:

| Error Type | HTTP Code | Error Code | Message | Recovery |
|------------|-----------|------------|---------|----------|
| Invalid email | 400 | INVALID_EMAIL | "Email format invalid" | Retry with valid email |
| User not found | 404 | USER_NOT_FOUND | "User does not exist" | Check email, try signup |
| Database down | 503 | SERVICE_UNAVAILABLE | "Service temporarily unavailable" | Retry with backoff |

---

### Step 8: Define Performance Characteristics

What are the performance expectations?

**Prompt**:
```
"What are the performance requirements for [component]?
Latency? Throughput? Resource usage?"
```

**Specify**:

**Latency**:
- p50: [X] ms (half of requests)
- p95: [Y] ms (95% of requests)
- p99: [Z] ms (99% of requests)

**Throughput**:
- Expected: [X] requests/sec
- Peak: [Y] requests/sec

**Resource Usage**:
- Memory: [X] MB typical, [Y] MB peak
- CPU: [X]% typical, [Y]% peak
- Database connections: [N] pool size

**Caching**:
- What gets cached?
- Cache TTL?
- Cache invalidation strategy?

---

## Documenting Outcomes

### Update Design Document

**Section 6: Architecture**

**Components** section:
- [ ] Add detailed component specs
- [ ] Include responsibilities
- [ ] Mark as "Detailed"

**Data Flow** section:
- [ ] Document step-by-step flows
- [ ] Include happy path and error paths
- [ ] Add sequence diagrams if helpful

**Interfaces** section:
- [ ] Define all component interfaces
- [ ] Include request/response formats
- [ ] Document error handling

---

### Create Module Guides

For each major component, create module guide:

**Location**: `.claude/modules/[component-name].md`

**Use template**: `.claude/modules/_template.md`

**Fill out**:
- Overview (purpose, location)
- Architecture (component structure)
- Data Models (with validation rules)
- API Reference (public interface)
- Common Patterns (typical usage)
- Error Handling (types and recovery)
- Testing (test structure, scenarios)

---

## Moving to Next Phase

### If More Components to Detail

Loop within Detail phase for each component.

**Pattern**:
```
Session 1: Auth Service detailed
Session 2: API Gateway detailed
Session 3: Payment Service detailed
```

---

### When All Components Detailed

Advance to Validation phase:

```
/load-design-phase validation
```

---

## Examples

### Example 1: Detailing Authentication Flow

```
User: "Let's detail the authentication component"

Claude: "Let's walk through this step by step.

**Authentication Flow:**

1. User submits login
   POST /auth/login
   { email, password }

2. Validate input
   - Email format valid?
   - Password not empty?
   - If invalid: Return 400 Bad Request

3. Query user from database
   SELECT id, email, password_hash, status
   FROM users WHERE email = ?

   - If not found: Return 404 User Not Found
   - If status = 'suspended': Return 403 Account Suspended

4. Verify password
   bcrypt.compare(password, password_hash)

   - If mismatch: Return 401 Invalid Credentials
   - Log failed attempt
   - If 5 failures in 5 min: Temporarily lock account

5. Generate token
   JWT payload: { userId, email, iat, exp }
   Sign with RS256 using private key
   Expiry: 1 hour

6. Return token
   { token, expiresIn: 3600, userId }

**Edge Cases:**

Q: What if database is down?
A: Return 503 Service Unavailable, implement circuit breaker

Q: What if token generation fails?
A: Return 500 Internal Error, log error for investigation

Q: What about concurrent login attempts?
A: Use distributed lock (Redis) for rate limiting per user

Q: What if user changes password during active session?
A: Invalidate all existing tokens, force re-login"
```

---

### Example 2: Defining Component Interface

```
User: "What's the interface between API Gateway and Auth Service?"

Claude: "Let's define the contract:

**Interface: Authentication Check**

**Purpose**: Verify if a bearer token is valid

**Endpoint**: POST /auth/verify

**Request Headers**:
Authorization: Bearer <token>

**Response (Valid Token - 200)**:
```json
{
  "userId": "uuid",
  "email": "string",
  "roles": ["string"],
  "expiresAt": "ISO timestamp"
}
```

**Response (Invalid Token - 401)**:
```json
{
  "error": "Token invalid or expired",
  "code": "TOKEN_INVALID"
}
```

**Contract Guarantees**:

API Gateway promises:
- Always send Bearer token in Authorization header
- Handle 401 by rejecting client request
- Implement 30-second timeout

Auth Service promises:
- Return within 50ms (p99)
- Never return 200 for expired token
- Log all verification attempts

**Error Scenarios**:
- Missing Authorization header → 400 Bad Request
- Malformed token → 401 Unauthorized
- Auth Service down → 503 Service Unavailable (Gateway falls back to local cache for 5 min)"
```

---

## Common Pitfalls

### Pitfall 1: Vague Specifications

**Symptom**: "Component handles requests"

**Fix**: Be specific:
```
"Exactly what requests? What format? What validation?
What does 'handle' mean - transform, store, forward?"
```

---

### Pitfall 2: Skipping Edge Cases

**Symptom**: Only documenting happy path

**Fix**: Force edge case thinking:
```
"What happens when:
- Input is null?
- Database is down?
- Request times out?
- Two requests happen simultaneously?"
```

---

### Pitfall 3: Unclear Responsibilities

**Symptom**: Overlapping component responsibilities

**Fix**: Define boundaries explicitly:
```
"Component A does [X] and NOT [Y]
Component B does [Y] and NOT [X]
Boundary: [Clear separation]"
```

---

## Integration with cc-bootstrap

### Creating Module Guides

After detailing component:

1. Copy `.claude/modules/_template.md`
2. Rename to `.claude/modules/[component].md`
3. Fill with detailed spec from this phase
4. Link from architecture.md

---

### After Detail Phase

- [ ] Create module guides for all components
- [ ] Update architecture.md with detailed design
- [ ] Document all interfaces
- [ ] Prepare for validation phase
- [ ] Keep Opus model

---

## Quick Reference

**Phase Goal**: Flesh out component specifics

**Key Prompts**:
- "Walk me through the data flow"
- "What's the interface between A and B?"
- "How do we handle [edge case]?"
- "What are component responsibilities?"

**Outputs**:
- Component specifications
- Interface definitions
- Data flow documentation
- Edge case handling
- Module guides created

**Ready to Advance When**:
- All components detailed
- Interfaces defined
- Edge cases handled
- Module guides created

**Next Phase**: `/load-design-phase validation`
