Perform a basic documentation review of the `.claude/` directory.

**Mode**: `$ARGUMENTS` (default: `full` if no argument provided)

## Steps

1. **Discovery**: Read all `.md` files in `.claude/` and `docs/` directories. Track file names and line counts.
2. **Analysis**: Check each file for:
   - Outdated information or stale references
   - Broken internal file references (paths that don't exist)
   - Missing documentation gaps
   - Placeholder content that was never filled in (e.g., `[BRACKETS]` still present)
3. **Report**: Present findings grouped by priority:
   - **Critical**: Incorrect information that could cause bugs or security issues
   - **High**: Significantly outdated info, missing core docs, broken references
   - **Medium** (skip for `quick` mode): Minor outdated references, duplicate content, oversized files
   - **Low** (skip for `quick` mode): Formatting inconsistencies, minor improvements

If mode is `quick`, only report Critical and High priority issues.

For the full audit skill with CI/CD integration, see the kitchen-sink deployment.
