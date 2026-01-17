# Feature Development Workflow

> **When to read**: Before starting any new feature work

> **With Superpowers**: If you have the [superpowers](https://github.com/obra/superpowers) plugin installed, use `/brainstorm` before this workflow. Superpowers will guide the design phase through Socratic questioning, then use this workflow for project-specific context. The superpowers TDD skill enforces test-first development throughout implementation.

## Overview

This workflow ensures consistent, high-quality feature development across the project.

## Pre-Development

### 1. Understanding Requirements

- [ ] Read the feature specification/ticket thoroughly
- [ ] Identify affected modules (use `.claude/modules/` guides)
- [ ] Review architecture implications (see `.claude/architecture.md`)
- [ ] Clarify any ambiguous requirements with stakeholders

### 2. Technical Planning

- [ ] Identify affected files and modules
- [ ] Plan data model changes (if any)
- [ ] Consider API contract changes
- [ ] Identify integration points
- [ ] Estimate complexity and scope

### 3. Context Loading

Load relevant documentation:
```
/load-module [relevant-module]
/load-architecture (if making structural changes)
```

Verify you have the right context:
```
/verify-context
```

## Development Process

### Step 1: Branch Creation

```bash
git checkout -b feat/[feature-description]
```

**Branch naming convention**: `feat/[brief-description]`
Examples:
- `feat/oauth-google-login`
- `feat/user-profile-editing`
- `feat/payment-retry-logic`

### Step 2: Create Feature Outline

Before writing code, create a plan:

```markdown
## Feature: [Name]

### Files to Create/Modify
- [ ] `[file1.ts]` - [what changes]
- [ ] `[file2.ts]` - [what changes]
- [ ] `[test1.test.ts]` - [test coverage]

### Data Model Changes
- [ ] [Table/Schema changes]

### API Changes
- [ ] [New/modified endpoints]

### Dependencies
- [ ] [New packages needed]

### Migration Path
- [ ] [How to handle existing data/users]

### Testing Strategy
- [ ] Unit tests: [what to test]
- [ ] Integration tests: [what to test]
- [ ] E2E tests: [what to test]
```

**Save this plan**: `docs/features/[feature-name]-plan.md`

### Step 3: Implementation

Follow this order:

1. **Data Layer** (if applicable)
   - [ ] Define types/interfaces
   - [ ] Create/update database schemas
   - [ ] Write migrations
   - [ ] Create repository functions

2. **Business Logic**
   - [ ] Implement service layer
   - [ ] Add validation
   - [ ] Implement error handling
   - [ ] Add logging

3. **API Layer** (if applicable)
   - [ ] Create/update handlers
   - [ ] Add request/response validation
   - [ ] Update API documentation

4. **Integration**
   - [ ] Integrate with existing modules
   - [ ] Update dependent code
   - [ ] Handle edge cases

### Step 4: Testing

Write tests as you go (not after):

```typescript
// Test structure
describe('[Feature Name]', () => {
  describe('[Component/Function]', () => {
    it('should [expected behavior]', async () => {
      // Arrange
      // Act
      // Assert
    });
    
    it('should handle [error case]', async () => {
      // Arrange
      // Act
      // Assert
    });
  });
});
```

**Test coverage requirements**:
- [ ] Happy path scenarios
- [ ] Edge cases
- [ ] Error conditions
- [ ] Validation failures
- [ ] Integration points

### Step 5: Code Quality Checks

Before committing:

```bash
# Linting
npm run lint

# Type checking
npm run type-check

# Tests
npm test

# Build
npm run build
```

Fix any issues before proceeding.

### Step 6: Documentation

Update relevant documentation:
- [ ] Code comments for complex logic
- [ ] JSDoc/TSDoc for public functions
- [ ] API documentation (if applicable)
- [ ] README updates (if applicable)
- [ ] Module guide in `.claude/modules/` (if significant)
- [ ] CHANGELOG.md entry

### Step 7: Self-Review

Review your own code:
- [ ] Does it follow project conventions? (see `.claude/conventions/code-style.md`)
- [ ] Are there any obvious bugs?
- [ ] Is error handling comprehensive?
- [ ] Are edge cases covered?
- [ ] Is the code readable and maintainable?
- [ ] Are there any performance concerns?
- [ ] Are security considerations addressed?

### Step 8: Commit

Use conventional commits:

```bash
git add [files]
git commit -m "feat: [brief description]

[Optional detailed description]

[Optional breaking changes]
[Optional references to issues]"
```

**Commit message format**:
```
<type>: <description>

[optional body]

[optional footer]
```

**Types**: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`

Examples:
```
feat: add Google OAuth login support

Implements OAuth 2.0 flow for Google authentication.
Users can now sign in with their Google accounts.

Closes #123
```

## Review & Merge

### Step 1: Push Branch

```bash
git push origin feat/[feature-description]
```

### Step 2: Create Pull Request

**PR Title**: Same as commit message
**PR Description**: Include:
- What changed and why
- How to test
- Screenshots (if UI changes)
- Breaking changes (if any)
- Related issues/tickets

**PR Template**:
```markdown
## Description
[What this PR does]

## Type of Change
- [ ] New feature
- [ ] Breaking change
- [ ] Requires documentation update

## Testing
- [ ] Unit tests pass
- [ ] Integration tests pass
- [ ] Manual testing completed

## How to Test
1. [Step 1]
2. [Step 2]

## Screenshots (if applicable)
[Add screenshots]

## Checklist
- [ ] Code follows project style guidelines
- [ ] Self-review completed
- [ ] Comments added for complex code
- [ ] Documentation updated
- [ ] Tests added/updated
- [ ] All tests pass
- [ ] No breaking changes (or documented)
```

### Step 3: Address Review Feedback

- [ ] Respond to all comments
- [ ] Make requested changes
- [ ] Re-request review after changes
- [ ] Resolve conversations when addressed

### Step 4: Merge

Once approved:
```bash
# Update branch with latest main
git checkout main
git pull origin main
git checkout feat/[feature-description]
git rebase main

# Squash commits if needed
git rebase -i main

# Force push
git push --force-with-lease

# Merge via GitHub/GitLab UI (squash and merge)
```

## Post-Merge

### Step 1: Verify Deployment

- [ ] Check staging deployment
- [ ] Verify feature works in staging
- [ ] Monitor for errors

### Step 2: Update Documentation

- [ ] Update user-facing documentation (if applicable)
- [ ] Update internal documentation
- [ ] Add to CHANGELOG.md

### Step 3: Clean Up

```bash
# Delete local branch
git checkout main
git branch -d feat/[feature-description]

# Delete remote branch (if not auto-deleted)
git push origin --delete feat/[feature-description]
```

### Step 4: Monitor

After production deployment:
- [ ] Check error rates
- [ ] Check performance metrics
- [ ] Monitor user feedback
- [ ] Be ready to hotfix if needed

## Tips & Best Practices

### Breaking Down Large Features

If a feature is large:
1. Break into smaller, deployable increments
2. Use feature flags for gradual rollout
3. Create multiple PRs for different components
4. Keep each PR focused and reviewable

### Feature Flags

```typescript
// Example feature flag usage
if (featureFlags.newPaymentFlow) {
  // New implementation
} else {
  // Old implementation
}
```

### Rollback Plan

Always have a rollback plan:
- How to disable the feature quickly
- How to revert database changes (if any)
- How to handle in-flight operations

### Communication

- Update stakeholders on progress
- Flag blockers early
- Ask for help when stuck
- Document decisions and trade-offs

## Common Pitfalls

### ❌ Don't
- Start coding without a plan
- Skip tests "to save time"
- Commit directly to main
- Make PRs too large (>500 lines)
- Ignore linting/type errors
- Skip documentation updates

### ✅ Do
- Plan before coding
- Write tests as you go
- Use feature branches
- Keep PRs focused and small
- Fix all linting/type errors
- Update documentation with code

## Checklist Summary

Use this quick checklist for each feature:

- [ ] Requirements understood
- [ ] Technical plan created
- [ ] Relevant context loaded
- [ ] Feature branch created
- [ ] Tests written and passing
- [ ] Code quality checks pass
- [ ] Documentation updated
- [ ] Self-review completed
- [ ] PR created with good description
- [ ] Review feedback addressed
- [ ] Merged and deployed
- [ ] Monitoring in production
