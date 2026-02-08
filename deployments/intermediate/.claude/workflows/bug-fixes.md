# Bug Fix Workflow

> **When to read**: Before fixing any bug

> **With Superpowers**: If you have the [superpowers](https://github.com/obra/superpowers) plugin installed, the systematic-debugging skill provides a comprehensive 4-phase root cause analysis process. Use this workflow alongside superpowers for project-specific context and patterns.

## Overview

This workflow ensures bugs are fixed thoroughly with proper root cause analysis and prevention measures.

## Investigation Phase

### Step 1: Reproduce the Bug

- [ ] Get clear reproduction steps
- [ ] Reproduce in local environment
- [ ] Reproduce in staging (if applicable)
- [ ] Document exact behavior vs. expected behavior
- [ ] Capture error messages, stack traces, logs

**Bug Report Template**:
```markdown
## Bug: [Brief Description]

### Expected Behavior
[What should happen]

### Actual Behavior
[What actually happens]

### Steps to Reproduce
1. [Step 1]
2. [Step 2]
3. [Error occurs]

### Environment
- Version: [version]
- Browser/Platform: [details]
- User Type: [if relevant]

### Error Messages
```
[Paste error logs/stack traces]
```

### Impact
- Severity: [Critical/High/Medium/Low]
- Users Affected: [Number or percentage]
- Workaround Available: [Yes/No]
```

### Step 2: Load Context

Identify affected module(s):
```
/load-module [affected-module]
```

Review the module documentation to understand:
- How it's supposed to work
- Known edge cases
- Common patterns

Verify context:
```
/verify-context
```

### Step 3: Root Cause Analysis

Ask these questions:
1. **What** is failing? (Specific function/component)
2. **Where** in the code does it fail? (File/line)
3. **When** does it fail? (Conditions/triggers)
4. **Why** does it fail? (Root cause)
5. **How** did this bug get introduced? (Recent change? Always there?)

**Document your findings**:
```markdown
## Root Cause Analysis: [Bug Name]

### What Failed
[Specific component/function]

### Where It Failed
- File: `[file.ts]`
- Function: `[functionName]`
- Line: [line number]

### Why It Failed
[Root cause explanation]

### How It Was Introduced
- Commit: [hash if known]
- PR: [link if applicable]
- Introduced: [date/version]

### Why It Wasn't Caught
- [ ] Missing test coverage
- [ ] Edge case not considered
- [ ] Integration issue
- [ ] Race condition
- [ ] Other: [explain]
```

Save to: `docs/bugs/[bug-id]-analysis.md`

## Fix Planning

### Step 1: Determine Fix Scope

Assess impact:
- [ ] How many files need changes?
- [ ] Are there similar bugs elsewhere?
- [ ] Will this require data migration?
- [ ] Are there API changes needed?
- [ ] Does this affect other modules?

### Step 2: Design the Fix

**Fix Plan Template**:
```markdown
## Fix Plan: [Bug Name]

### Approach
[Explain the fix strategy]

### Files to Modify
- [ ] `[file1.ts]` - [what to change]
- [ ] `[file2.ts]` - [what to change]

### Tests to Add
- [ ] Unit test for the specific bug
- [ ] Regression test to prevent recurrence
- [ ] Additional edge case tests

### Potential Side Effects
[Any code that might be affected]

### Migration Required
- [ ] Yes: [explain]
- [ ] No

### Rollback Plan
[How to revert if needed]
```

### Step 3: Check for Similar Issues

Search codebase for similar patterns:
```bash
# Search for similar code patterns
grep -r "[similar-pattern]" src/

# Search for similar error handling
grep -r "[error-type]" src/
```

Document findings:
- [ ] Found similar issues elsewhere?
- [ ] Should those be fixed too?
- [ ] Is this a systemic problem?

## Implementation

### Step 1: Create Bug Fix Branch

```bash
git checkout -b fix/[bug-description]
```

**Branch naming**: `fix/[brief-description]`
Examples:
- `fix/null-pointer-in-payment`
- `fix/race-condition-in-auth`
- `fix/validation-error-handling`

### Step 2: Write Failing Test First

**Test-Driven Bug Fixing**:

1. Write a test that reproduces the bug (it should fail)
2. Fix the bug
3. Test should now pass
4. Add additional tests for edge cases

```typescript
describe('Bug Fix: [Bug Description]', () => {
  it('should reproduce the bug', () => {
    // This test should fail before the fix
    // and pass after the fix
  });
  
  it('should handle edge case 1', () => {
    // Prevent similar bugs
  });
  
  it('should handle edge case 2', () => {
    // Prevent similar bugs
  });
});
```

### Step 3: Implement the Fix

Keep the fix minimal and focused:
- [ ] Fix only what's broken
- [ ] Don't refactor while fixing (unless necessary)
- [ ] Don't add new features
- [ ] Maintain backward compatibility (if possible)

**Minimal Fix Example**:
```typescript
// ❌ Don't do this while fixing a bug
function processPayment(amount) {
  // Fix the bug AND refactor everything
  // AND add new validation
  // AND change the API
}

// ✅ Do this
function processPayment(amount) {
  // Only fix the null check bug
  if (amount === null || amount === undefined) {
    throw new Error('Amount is required');
  }
  // Rest of the code unchanged
}
```

### Step 4: Verify the Fix

Run the new tests:
```bash
npm test -- [test-file]
```

Run all tests:
```bash
npm test
```

Manual verification:
- [ ] Bug no longer reproduces locally
- [ ] Original functionality still works
- [ ] No new errors introduced

### Step 5: Check for Regressions

Test related functionality:
- [ ] Does the fix break anything else?
- [ ] Are there integration issues?
- [ ] Do all existing tests still pass?

### Step 6: Add Defensive Coding

Prevent similar bugs:

```typescript
// Add validation
function processData(data) {
  // Guard clauses
  if (!data) {
    throw new Error('Data is required');
  }
  if (!Array.isArray(data.items)) {
    throw new Error('Data.items must be an array');
  }
  
  // Type checking (if not using TypeScript)
  if (typeof data.amount !== 'number') {
    throw new Error('Amount must be a number');
  }
  
  // Now safe to use data
}

// Add logging
function criticalOperation() {
  logger.debug('Starting critical operation', { context });
  try {
    // operation
    logger.info('Operation completed successfully');
  } catch (error) {
    logger.error('Operation failed', { error, context });
    throw error;
  }
}
```

## Quality Checks

### Code Quality

```bash
npm run lint
npm run type-check
npm test
npm run build
```

### Security Review

- [ ] Does the fix introduce security issues?
- [ ] Is input validation proper?
- [ ] Are error messages safe (no sensitive data)?
- [ ] Are there any injection risks?

### Performance Review

- [ ] Does the fix impact performance?
- [ ] Are there any n+1 queries introduced?
- [ ] Is caching still working correctly?

## Documentation

### Step 1: Update Code Comments

Add comments explaining:
```typescript
// Bug fix: Prevent null pointer when user has no profile
// Issue: #123
// Previously, this would crash when user.profile was null
if (!user.profile) {
  return defaultProfile();
}
```

### Step 2: Update Relevant Documentation

- [ ] Update module guide if behavior changed
- [ ] Update API docs if applicable
- [ ] Add to troubleshooting section
- [ ] Update CHANGELOG.md

### Step 3: Document the Bug

Add to project knowledge base:
```markdown
## Known Issues (Fixed)

### [Bug Name] - Fixed in v[version]
**Issue**: [Brief description]
**Root Cause**: [What caused it]
**Fix**: [How it was fixed]
**Prevention**: [Tests/patterns added]
**Reference**: [Link to PR/issue]
```

## Commit & Review

### Commit Message

```bash
git commit -m "fix: [brief description]

[Detailed explanation of the bug and fix]

Root cause: [root cause]
Impact: [who was affected]
Tests added: [what tests]

Fixes #[issue-number]"
```

**Example**:
```
fix: prevent null pointer exception in payment processing

Users with incomplete profiles were experiencing crashes during
payment due to missing validation on profile.paymentMethod.

Root cause: No null check before accessing profile.paymentMethod
Impact: ~5% of users attempting checkout
Tests added: Unit tests for null/undefined payment methods

Fixes #456
```

### Pull Request

**PR Description Template**:
```markdown
## Bug Fix: [Name]

### The Bug
[Description of the bug and its impact]

### Root Cause
[What caused the bug]

### The Fix
[What changed and why]

### Testing
- [ ] Unit tests added
- [ ] Regression tests added
- [ ] Manual testing completed
- [ ] All tests passing

### How to Verify
1. [Steps to verify the fix]
2. [Expected behavior]

### Checklist
- [ ] Bug reproduced before fix
- [ ] Bug no longer reproduces after fix
- [ ] Tests added to prevent regression
- [ ] No side effects identified
- [ ] Documentation updated
- [ ] Similar issues checked and fixed
```

## Post-Fix

### Monitor After Deployment

- [ ] Watch error rates in production
- [ ] Monitor for related issues
- [ ] Verify user reports stop
- [ ] Check performance metrics

### Update Knowledge Base

Add to `.claude/modules/[module].md` Troubleshooting section:

```markdown
### [Bug Name]
**Symptoms**: [What users saw]
**Cause**: [Root cause]
**Fixed**: v[version]
**Prevention**: [What tests/patterns prevent this]
```

### Retrospective

If this was a critical bug, ask:
1. Why wasn't this caught earlier?
2. What process changes would prevent this?
3. What tests were missing?
4. What documentation would have helped?

Document learnings in team knowledge base.

## Bug Severity Guide

### Critical (Fix Immediately)
- System completely broken
- Data loss risk
- Security vulnerability
- Affects all/most users

### High (Fix Within 24 Hours)
- Core functionality broken
- Affects significant portion of users
- No workaround available
- Payment/revenue impacting

### Medium (Fix Within Week)
- Feature partially broken
- Affects some users
- Workaround available
- Minor functionality issue

### Low (Fix When Convenient)
- Minor UI issue
- Edge case bug
- Cosmetic issue
- Minimal user impact

## Common Pitfalls

### ❌ Don't
- Fix without understanding root cause
- Add features while fixing bugs
- Skip writing tests
- Ignore similar bugs elsewhere
- Rush the fix without review
- Fix symptoms instead of cause

### ✅ Do
- Thoroughly investigate root cause
- Keep fix minimal and focused
- Add comprehensive tests
- Check for similar issues
- Have fix reviewed
- Document what you learned

## Quick Checklist

- [ ] Bug reproduced locally
- [ ] Root cause identified
- [ ] Context loaded for affected modules
- [ ] Similar issues checked
- [ ] Failing test written
- [ ] Minimal fix implemented
- [ ] All tests passing
- [ ] No regressions detected
- [ ] Documentation updated
- [ ] PR created with good description
- [ ] Deployed and monitored
