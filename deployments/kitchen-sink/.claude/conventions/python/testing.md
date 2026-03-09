# Python Testing Conventions

> **When to read**: When writing tests or implementing testable code

## pytest Patterns

### Structure: AAA Pattern

```python
def test_calculate_total_with_tax():
    # Arrange
    items = [CartItem(price=Decimal("10"), quantity=2)]
    tax_rate = Decimal("0.1")

    # Act
    result = calculate_total(items, tax_rate)

    # Assert
    assert result == Decimal("22.00")
```

### Naming

```python
# Format: test_[what]_[condition]_[expected]
def test_get_user_with_valid_id_returns_user(): ...
def test_get_user_with_invalid_id_raises_not_found(): ...

# Group with classes
class TestUserService:
    class TestGetUser:
        def test_returns_user_when_exists(self): ...
        def test_raises_not_found_when_missing(self): ...
```

### Fixtures

```python
@pytest.fixture
def sample_user():
    return User(id="123", name="John", email="john@example.com")

# Use factories for variations
def make_user(**overrides) -> User:
    defaults = {"id": "123", "name": "John", "email": "john@example.com"}
    return User(**(defaults | overrides))
```

### Parametrize

```python
@pytest.mark.parametrize("email,expected", [
    ("valid@email.com", True),
    ("also.valid@email.co.uk", True),
    ("invalid", False),
    ("", False),
])
def test_validate_email(email, expected):
    assert validate_email(email) == expected
```

### Async Tests

```python
@pytest.mark.anyio
async def test_fetch_user_returns_data():
    user = await user_service.get_by_id("123")
    assert user.name == "John"
```

### Mocking

```python
# Mock external dependencies, not internal logic
async def test_payment_service(mocker):
    mocker.patch("app.services.payment.httpx.post", return_value=mock_response)
    result = await process_payment(order)
    assert result.status == "completed"
```

### FastAPI Integration Tests

```python
from httpx import AsyncClient, ASGITransport

@pytest.fixture
async def client(app):
    transport = ASGITransport(app=app)
    async with AsyncClient(transport=transport, base_url="http://test") as client:
        yield client

@pytest.mark.anyio
async def test_create_user_endpoint(client):
    response = await client.post("/users", json={"name": "John", "email": "john@example.com"})
    assert response.status_code == 201
```

## What to Test

**Do test**: Business logic, edge cases, error handling, API contracts, data transformations

**Don't test**: Framework internals, third-party library behavior, trivial getters/setters
