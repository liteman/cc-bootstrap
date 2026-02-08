# Architecture Overview

> **When to read**: At the start of any major feature work or when you need to understand system-wide patterns.

## System Design

### High-Level Architecture

```
[Add your architecture diagram or description here]

Example:
┌─────────────┐
│   Client    │
└──────┬──────┘
       │
       ▼
┌─────────────┐
│  API Layer  │
└──────┬──────┘
       │
       ▼
┌─────────────┐
│  Services   │
└──────┬──────┘
       │
       ▼
┌─────────────┐
│  Database   │
└─────────────┘
```

### Key Principles

1. **[Principle 1]**: [Description]
2. **[Principle 2]**: [Description]
3. **[Principle 3]**: [Description]

### Technology Decisions

| Component | Technology | Reason |
|-----------|-----------|---------|
| [Frontend] | [Tech] | [Why] |
| [Backend] | [Tech] | [Why] |
| [Database] | [Tech] | [Why] |
| [Cache] | [Tech] | [Why] |

## Core Modules

### [Module 1 Name]
**Purpose**: [Brief description]
**Location**: `[path/to/module]`
**Key Files**: 
- `[file1.ts]` - [purpose]
- `[file2.ts]` - [purpose]

**Dependencies**: [List key dependencies]

### [Module 2 Name]
**Purpose**: [Brief description]
**Location**: `[path/to/module]`
**Key Files**:
- `[file1.ts]` - [purpose]
- `[file2.ts]` - [purpose]

**Dependencies**: [List key dependencies]

### [Module 3 Name]
**Purpose**: [Brief description]
**Location**: `[path/to/module]`
**Key Files**:
- `[file1.ts]` - [purpose]
- `[file2.ts]` - [purpose]

**Dependencies**: [List key dependencies]

## Data Flow

### Request Lifecycle

```
1. Request arrives at [Entry Point]
2. [Middleware/Validation]
3. [Route Handler]
4. [Service Layer]
5. [Data Layer]
6. Response sent back
```

### Event Flow

[Describe how events/messages flow through your system]

## Cross-Cutting Concerns

### Authentication & Authorization
- **Strategy**: [e.g., JWT, OAuth, Sessions]
- **Implementation**: [Where/how it's implemented]
- **Key Files**: [List relevant files]

### Error Handling
- **Strategy**: [e.g., Global error handler, try-catch conventions]
- **Implementation**: [Where/how it's implemented]
- **Key Files**: [List relevant files]

### Logging & Monitoring
- **Strategy**: [e.g., Structured logging, APM tools]
- **Implementation**: [Where/how it's implemented]
- **Key Files**: [List relevant files]

### Caching
- **Strategy**: [e.g., Redis, in-memory, CDN]
- **Implementation**: [Where/how it's implemented]
- **Key Files**: [List relevant files]

## Infrastructure

### Development Environment
[How to set up local development]

### Staging Environment
[Details about staging]

### Production Environment
[Details about production infrastructure]

## Deployment Pipeline

```
[Describe your CI/CD pipeline]

Example:
1. Push to branch
2. GitHub Actions runs tests
3. Build Docker image
4. Deploy to staging (on main branch)
5. Manual approval for production
6. Deploy to production
```

## Performance Considerations

### Critical Paths
[List performance-critical code paths]

### Optimization Strategies
[List key optimization approaches]

### Known Bottlenecks
[Document known performance issues and workarounds]

## Security Considerations

### Threat Model
[Key security concerns for your application]

### Security Controls
[List security measures in place]

### Sensitive Data Handling
[How sensitive data is handled]

## Scalability

### Current Scale
[Current traffic/usage metrics]

### Scaling Strategy
[How the system scales]

### Known Limits
[Document known scalability limits]

## Dependencies

### External Services
- **[Service 1]**: [Purpose, SLA, fallback strategy]
- **[Service 2]**: [Purpose, SLA, fallback strategy]

### Internal Services
- **[Service 1]**: [Purpose, ownership]
- **[Service 2]**: [Purpose, ownership]

## Migration Guide

### Breaking Changes
[How to handle breaking changes]

### Database Migrations
[Migration strategy and process]

### API Versioning
[How APIs are versioned]

## Future Considerations

### Planned Improvements
[List architectural improvements in the roadmap]

### Technical Debt
[Known architectural technical debt]

### Research Areas
[Areas being explored for future changes]

---

## Architecture Decision Records (ADRs)

Significant architectural decisions are documented as ADRs following the template in `.claude/design/templates/ADR_TEMPLATE.md`.

### When to Create an ADR

Create an ADR when a decision:
- [ ] Has significant impact on system structure
- [ ] Involved evaluation of multiple viable options
- [ ] Has meaningful reversal cost
- [ ] Will make future developers ask "why did we do it this way?"
- [ ] Affects multiple modules or cross-cutting concerns
- [ ] Establishes a pattern others should follow

### ADR Workflow

1. Use design workflows to explore options: `/load-design-phase options`
2. Make deliberate decision: `/load-design-phase decision`
3. Create ADR from template: `.claude/design/templates/ADR_TEMPLATE.md`
4. Save to `docs/adr/ADR-NNN-title.md`
5. Link from this architecture document (table below)
6. Update relevant module guides in `.claude/modules/`

### ADR Storage

ADRs live in `docs/adr/` and follow the naming convention:
```
docs/adr/ADR-NNN-short-title.md
```

Where NNN is zero-padded (001, 002, etc.).

### ADR Index

| ADR | Title | Status | Date | Modules Affected |
|-----|-------|--------|------|------------------|
| [ADR-001](../adr/ADR-001-example.md) | [Example decision] | Proposed | YYYY-MM-DD | [module1] |

*Note: This index should be kept up-to-date as ADRs are created. Update this table when creating new ADRs.*

### See Also

- `.claude/design/workflows/design-session.md` — Design process workflow
- `docs/design/adr-guide.md` — ADR best practices
- `docs/design/design-workflow-guide.md` — When to use design workflows
