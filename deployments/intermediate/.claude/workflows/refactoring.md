# Refactoring Workflow

> **When to read**: Before performing any code refactoring

## Overview

Refactoring improves code structure without changing external behavior. This workflow ensures safe, systematic refactoring.

## When to Refactor

### Good Reasons
- Code is difficult to understand or maintain
- Duplication makes changes error-prone
- Preparing for a new feature (make space)
- Performance optimization needed
- Reducing technical debt
- Improving testability

### Bad Reasons
- "I don't like how it looks"
- While fixing a critical bug
- Without understanding the code first
- Because you're bored
- To use a new technology "just because"

## Pre-Refactoring

### Step 1: Identify the Problem

Document what needs refactoring and why:

```markdown
## Refactoring: [Area/Component]

### Current Problems
- [ ] [Problem 1]
- [ ] [Problem 2]
- [ ] [Problem 3]

### Impact
- Files affected: [count]
- Users affected: [if behavior changes]
- Risk level: [High/Medium/Low]

### Benefits
- [Benefit 1]
- [Benefit 2]
- [Benefit 3]

### Risks
- [Risk 1]
- [Risk 2]
```

### Step 2: Load Context

```bash
/load-module [affected-module]
/verify-context
```

Understand:
- Current architecture
- Dependencies
- Test coverage
- Known issues in this area

### Step 3: Ensure Test Coverage

**CRITICAL**: Refactoring without tests is dangerous!

```bash
# Check current test coverage
npm run test:coverage
```

If coverage is insufficient:
1. Add tests FIRST
2. Ensure all tests pass
3. THEN refactor

**Minimum coverage before refactoring**:
- [ ] All public APIs have tests
- [ ] Critical paths have tests
- [ ] Edge cases are covered
- [ ] Integration points are tested

### Step 4: Create Refactoring Plan

```markdown
## Refactoring Plan: [Name]

### Scope
- Files to change: [list]
- Estimated LOC changed: [approximate]
- Dependencies affected: [list]

### Approach
[Step-by-step approach]

### Safety Measures
- [ ] All existing tests pass
- [ ] New tests added for uncovered code
- [ ] No behavior changes (unless documented)
- [ ] Backward compatibility maintained

### Phases
1. Phase 1: [description]
2. Phase 2: [description]
3. Phase 3: [description]

### Rollback Plan
[How to revert if needed]
```

Save to: `docs/refactoring/[name]-plan.md`

## Refactoring Process

### Step 1: Create Branch

```bash
git checkout -b refactor/[description]
```

Examples:
- `refactor/extract-auth-service`
- `refactor/simplify-payment-flow`
- `refactor/reduce-duplication-in-api`

### Step 2: Establish Baseline

Ensure all tests pass BEFORE starting:
```bash
npm test
npm run lint
npm run type-check
```

**Save the baseline**:
```bash
git add .
git commit -m "chore: baseline before refactoring"
```

### Step 3: Make Small, Incremental Changes

**The Golden Rule**: Keep tests passing after each change.

#### Incremental Refactoring Pattern

```
1. Make a small change
2. Run tests → should still pass
3. Commit
4. Repeat
```

**Example incremental steps**:
```
Commit 1: Extract function
Commit 2: Move function to new file
Commit 3: Add parameters to function
Commit 4: Update all call sites
Commit 5: Remove old code
```

**Each commit should**:
- Be small and focused
- Keep tests passing
- Be independently reviewable
- Have a clear purpose

### Step 4: Common Refactoring Patterns

#### Extract Function

```typescript
// Before
function processOrder(order) {
  // 50 lines of complex logic
  const total = order.items.reduce((sum, item) => sum + item.price, 0);
  const tax = total * 0.1;
  const shipping = total > 100 ? 0 : 10;
  // more logic...
}

// After
function processOrder(order) {
  const total = calculateTotal(order);
  const tax = calculateTax(total);
  const shipping = calculateShipping(total);
  // clearer flow...
}

function calculateTotal(order) {
  return order.items.reduce((sum, item) => sum + item.price, 0);
}

function calculateTax(total) {
  return total * 0.1;
}

function calculateShipping(total) {
  return total > 100 ? 0 : 10;
}
```

#### Extract Class/Module

```typescript
// Before: Everything in one file
class OrderProcessor {
  calculateTotal() { }
  calculateTax() { }
  calculateShipping() { }
  validateOrder() { }
  sendEmail() { }
  updateInventory() { }
  // 500 lines...
}

// After: Separated concerns
class OrderCalculator {
  calculateTotal() { }
  calculateTax() { }
  calculateShipping() { }
}

class OrderValidator {
  validateOrder() { }
}

class OrderNotifier {
  sendEmail() { }
}

class InventoryManager {
  updateInventory() { }
}

class OrderProcessor {
  constructor(
    private calculator: OrderCalculator,
    private validator: OrderValidator,
    private notifier: OrderNotifier,
    private inventory: InventoryManager
  ) {}
  
  process(order) {
    this.validator.validateOrder(order);
    const total = this.calculator.calculateTotal(order);
    this.inventory.updateInventory(order);
    this.notifier.sendEmail(order);
  }
}
```

#### Remove Duplication

```typescript
// Before: Duplicated logic
function processUserPayment(user, amount) {
  if (!user || !user.id) throw new Error('Invalid user');
  if (!amount || amount <= 0) throw new Error('Invalid amount');
  // process payment
}

function processSubscriptionPayment(subscription, amount) {
  if (!subscription || !subscription.id) throw new Error('Invalid subscription');
  if (!amount || amount <= 0) throw new Error('Invalid amount');
  // process payment
}

// After: Shared validation
function validatePayment(amount) {
  if (!amount || amount <= 0) throw new Error('Invalid amount');
}

function validateEntity(entity, name) {
  if (!entity || !entity.id) throw new Error(`Invalid ${name}`);
}

function processUserPayment(user, amount) {
  validateEntity(user, 'user');
  validatePayment(amount);
  // process payment
}

function processSubscriptionPayment(subscription, amount) {
  validateEntity(subscription, 'subscription');
  validatePayment(amount);
  // process payment
}
```

#### Simplify Conditionals

```typescript
// Before: Complex nested conditionals
function determineShipping(order) {
  if (order.total > 100) {
    if (order.isPremium) {
      if (order.location === 'US') {
        return 'free-priority';
      } else {
        return 'free-standard';
      }
    } else {
      return 'free-standard';
    }
  } else {
    if (order.isPremium) {
      return 'discounted';
    } else {
      return 'standard';
    }
  }
}

// After: Guard clauses and clear logic
function determineShipping(order) {
  if (order.total <= 100) {
    return order.isPremium ? 'discounted' : 'standard';
  }
  
  // Free shipping for orders > $100
  if (!order.isPremium) {
    return 'free-standard';
  }
  
  return order.location === 'US' ? 'free-priority' : 'free-standard';
}
```

#### Replace Magic Numbers/Strings

```typescript
// Before
function applyDiscount(price) {
  if (price > 100) return price * 0.9;
  if (price > 50) return price * 0.95;
  return price;
}

// After
const DISCOUNT_TIERS = {
  LARGE: { threshold: 100, multiplier: 0.9 },
  MEDIUM: { threshold: 50, multiplier: 0.95 },
} as const;

function applyDiscount(price) {
  if (price > DISCOUNT_TIERS.LARGE.threshold) {
    return price * DISCOUNT_TIERS.LARGE.multiplier;
  }
  if (price > DISCOUNT_TIERS.MEDIUM.threshold) {
    return price * DISCOUNT_TIERS.MEDIUM.multiplier;
  }
  return price;
}
```

### Step 5: Run Tests Frequently

After each change:
```bash
npm test
```

If tests fail:
- Don't proceed
- Fix the failing test
- If the refactoring broke it, revert and try differently

### Step 6: Commit Frequently

```bash
git add [changed-files]
git commit -m "refactor: [what changed]"
```

**Example commit messages**:
```
refactor: extract calculateTotal function
refactor: move payment logic to PaymentService
refactor: remove duplicate validation code
refactor: simplify conditional in determineShipping
```

## Quality Checks

### After Refactoring

- [ ] All tests pass
- [ ] Code coverage maintained or improved
- [ ] Linting passes
- [ ] Type checking passes
- [ ] Build succeeds
- [ ] No behavior changes (unless intended and documented)

### Code Review Checklist

- [ ] Is the code more readable?
- [ ] Is the code less complex?
- [ ] Are responsibilities clearer?
- [ ] Is duplication reduced?
- [ ] Are tests still comprehensive?
- [ ] Is performance acceptable?

## Documentation

### Update Documentation

- [ ] Update code comments
- [ ] Update JSDoc/TSDoc
- [ ] Update module guide (`.claude/modules/[module].md`)
- [ ] Update architecture diagram if structure changed
- [ ] Add migration notes if needed

### Document the Refactoring

Add to module guide:

```markdown
## Recent Refactoring

### [Refactoring Name] - [Date]
**What changed**: [Brief description]
**Why**: [Reason for refactoring]
**Impact**: [What developers need to know]
**Migration**: [If any breaking changes]
```

## Common Refactoring Scenarios

### Scenario 1: Large Function

**Problem**: Function is too long (>50 lines)

**Solution**:
1. Identify logical sections
2. Extract each section to a named function
3. Keep main function as orchestrator
4. Each extracted function should do one thing

### Scenario 2: God Class

**Problem**: Class has too many responsibilities

**Solution**:
1. List all responsibilities
2. Group related responsibilities
3. Extract each group to a new class
4. Use composition in original class

### Scenario 3: Tight Coupling

**Problem**: Class/module directly depends on many others

**Solution**:
1. Identify dependencies
2. Extract interfaces for dependencies
3. Use dependency injection
4. Allow for easier testing and swapping

### Scenario 4: Unclear Names

**Problem**: Variables/functions have unclear names

**Solution**:
1. Rename to be descriptive
2. Use IDE refactoring tools
3. Update all references
4. Tests should still pass

### Scenario 5: Deep Nesting

**Problem**: Too many nested if/for/while statements

**Solution**:
1. Use guard clauses (early returns)
2. Extract nested logic to functions
3. Consider using array methods (map, filter, reduce)
4. Invert conditionals where appropriate

## Risky Refactorings

Some refactorings are high-risk. Extra caution needed:

### Database Schema Changes
- [ ] Create migration scripts
- [ ] Test with production-like data
- [ ] Have rollback plan
- [ ] Consider backward compatibility

### API Contract Changes
- [ ] Version the API
- [ ] Deprecate old endpoints gradually
- [ ] Communicate to API consumers
- [ ] Monitor usage of old endpoints

### Third-Party Integration Changes
- [ ] Test thoroughly in staging
- [ ] Have fallback mechanism
- [ ] Monitor error rates closely
- [ ] Coordinate with integration partner

## Rollback Plan

If refactoring causes issues in production:

### Immediate Rollback
```bash
# Revert the merge commit
git revert [merge-commit-hash]
git push
```

### Identify the Problem
1. What broke?
2. Why did tests not catch it?
3. What was missed?

### Fix Forward or Revert
- **Fix forward**: If problem is small and fix is obvious
- **Revert**: If problem is complex or impact is unclear

## Tips & Best Practices

### Do's
- ✅ Refactor with good test coverage
- ✅ Make small, incremental changes
- ✅ Keep tests passing after each change
- ✅ Commit frequently
- ✅ Have a clear goal
- ✅ Get code reviewed
- ✅ Measure before and after (if performance refactoring)

### Don'ts
- ❌ Refactor without tests
- ❌ Change behavior and refactor at the same time
- ❌ Make large, sweeping changes
- ❌ Refactor code you don't understand
- ❌ Skip code review
- ❌ Refactor because "it would be cool"

## Measuring Success

After refactoring, the code should be:

- [ ] More readable
- [ ] Easier to test
- [ ] Easier to modify
- [ ] Less duplicated
- [ ] Better organized
- [ ] Better performing (if that was the goal)

## Checklist

- [ ] Good reason for refactoring identified
- [ ] Test coverage adequate
- [ ] Refactoring plan created
- [ ] Context loaded for affected modules
- [ ] Baseline established (all tests passing)
- [ ] Changes made incrementally
- [ ] Tests pass after each change
- [ ] Commits are small and focused
- [ ] All quality checks pass
- [ ] Documentation updated
- [ ] Code reviewed
- [ ] Deployed and monitored
- [ ] No regressions detected
