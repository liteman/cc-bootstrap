# Git Workflow Conventions

> **When to read**: Before creating branches, making commits, or submitting PRs

## Branching Strategy

### Branch Types

```bash
# Feature branches
feat/feature-description
feat/oauth-login
feat/user-dashboard

# Bug fix branches
fix/bug-description
fix/payment-null-pointer
fix/login-redirect-loop

# Refactoring branches
refactor/description
refactor/extract-auth-service
refactor/simplify-validation

# Documentation branches
docs/description
docs/api-endpoints
docs/setup-guide

# Chore branches (maintenance, deps, config)
chore/description
chore/update-dependencies
chore/configure-eslint
```

### Branch Naming Rules

- Use lowercase
- Use hyphens, not underscores
- Be descriptive but concise
- Include ticket number if applicable: `feat/AUTH-123-oauth-login`

### Branch Lifecycle

```bash
# Create branch from main
git checkout main
git pull origin main
git checkout -b feat/new-feature

# Work on your feature
git add [files]
git commit -m "feat: add feature"

# Keep branch up to date
git checkout main
git pull origin main
git checkout feat/new-feature
git rebase main

# Push to remote
git push origin feat/new-feature

# After merge, delete branch
git branch -d feat/new-feature
git push origin --delete feat/new-feature
```

## Commit Messages

### Format

```
<type>: <subject>

[optional body]

[optional footer]
```

### Types

- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation only
- `style`: Code style (formatting, missing semicolons, etc.)
- `refactor`: Code change that neither fixes a bug nor adds a feature
- `perf`: Performance improvement
- `test`: Adding or updating tests
- `chore`: Maintenance (dependencies, config, etc.)
- `revert`: Revert a previous commit

### Examples

```bash
# Simple feature
feat: add Google OAuth login

# Bug fix with details
fix: prevent null pointer in payment processing

Users with incomplete profiles were experiencing crashes during
checkout due to missing validation on profile.paymentMethod.

Fixes #456

# Breaking change
feat!: change API response format

BREAKING CHANGE: The /users endpoint now returns an array
instead of an object with a 'users' property.

Migration: Update client code to handle array response directly.

# Multiple changes in body
refactor: restructure authentication module

- Extract OAuth logic to separate service
- Consolidate validation functions
- Update tests to use new structure

# With ticket reference
feat: add user profile editing (PROJ-123)

Implements the user profile editing feature as specified
in the design document.

Closes #123
```

### Commit Message Rules

**Subject line**:
- Max 72 characters
- Lowercase after the type
- No period at the end
- Imperative mood ("add" not "added")

**Body**:
- Wrap at 72 characters
- Explain what and why, not how
- Separate from subject with blank line

**Footer**:
- Reference issues/PRs
- Note breaking changes

### Good vs Bad Commits

```bash
# ✅ Good commits
feat: add user authentication with JWT
fix: resolve race condition in order processing
docs: update API documentation for v2 endpoints
refactor: extract duplicate validation logic
test: add integration tests for payment flow

# ❌ Bad commits
fixed stuff
updates
wip
asdf
minor changes
```

## Commit Frequency

### When to Commit

**Do commit**:
- After completing a logical unit of work
- Before switching tasks
- Before taking a break
- When tests pass

**Don't commit**:
- Half-finished work (unless using WIP branch)
- Broken code
- Code that doesn't compile
- With failing tests (unless that's the point)

### Commit Size

**Ideal commit**:
- Single logical change
- Related files changed together
- Can be understood in isolation
- Can be reverted if needed

**Too large**:
- Multiple features in one commit
- Changes to unrelated areas
- Thousands of lines changed

**Too small**:
- Fixing a typo in commit message (use --amend)
- Changing one character
- Adding a missing semicolon

## Pull Requests

### PR Title

Use the same format as commit messages:

```
feat: add user authentication
fix: prevent duplicate order creation
docs: update deployment guide
```

### PR Description Template

```markdown
## Description
[Clear description of what this PR does and why]

## Type of Change
- [ ] Bug fix (non-breaking change that fixes an issue)
- [ ] New feature (non-breaking change that adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] Documentation update
- [ ] Refactoring
- [ ] Performance improvement

## Related Issues
Fixes #[issue number]
Relates to #[issue number]

## How Has This Been Tested?
- [ ] Unit tests
- [ ] Integration tests
- [ ] Manual testing
- [ ] E2E tests

## Testing Instructions
1. [Step 1]
2. [Step 2]
3. [Expected result]

## Screenshots (if applicable)
[Add screenshots or GIFs for UI changes]

## Checklist
- [ ] My code follows the project's style guidelines
- [ ] I have performed a self-review of my own code
- [ ] I have commented my code, particularly in hard-to-understand areas
- [ ] I have made corresponding changes to the documentation
- [ ] My changes generate no new warnings
- [ ] I have added tests that prove my fix is effective or that my feature works
- [ ] New and existing unit tests pass locally with my changes
- [ ] Any dependent changes have been merged and published

## Breaking Changes
[If this PR introduces breaking changes, describe them here and provide migration instructions]

## Additional Notes
[Any additional information that reviewers should know]
```

### PR Size Guidelines

**Small (Preferred)**:
- < 200 lines changed
- Single feature or fix
- Easy to review
- Quick to merge

**Medium**:
- 200-500 lines changed
- Still focused on one thing
- Review takes 15-30 minutes

**Large**:
- 500+ lines changed
- Consider breaking into smaller PRs
- Hard to review thoroughly

### PR Labels

Use labels to categorize PRs:

- `bug` - Bug fixes
- `feature` - New features
- `documentation` - Documentation changes
- `refactor` - Code refactoring
- `performance` - Performance improvements
- `breaking-change` - Breaking changes
- `needs-review` - Ready for review
- `work-in-progress` - Not ready for review yet
- `blocked` - Blocked by other work

## Code Review Process

### As Author

**Before requesting review**:
- [ ] Self-review your changes
- [ ] All tests pass
- [ ] Code follows style guide
- [ ] Documentation updated
- [ ] No debug code left in
- [ ] No console.logs
- [ ] Commits are clean

**During review**:
- Respond to all comments
- Be open to feedback
- Explain your decisions
- Make requested changes
- Re-request review after changes

### As Reviewer

**What to review**:
- [ ] Code correctness
- [ ] Edge cases handled
- [ ] Error handling adequate
- [ ] Tests comprehensive
- [ ] Documentation updated
- [ ] Performance acceptable
- [ ] Security considerations
- [ ] Code style compliance

**How to give feedback**:
- Be specific and constructive
- Explain the "why"
- Suggest alternatives
- Praise good work
- Distinguish between "must fix" and "nice to have"

**Feedback levels**:
- 🚨 **Critical**: Must be fixed before merge
- ⚠️ **Important**: Should be fixed
- 💭 **Suggestion**: Consider this
- ✅ **Approval**: Looks good

## Merging Strategy

### Squash and Merge (Recommended)

```bash
# All commits squashed into one on main
# Clean, linear history
# Easy to revert
```

**When to use**: Most feature branches

### Rebase and Merge

```bash
# Maintains individual commits
# Linear history
# More detailed history
```

**When to use**: When commit history is clean and meaningful

### Merge Commit

```bash
# Creates merge commit
# Preserves branch history
# Can create complex history
```

**When to use**: Long-lived feature branches, releases

## Hotfix Process

For critical production bugs:

```bash
# 1. Create hotfix branch from main
git checkout main
git pull origin main
git checkout -b hotfix/critical-bug

# 2. Fix the bug
git add [files]
git commit -m "fix: critical bug description"

# 3. Create PR with "hotfix" label
# Get expedited review

# 4. After merge, ensure fix is in develop/next release
```

## Release Process

### Version Tagging

```bash
# Create annotated tag
git tag -a v1.2.3 -m "Release version 1.2.3"

# Push tags
git push origin v1.2.3

# Or push all tags
git push --tags
```

### Semantic Versioning

```
v[MAJOR].[MINOR].[PATCH]

MAJOR: Breaking changes
MINOR: New features (backward compatible)
PATCH: Bug fixes (backward compatible)

Examples:
v1.0.0 → v2.0.0 (breaking change)
v1.0.0 → v1.1.0 (new feature)
v1.0.0 → v1.0.1 (bug fix)
```

## Common Workflows

### Starting New Work

```bash
git checkout main
git pull origin main
git checkout -b feat/new-feature
# Make changes
git add .
git commit -m "feat: implement new feature"
git push origin feat/new-feature
# Create PR
```

### Updating Feature Branch

```bash
git checkout main
git pull origin main
git checkout feat/your-feature
git rebase main
# Resolve conflicts if any
git push --force-with-lease origin feat/your-feature
```

### Amending Last Commit

```bash
# Make changes
git add [files]
git commit --amend --no-edit

# Or with new message
git commit --amend -m "new commit message"

# Force push (only if not yet reviewed)
git push --force-with-lease
```

### Reverting Changes

```bash
# Revert a commit (creates new commit)
git revert [commit-hash]

# Reset to previous commit (destructive)
git reset --hard [commit-hash]
```

### Cherry-picking

```bash
# Apply a commit from another branch
git cherry-pick [commit-hash]
```

## Git Hygiene

### Do's
- ✅ Write clear commit messages
- ✅ Commit small, logical changes
- ✅ Pull before starting work
- ✅ Push regularly
- ✅ Keep branches up to date
- ✅ Delete merged branches

### Don'ts
- ❌ Commit sensitive data (passwords, keys, secrets)
- ❌ Commit directly to main
- ❌ Force push to shared branches
- ❌ Commit build artifacts or dependencies
- ❌ Leave branches stale for months
- ❌ Ignore merge conflicts

## Tools & Automation

### Git Hooks

```bash
# .git/hooks/pre-commit
# Run linting before commit
npm run lint

# .git/hooks/pre-push
# Run tests before push
npm test
```

### Git Aliases

```bash
# ~/.gitconfig
[alias]
    co = checkout
    br = branch
    ci = commit
    st = status
    unstage = reset HEAD --
    last = log -1 HEAD
    visual = log --graph --oneline --all
```

### Commit Message Linting

```json
// package.json
{
  "husky": {
    "hooks": {
      "commit-msg": "commitlint -E HUSKY_GIT_PARAMS"
    }
  }
}
```

## Troubleshooting

### Accidentally Committed to Main

```bash
# Move commits to new branch
git branch feat/my-feature
git reset --hard origin/main
git checkout feat/my-feature
```

### Need to Undo Last Commit

```bash
# Keep changes
git reset --soft HEAD~1

# Discard changes
git reset --hard HEAD~1
```

### Merge Conflicts

```bash
# During rebase
git rebase main
# Fix conflicts
git add [resolved-files]
git rebase --continue

# During merge
git merge main
# Fix conflicts
git add [resolved-files]
git commit
```

## Checklist

Before pushing:
- [ ] Code compiles/builds
- [ ] Tests pass
- [ ] Linting passes
- [ ] Commit messages follow convention
- [ ] No sensitive data committed
- [ ] Branch is up to date with main

Before creating PR:
- [ ] Self-review completed
- [ ] All commits are meaningful
- [ ] PR description is clear
- [ ] Tests are included
- [ ] Documentation is updated
