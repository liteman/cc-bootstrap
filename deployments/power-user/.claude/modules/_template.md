# [MODULE NAME]

> **Tags**: [tag1], [tag2], [tag3]
> **When to read**: Working on [specific features/areas]
> **Dependencies**: [List other modules this depends on]

## Overview

**Purpose**: [What this module does]
**Owner**: [Team/person responsible]
**Location**: `[path/to/module]`

### Quick Facts
- **Primary Language**: [Language]
- **Framework**: [If applicable]
- **Database Tables**: [If applicable]
- **External APIs**: [If applicable]

## Architecture

### Component Structure

```
[module-name]/
├── index.ts              # Public API
├── types.ts              # Type definitions
├── service.ts            # Business logic
├── repository.ts         # Data access
├── handlers/             # Request handlers
├── utils/                # Module-specific utilities
└── tests/                # Module tests
```

### Key Components

#### [Component 1]
**File**: `[filename]`
**Purpose**: [What it does]
**Key Functions**:
- `[function1]` - [description]
- `[function2]` - [description]

#### [Component 2]
**File**: `[filename]`
**Purpose**: [What it does]
**Key Functions**:
- `[function1]` - [description]
- `[function2]` - [description]

## Data Models

### [Model 1]

```typescript
interface [ModelName] {
  [field1]: [type];  // [description]
  [field2]: [type];  // [description]
  [field3]: [type];  // [description]
}
```

**Validation Rules**:
- [Rule 1]
- [Rule 2]

### [Model 2]

```typescript
interface [ModelName] {
  [field1]: [type];  // [description]
  [field2]: [type];  // [description]
}
```

## API Reference

### Public Interface

```typescript
// Main exports from this module
export {
  [function1],  // [description]
  [function2],  // [description]
  [type1],      // [description]
}
```

### Key Functions

#### `[functionName]`

```typescript
function [functionName](
  [param1]: [type],
  [param2]: [type]
): Promise<[ReturnType]>
```

**Purpose**: [What it does]

**Parameters**:
- `[param1]` - [description]
- `[param2]` - [description]

**Returns**: [description]

**Throws**: 
- `[ErrorType]` - [when it's thrown]

**Example**:
```typescript
const result = await [functionName](
  [example param1],
  [example param2]
);
```

## Common Patterns

### Pattern 1: [Pattern Name]

**Use when**: [Scenario]

**Example**:
```typescript
[Code example]
```

**Why this pattern**: [Explanation]

### Pattern 2: [Pattern Name]

**Use when**: [Scenario]

**Example**:
```typescript
[Code example]
```

**Why this pattern**: [Explanation]

## Integration Points

### Dependencies on Other Modules

- **[Module 1]**: [How/why it's used]
- **[Module 2]**: [How/why it's used]

### Modules That Depend on This

- **[Module 1]**: [How they use it]
- **[Module 2]**: [How they use it]

### External Services

- **[Service 1]**: [Integration details]
- **[Service 2]**: [Integration details]

## Error Handling

### Error Types

```typescript
class [ErrorName] extends Error {
  // When this error is thrown and how to handle it
}
```

### Error Scenarios

| Scenario | Error Type | Recovery Strategy |
|----------|-----------|-------------------|
| [Scenario 1] | [ErrorType] | [How to handle] |
| [Scenario 2] | [ErrorType] | [How to handle] |

## Testing

### Test Structure

```
tests/
├── unit/
│   ├── [component].test.ts
│   └── [component2].test.ts
├── integration/
│   └── [flow].test.ts
└── fixtures/
    └── [data].ts
```

### Key Test Scenarios

1. **[Scenario 1]**: [What's being tested]
2. **[Scenario 2]**: [What's being tested]
3. **[Scenario 3]**: [What's being tested]

### Mocking Strategy

[Explain how to mock dependencies for this module]

```typescript
// Example mock setup
```

## Configuration

### Environment Variables

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `[VAR_1]` | Yes | - | [Description] |
| `[VAR_2]` | No | `[default]` | [Description] |

### Feature Flags

| Flag | Default | Description |
|------|---------|-------------|
| `[FLAG_1]` | `false` | [Description] |
| `[FLAG_2]` | `true` | [Description] |

## Performance Considerations

### Optimization Points

1. **[Optimization 1]**: [Description]
2. **[Optimization 2]**: [Description]

### Caching Strategy

[How caching is used in this module]

### Known Performance Bottlenecks

[Document any known performance issues]

## Security Considerations

### Authentication

[How this module handles authentication]

### Authorization

[How this module handles authorization]

### Input Validation

[Validation rules and where they're enforced]

### Sensitive Data

[How sensitive data is handled]

## Common Tasks

### Adding a New [Feature/Endpoint/etc.]

1. [Step 1]
2. [Step 2]
3. [Step 3]
4. [Update tests]
5. [Update documentation]

### Modifying Existing Functionality

1. [Step 1]
2. [Step 2]
3. [Update tests]
4. [Check for breaking changes]

## Troubleshooting

### Common Issues

#### [Issue 1]
**Symptoms**: [What you see]
**Cause**: [Why it happens]
**Solution**: [How to fix]

#### [Issue 2]
**Symptoms**: [What you see]
**Cause**: [Why it happens]
**Solution**: [How to fix]

### Debugging Tips

[Module-specific debugging advice]

## Migration Notes

### Recent Changes

[Document recent significant changes]

### Deprecated Features

| Feature | Deprecated In | Removed In | Alternative |
|---------|---------------|------------|-------------|
| [Feature 1] | [Version] | [Version] | [What to use instead] |

## Examples

### Example 1: [Use Case]

```typescript
// Full working example
[Code]
```

### Example 2: [Use Case]

```typescript
// Full working example
[Code]
```

## TODO / Future Work

- [ ] [Planned improvement 1]
- [ ] [Planned improvement 2]
- [ ] [Known technical debt item]

## References

- [Link to related documentation]
- [Link to external resources]
- [Link to API specs]
