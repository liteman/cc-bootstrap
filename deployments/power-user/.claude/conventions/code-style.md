# Code Style Conventions

> **When to read**: Reference when writing or reviewing code

## Philosophy

Code is read far more often than it's written. Prioritize:
1. **Readability** over cleverness
2. **Consistency** over personal preference
3. **Simplicity** over complexity
4. **Explicitness** over implicitness

## Language-Specific Guides

### [Primary Language - e.g., TypeScript]

#### Naming Conventions

```typescript
// Classes: PascalCase
class UserService { }
class PaymentProcessor { }

// Interfaces/Types: PascalCase with 'I' prefix (optional based on team preference)
interface User { }
type PaymentMethod = 'card' | 'bank';

// Functions/Methods: camelCase, verb-based
function getUserById(id: string) { }
function calculateTotal(items: Item[]) { }

// Variables: camelCase, noun-based
const userName = 'John';
const orderTotal = 100;

// Constants: SCREAMING_SNAKE_CASE
const MAX_RETRY_ATTEMPTS = 3;
const API_BASE_URL = 'https://api.example.com';

// Booleans: Prefixed with is/has/can/should
const isValid = true;
const hasPermission = false;
const canEdit = true;
const shouldRetry = false;

// Private members: prefix with underscore (optional)
class Example {
  private _internalState: string;
  
  // Or without underscore (TypeScript handles private keyword)
  private internalState: string;
}

// Files: kebab-case
user-service.ts
payment-processor.ts
```

#### File Organization

```typescript
// 1. Imports - grouped and sorted
// External dependencies first
import React from 'react';
import { useState } from 'react';

// Internal dependencies
import { UserService } from '@/services/user-service';
import { formatDate } from '@/utils/date';

// Types
import type { User } from '@/types/user';

// 2. Type definitions
interface ComponentProps {
  user: User;
}

// 3. Constants
const MAX_ITEMS = 100;

// 4. Main implementation
export function Component({ user }: ComponentProps) {
  // Implementation
}

// 5. Helper functions (if small, otherwise extract to separate file)
function helperFunction() {
  // Implementation
}
```

#### Functions

```typescript
// Function length: Aim for <20 lines, max 50
// If longer, break into smaller functions

// ✅ Good: Single responsibility, clear purpose
function calculateTax(amount: number, rate: number): number {
  return amount * rate;
}

// ❌ Bad: Multiple responsibilities
function processOrderAndSendEmailAndUpdateInventory(order: Order) {
  // Too much in one function
}

// ✅ Good: Early returns for clarity
function validateUser(user: User): boolean {
  if (!user) return false;
  if (!user.email) return false;
  if (!user.name) return false;
  return true;
}

// ❌ Bad: Deeply nested
function validateUser(user: User): boolean {
  if (user) {
    if (user.email) {
      if (user.name) {
        return true;
      }
    }
  }
  return false;
}

// Function parameters: Max 3-4 parameters
// If more, use an options object

// ✅ Good
function createUser(options: CreateUserOptions) {
  const { name, email, age, role, department } = options;
}

// ❌ Bad
function createUser(name: string, email: string, age: number, role: string, department: string) {
  // Too many parameters
}
```

#### Comments

```typescript
// Use comments to explain WHY, not WHAT

// ✅ Good: Explains reasoning
// Using exponential backoff to avoid overwhelming the server
// after a spike in failed requests
const backoffDelay = Math.pow(2, attemptNumber) * 1000;

// ❌ Bad: States the obvious
// Multiply 2 to the power of attemptNumber and multiply by 1000
const backoffDelay = Math.pow(2, attemptNumber) * 1000;

// JSDoc for public APIs
/**
 * Calculates the total price including tax and shipping
 * @param items - Array of items in the cart
 * @param taxRate - Tax rate as a decimal (e.g., 0.1 for 10%)
 * @param shippingCost - Fixed shipping cost
 * @returns Total price including all fees
 * @throws {ValidationError} If items array is empty
 */
function calculateTotal(
  items: CartItem[],
  taxRate: number,
  shippingCost: number
): number {
  // Implementation
}

// TODO comments: Include ticket number and date
// TODO(#123): Refactor this to use new payment API - 2024-01-15
```

#### Error Handling

```typescript
// Use specific error types
class ValidationError extends Error {
  constructor(message: string) {
    super(message);
    this.name = 'ValidationError';
  }
}

// Always provide context in errors
// ✅ Good
throw new ValidationError(`Invalid email format: ${email}`);

// ❌ Bad
throw new Error('Invalid');

// Catch specific errors, not all errors
try {
  await riskyOperation();
} catch (error) {
  if (error instanceof ValidationError) {
    // Handle validation errors
  } else if (error instanceof NetworkError) {
    // Handle network errors
  } else {
    // Log unexpected errors and re-throw
    logger.error('Unexpected error', error);
    throw error;
  }
}

// Don't swallow errors
// ❌ Bad
try {
  await operation();
} catch (error) {
  // Silent failure
}

// ✅ Good
try {
  await operation();
} catch (error) {
  logger.error('Operation failed', error);
  throw error; // or handle appropriately
}
```

## Code Organization

### Directory Structure

```
src/
├── components/       # UI components
├── services/         # Business logic
├── repositories/     # Data access
├── utils/            # Utility functions
├── types/            # Type definitions
├── constants/        # Constants and enums
├── hooks/            # Custom hooks (React)
└── tests/            # Test files

# Each directory should have an index.ts for clean exports
```

### Module Exports

```typescript
// index.ts - Clean public API
export { UserService } from './user-service';
export { validateUser } from './validators';
export type { User, UserRole } from './types';

// Don't export everything
// Be intentional about public API
```

## Testing Conventions

### Test File Naming

```
# Place tests next to source files or in __tests__ directory
user-service.ts
user-service.test.ts

# Or
user-service/
  index.ts
  __tests__/
    index.test.ts
```

### Test Structure

```typescript
describe('UserService', () => {
  // Group related tests
  describe('getUserById', () => {
    it('should return user when user exists', async () => {
      // Arrange
      const userId = '123';
      const expectedUser = { id: userId, name: 'John' };
      
      // Act
      const result = await userService.getUserById(userId);
      
      // Assert
      expect(result).toEqual(expectedUser);
    });
    
    it('should throw error when user not found', async () => {
      // Arrange
      const userId = 'nonexistent';
      
      // Act & Assert
      await expect(
        userService.getUserById(userId)
      ).rejects.toThrow('User not found');
    });
  });
});

// Test names should be descriptive
// ✅ Good
it('should return empty array when no items in cart', () => { });

// ❌ Bad
it('works', () => { });
it('test1', () => { });
```

## Git Conventions

### Commit Messages

```bash
# Format: <type>: <description>
# 
# Types: feat, fix, docs, style, refactor, test, chore

# ✅ Good commits
feat: add user authentication with JWT
fix: prevent null pointer in payment processing
docs: update API documentation for /users endpoint
refactor: extract duplicate validation logic
test: add integration tests for order flow

# ❌ Bad commits
fix stuff
updates
wip
asdf
```

### Branch Naming

```bash
# Format: <type>/<description>

# ✅ Good
feat/user-authentication
fix/payment-null-pointer
refactor/extract-validation
docs/api-documentation

# ❌ Bad
my-branch
test
updates
branch1
```

## Performance Guidelines

### Avoid Premature Optimization

```typescript
// ✅ Write clear code first
function findUser(users: User[], id: string): User | undefined {
  return users.find(user => user.id === id);
}

// ⚠️ Only optimize if profiling shows it's a bottleneck
// Then you might use a Map for O(1) lookup
const userMap = new Map(users.map(u => [u.id, u]));
const user = userMap.get(id);
```

### Common Performance Patterns

```typescript
// Memoize expensive calculations
const memoizedResult = useMemo(
  () => expensiveCalculation(data),
  [data]
);

// Debounce frequent operations
const debouncedSearch = debounce(search, 300);

// Batch database queries
const users = await User.findMany({
  where: { id: { in: userIds } }
}); // Better than multiple queries

// Use pagination for large datasets
const results = await getUsers({
  page: 1,
  limit: 50
});
```

## Security Guidelines

### Input Validation

```typescript
// Always validate and sanitize user input
function createUser(input: unknown) {
  // Validate
  const validated = UserSchema.parse(input);
  
  // Sanitize
  const sanitized = {
    ...validated,
    name: sanitizeHtml(validated.name),
    email: validated.email.toLowerCase().trim()
  };
  
  return userService.create(sanitized);
}
```

### Sensitive Data

```typescript
// Never log sensitive data
// ❌ Bad
logger.info('User login', { email, password });

// ✅ Good
logger.info('User login', { email });

// Don't expose sensitive data in errors
// ❌ Bad
throw new Error(`Invalid password: ${password}`);

// ✅ Good
throw new Error('Invalid credentials');
```

### SQL Injection Prevention

```typescript
// Always use parameterized queries
// ✅ Good
const user = await db.query(
  'SELECT * FROM users WHERE id = $1',
  [userId]
);

// ❌ Bad
const user = await db.query(
  `SELECT * FROM users WHERE id = '${userId}'`
);
```

## Accessibility (if applicable)

### HTML/React Best Practices

```typescript
// Use semantic HTML
// ✅ Good
<nav>
  <ul>
    <li><a href="/home">Home</a></li>
  </ul>
</nav>

// ❌ Bad
<div className="nav">
  <div className="list">
    <div className="item" onclick="navigate('/home')">Home</div>
  </div>
</div>

// Always include alt text for images
<img src="logo.png" alt="Company logo" />

// Use aria labels when needed
<button aria-label="Close dialog">×</button>
```

## Code Review Guidelines

### What to Look For

- [ ] Does it follow our conventions?
- [ ] Is it readable and maintainable?
- [ ] Are there tests?
- [ ] Is error handling adequate?
- [ ] Are there security concerns?
- [ ] Is it performant enough?
- [ ] Is the documentation updated?

### Giving Feedback

```
# Be specific and constructive
# ✅ Good
"Consider extracting this logic into a separate function 
for better testability. Something like `validatePaymentMethod()`"

# ❌ Bad
"This is messy"
"Rewrite this"
```

## Linting & Formatting

### Configuration Files

```json
// .eslintrc.json
{
  "extends": ["eslint:recommended", "plugin:@typescript-eslint/recommended"],
  "rules": {
    "no-console": "warn",
    "no-unused-vars": "error"
  }
}

// .prettierrc
{
  "semi": true,
  "trailingComma": "es5",
  "singleQuote": true,
  "printWidth": 100,
  "tabWidth": 2
}
```

### Pre-commit Hooks

```json
// package.json
{
  "husky": {
    "hooks": {
      "pre-commit": "lint-staged"
    }
  },
  "lint-staged": {
    "*.{js,ts,tsx}": [
      "eslint --fix",
      "prettier --write"
    ]
  }
}
```

## Checklist

Before submitting code:

- [ ] Code follows naming conventions
- [ ] Functions are small and focused
- [ ] Comments explain WHY, not WHAT
- [ ] Error handling is comprehensive
- [ ] No sensitive data in logs
- [ ] Tests are included
- [ ] Linting passes
- [ ] No console.logs left in code
- [ ] Types are properly defined
- [ ] Documentation is updated
