# Testing Conventions

> **When to read**: When writing tests or implementing testable code

## Testing Philosophy

- Tests are documentation
- Tests enable refactoring
- Tests catch regressions
- Tests should be fast and reliable

## Test Pyramid

```
        /\
       /E2E\        <- Few, slow, high-value
      /------\
     /  Integ \     <- Some, medium speed
    /----------\
   /    Unit    \   <- Many, fast, focused
  /--------------\
```

**Target distribution**:
- 70% Unit tests
- 20% Integration tests
- 10% E2E tests

## Unit Tests

### What to Test

**Do test**:
- Business logic
- Edge cases
- Error handling
- Data transformations
- Validation rules
- Utility functions

**Don't test**:
- Framework code
- Third-party libraries
- Trivial getters/setters
- Configuration files

### Test Structure: AAA Pattern

```typescript
describe('calculateTotal', () => {
  it('should calculate total with tax and shipping', () => {
    // Arrange - Set up test data
    const items = [
      { price: 10, quantity: 2 },
      { price: 5, quantity: 1 }
    ];
    const taxRate = 0.1;
    const shipping = 5;
    
    // Act - Execute the function
    const result = calculateTotal(items, taxRate, shipping);
    
    // Assert - Verify the result
    expect(result).toBe(30.5); // (10*2 + 5) * 1.1 + 5
  });
});
```

### Naming Conventions

```typescript
// Format: should [expected behavior] when [condition]

// ✅ Good
it('should return user when valid ID is provided', () => {});
it('should throw error when user not found', () => {});
it('should calculate discount for premium users', () => {});

// ❌ Bad
it('works', () => {});
it('test getUserById', () => {});
it('returns something', () => {});

// Group related tests
describe('UserService', () => {
  describe('getUserById', () => {
    it('should return user when user exists', () => {});
    it('should throw error when user not found', () => {});
    it('should throw error when ID is invalid', () => {});
  });
  
  describe('createUser', () => {
    it('should create user with valid data', () => {});
    it('should throw error when email is invalid', () => {});
  });
});
```

### Test Coverage Goals

```typescript
// Aim for high coverage on critical paths
// 80%+ for business logic
// 60%+ overall

// Check coverage
npm run test:coverage

// Don't obsess over 100% coverage
// Focus on meaningful tests
```

### Mocking

```typescript
// Mock external dependencies, not internal logic

// ✅ Good: Mock external API
const mockFetch = jest.fn().mockResolvedValue({
  ok: true,
  json: async () => ({ data: 'mocked' })
});

global.fetch = mockFetch;

// ✅ Good: Mock database
const mockDb = {
  query: jest.fn().mockResolvedValue([{ id: 1, name: 'John' }])
};

// ❌ Bad: Mocking everything makes tests fragile
const mockEverything = jest.fn();
```

### Test Fixtures

```typescript
// Create reusable test data

// fixtures/user.ts
export const mockUser = {
  id: '123',
  name: 'John Doe',
  email: 'john@example.com'
};

export const mockAdminUser = {
  ...mockUser,
  role: 'admin'
};

// Use in tests
import { mockUser, mockAdminUser } from '@/fixtures/user';

it('should allow admin to delete users', () => {
  const result = deleteUser(mockAdminUser, 'target-id');
  expect(result.success).toBe(true);
});
```

### Async Testing

```typescript
// Always await async operations

// ✅ Good
it('should fetch user data', async () => {
  const user = await getUserById('123');
  expect(user.name).toBe('John');
});

// ❌ Bad - Missing await
it('should fetch user data', () => {
  const user = getUserById('123'); // Returns a Promise!
  expect(user.name).toBe('John'); // This will fail
});

// Test error cases
it('should throw error when user not found', async () => {
  await expect(getUserById('invalid')).rejects.toThrow('User not found');
});
```

### Parameterized Tests

```typescript
// Test multiple cases efficiently

describe('validateEmail', () => {
  it.each([
    ['valid@email.com', true],
    ['another.valid@email.co.uk', true],
    ['invalid', false],
    ['@invalid.com', false],
    ['invalid@', false],
    ['', false]
  ])('should return %p for email %s', (email, expected) => {
    expect(validateEmail(email)).toBe(expected);
  });
});
```

## Integration Tests

### What to Test

- Module interactions
- Database queries
- External API calls
- File system operations
- Event handling

### Database Integration Tests

```typescript
describe('UserRepository (Integration)', () => {
  // Setup test database
  beforeAll(async () => {
    await setupTestDatabase();
  });
  
  // Clean up after each test
  afterEach(async () => {
    await clearDatabase();
  });
  
  // Tear down after all tests
  afterAll(async () => {
    await teardownTestDatabase();
  });
  
  it('should save and retrieve user from database', async () => {
    // Arrange
    const user = { name: 'John', email: 'john@example.com' };
    
    // Act
    const created = await userRepository.create(user);
    const retrieved = await userRepository.findById(created.id);
    
    // Assert
    expect(retrieved).toMatchObject(user);
  });
});
```

### API Integration Tests

```typescript
describe('API Integration', () => {
  let server;
  
  beforeAll(async () => {
    server = await startTestServer();
  });
  
  afterAll(async () => {
    await server.close();
  });
  
  it('should create user via API', async () => {
    const response = await fetch('http://localhost:3000/users', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        name: 'John',
        email: 'john@example.com'
      })
    });
    
    expect(response.status).toBe(201);
    const user = await response.json();
    expect(user).toHaveProperty('id');
    expect(user.name).toBe('John');
  });
});
```

## E2E Tests

### What to Test

- Critical user flows
- Happy paths through entire system
- Key business scenarios

### E2E Test Example

```typescript
// Using Playwright or similar
describe('User Registration Flow', () => {
  it('should allow new user to register and login', async () => {
    // Navigate to registration
    await page.goto('/register');
    
    // Fill registration form
    await page.fill('[name="name"]', 'John Doe');
    await page.fill('[name="email"]', 'john@example.com');
    await page.fill('[name="password"]', 'SecurePass123!');
    
    // Submit
    await page.click('button[type="submit"]');
    
    // Verify redirect to dashboard
    await page.waitForURL('/dashboard');
    
    // Verify user name is displayed
    const userName = await page.textContent('[data-testid="user-name"]');
    expect(userName).toBe('John Doe');
  });
});
```

### E2E Best Practices

```typescript
// Use data-testid attributes for reliable selectors
// ✅ Good
<button data-testid="submit-button">Submit</button>
await page.click('[data-testid="submit-button"]');

// ❌ Bad - fragile selectors
await page.click('button.btn-primary.large');

// Keep E2E tests independent
// Each test should set up its own data and clean up

// Don't test implementation details
// ✅ Good - test user behavior
it('should show error when form is invalid', async () => {
  await page.click('button[type="submit"]');
  await expect(page.locator('.error')).toBeVisible();
});

// ❌ Bad - test internal state
it('should set isValid to false', () => {
  // This is implementation detail
});
```

## Test Utilities

### Custom Matchers

```typescript
// Create custom matchers for common assertions
expect.extend({
  toBeValidEmail(received) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    const pass = emailRegex.test(received);
    
    return {
      pass,
      message: () => `expected ${received} to be a valid email`
    };
  }
});

// Usage
expect('john@example.com').toBeValidEmail();
```

### Test Helpers

```typescript
// helpers/test-utils.ts

export function createMockUser(overrides = {}) {
  return {
    id: '123',
    name: 'Test User',
    email: 'test@example.com',
    ...overrides
  };
}

export async function createTestUser(overrides = {}) {
  const user = createMockUser(overrides);
  return await userRepository.create(user);
}

// Usage
const user = createMockUser({ role: 'admin' });
const savedUser = await createTestUser({ name: 'John' });
```

## Performance Testing

### Test Performance

```typescript
describe('Performance', () => {
  it('should process 1000 items in under 100ms', () => {
    const items = Array.from({ length: 1000 }, (_, i) => i);
    
    const start = performance.now();
    processItems(items);
    const end = performance.now();
    
    expect(end - start).toBeLessThan(100);
  });
  
  it('should handle large dataset without memory issues', () => {
    const largeDataset = generateLargeDataset(100000);
    
    // This should not crash or hang
    expect(() => processDataset(largeDataset)).not.toThrow();
  });
});
```

## Snapshot Testing

```typescript
// Use for complex objects or UI components
// But use sparingly - snapshots can become brittle

describe('UserProfile', () => {
  it('should match snapshot', () => {
    const profile = generateUserProfile(mockUser);
    expect(profile).toMatchSnapshot();
  });
});

// Update snapshots when intentionally changing output
// npm test -- -u

// Review snapshot diffs carefully in code review
```

## Flaky Test Prevention

```typescript
// Avoid timing-based assertions
// ❌ Bad - flaky
it('should debounce function', async () => {
  debouncedFunction();
  await sleep(100);
  expect(spy).toHaveBeenCalledTimes(1);
});

// ✅ Good - deterministic
it('should debounce function', async () => {
  jest.useFakeTimers();
  debouncedFunction();
  jest.advanceTimersByTime(100);
  expect(spy).toHaveBeenCalledTimes(1);
  jest.useRealTimers();
});

// Avoid testing implementation details
// Test behavior, not internals

// Make tests isolated
// Each test should be independent
beforeEach(() => {
  // Reset state
  jest.clearAllMocks();
});
```

## Test Organization

### File Structure

```
src/
├── services/
│   ├── user-service.ts
│   └── user-service.test.ts
└── __tests__/
    ├── integration/
    │   └── user-flow.test.ts
    └── e2e/
        └── registration.test.ts
```

### Test Configuration

```javascript
// jest.config.js
module.exports = {
  // Unit tests
  testMatch: ['**/*.test.ts'],
  
  // Integration tests
  testMatch: ['**/__tests__/integration/**/*.test.ts'],
  
  // E2E tests
  testMatch: ['**/__tests__/e2e/**/*.test.ts'],
  
  // Coverage
  collectCoverageFrom: [
    'src/**/*.ts',
    '!src/**/*.test.ts',
    '!src/**/__tests__/**'
  ],
  coverageThresholds: {
    global: {
      statements: 80,
      branches: 80,
      functions: 80,
      lines: 80
    }
  }
};
```

## Common Testing Patterns

### Testing Error Cases

```typescript
describe('Error Handling', () => {
  it('should throw specific error type', () => {
    expect(() => validateUser(null)).toThrow(ValidationError);
  });
  
  it('should throw with specific message', () => {
    expect(() => validateUser(null)).toThrow('User is required');
  });
  
  it('should handle async errors', async () => {
    await expect(fetchUser('invalid')).rejects.toThrow(NotFoundError);
  });
});
```

### Testing Side Effects

```typescript
describe('Side Effects', () => {
  it('should log error when operation fails', async () => {
    const logSpy = jest.spyOn(logger, 'error');
    
    await expect(riskyOperation()).rejects.toThrow();
    
    expect(logSpy).toHaveBeenCalledWith(
      expect.stringContaining('Operation failed'),
      expect.any(Error)
    );
  });
  
  it('should call callback after completion', async () => {
    const callback = jest.fn();
    await operation(callback);
    expect(callback).toHaveBeenCalledTimes(1);
  });
});
```

### Testing Dates and Time

```typescript
describe('Date Handling', () => {
  beforeEach(() => {
    // Freeze time for consistent tests
    jest.useFakeTimers();
    jest.setSystemTime(new Date('2024-01-15'));
  });
  
  afterEach(() => {
    jest.useRealTimers();
  });
  
  it('should calculate expiry date correctly', () => {
    const expiry = calculateExpiry(30); // 30 days from now
    expect(expiry).toEqual(new Date('2024-02-14'));
  });
});
```

## Test Maintenance

### Keeping Tests Maintainable

- Keep tests simple and focused
- Don't test implementation details
- Use descriptive test names
- Group related tests
- Extract common setup to helpers
- Keep test data minimal

### Refactoring Tests

```typescript
// Before: Duplicated setup
it('test 1', () => {
  const user = { id: '1', name: 'John', email: 'john@example.com' };
  const result = processUser(user);
  expect(result.success).toBe(true);
});

it('test 2', () => {
  const user = { id: '1', name: 'John', email: 'john@example.com' };
  const result = validateUser(user);
  expect(result.valid).toBe(true);
});

// After: Extract common setup
describe('User Operations', () => {
  let testUser;
  
  beforeEach(() => {
    testUser = { id: '1', name: 'John', email: 'john@example.com' };
  });
  
  it('should process user successfully', () => {
    const result = processUser(testUser);
    expect(result.success).toBe(true);
  });
  
  it('should validate user successfully', () => {
    const result = validateUser(testUser);
    expect(result.valid).toBe(true);
  });
});
```

## Debugging Tests

```typescript
// Add .only to run a single test
it.only('should debug this test', () => {
  // Only this test will run
});

// Add .skip to skip a test temporarily
it.skip('should fix this test later', () => {
  // This test will be skipped
});

// Use console.log for debugging (remove before committing)
it('should debug', () => {
  const result = complexOperation();
  console.log('Debug:', result);
  expect(result).toBeDefined();
});

// Use debugger statement
it('should pause execution', () => {
  debugger; // Execution pauses here
  const result = operation();
});
```

## Checklist

Before merging code:

- [ ] All tests pass
- [ ] New functionality has tests
- [ ] Bug fixes have regression tests
- [ ] Tests are not flaky
- [ ] Tests are fast
- [ ] Tests are readable
- [ ] Coverage meets threshold
- [ ] No .only or .skip left in code
- [ ] No console.logs left in tests
- [ ] Test names are descriptive
