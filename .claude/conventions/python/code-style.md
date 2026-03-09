# Python Code Style Conventions

> **When to read**: Reference when writing or reviewing Python code

## Naming

```python
# Classes: PascalCase
class UserService: ...
class PaymentProcessor: ...

# Functions/methods: snake_case, verb-based
def get_user_by_id(user_id: str) -> User: ...
def calculate_total(items: list[Item]) -> Decimal: ...

# Variables: snake_case, noun-based
user_name = "John"
order_total = Decimal("100.00")

# Constants: SCREAMING_SNAKE_CASE
MAX_RETRY_ATTEMPTS = 3
DEFAULT_PAGE_SIZE = 50

# Booleans: prefixed with is/has/can/should
is_valid = True
has_permission = False

# Private: single leading underscore
def _internal_helper(): ...

# Files/modules: snake_case
user_service.py
payment_processor.py
```

## Function Design

```python
# Keep functions short — aim for <20 lines, max 40
# Single responsibility, early returns for clarity

def validate_user(user: User) -> bool:
    if not user:
        return False
    if not user.email:
        return False
    return is_valid_email(user.email)

# Max 3-4 parameters — use a dataclass or TypedDict for more
def create_user(request: CreateUserRequest) -> User: ...
```

## Imports

```python
# Standard library
import os
from pathlib import Path
from typing import Any

# Third-party
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.ext.asyncio import AsyncSession

# Local
from app.models.user import User
from app.services.auth import get_current_user
```

## Comments

```python
# Explain WHY, not WHAT
# Docstrings for public APIs only — skip for obvious internal functions

def calculate_shipping(items: list[CartItem], destination: Address) -> Decimal:
    """Calculate shipping cost based on total weight and destination zone.

    Applies free shipping for orders over $50 to domestic addresses.
    """
```

## Error Handling

```python
# Use specific exceptions with context
class UserNotFoundError(Exception):
    def __init__(self, user_id: str):
        super().__init__(f"User not found: {user_id}")
        self.user_id = user_id

# Never swallow errors silently
# Always re-raise or handle meaningfully
```

## Type Hints

```python
# Use type hints for function signatures and complex variables
# Skip for obvious local variables where the type is clear from the value
def get_users(page: int = 1, limit: int = 50) -> list[User]: ...
```

## FastAPI Patterns

```python
# One router per domain
router = APIRouter(prefix="/users", tags=["users"])

# Dependency injection over global state
@router.get("/{user_id}")
async def get_user(
    user_id: str,
    db: AsyncSession = Depends(get_db),
    current_user: User = Depends(get_current_user),
) -> UserResponse: ...

# Pydantic models for request/response — not raw dicts
class CreateUserRequest(BaseModel):
    name: str = Field(..., min_length=1, max_length=100)
    email: EmailStr
```

## File Organization

```
app/
├── routes/          # API endpoints (thin — delegate to services)
├── services/        # Business logic
├── models/          # SQLAlchemy/ORM models
├── schemas/         # Pydantic request/response models
├── dependencies/    # FastAPI dependency injection
├── utils/           # Pure utility functions
└── tests/           # Mirror the app structure
```
