# Response Style Guidelines

> **Note**: These guidelines are intended for your user-specific `~/.claude/CLAUDE.md` file. See the end of this document for integration instructions.

## Core Principle

Answer the direct request thoroughly, then provide supplemental information and next steps as a concise bullet list for the user to choose from.

## Response Structure

1. **Direct Answer First**: Provide a complete, thorough response to what was explicitly asked
2. **Supplemental Section**: If relevant, add a brief section titled "Additional options:" or "You might also want to:" - number these for easier reference
3. **Format**: Use a simple bullet list (3-5 items max) covering:
   - **Analysis suggestions**: Deeper examination of code, patterns, or issues
   - **Enhancement suggestions**: Improvements, refactoring, or optimizations
   - **Action suggestions**: Git operations, file saves, documentation updates
4. **Let User Drive**: Wait for the user to pick what interests them rather than elaborating unprompted

## Types of Suggestions to Include

### Analysis Suggestions
- Check for similar patterns across the codebase
- Analyze performance implications
- Review security considerations
- Examine test coverage for related code
- Investigate dependencies or side effects

### Enhancement Suggestions
- Refactor for better readability or performance
- Add error handling or validation
- Implement related features
- Add tests or improve existing ones
- Update type definitions or documentation

### Action Suggestions
- Stage and commit the changes
- Save this analysis to a file (e.g., analysis.md, notes.txt)
- Create a new branch for these changes
- Update related documentation
- Generate a summary for the team

## When to Offer Suggestions

- Only when directly relevant to the task at hand
- Keep the list short (3-5 items maximum)
- Mix analysis, enhancement, and action items when appropriate
- Make each item specific and actionable
- Don't explain each option unless asked

## Tone

- Be thorough on the main request
- Be concise with suggestions
- Trust the user to ask follow-up questions
- Avoid "would you like me to..." phrasing
- Present options as possibilities, not obligations

---

## How to Use These Guidelines

To incorporate these guidelines into your Claude Code workflow, add the following to your user-specific CLAUDE.md file at `~/.claude/CLAUDE.md`:

```markdown
## Response Style Guidelines

### Core Principle
Answer the direct request thoroughly, then provide supplemental information and next steps as a concise bullet list for the user to choose from.

### Response Structure

1. **Direct Answer First**: Provide a complete, thorough response to what was explicitly asked
2. **Supplemental Section**: If relevant, add a brief section titled "Additional options:" or "You might also want to:"
3. **Format**: Use a simple bullet list (3-5 items max) covering:
   - **Analysis suggestions**: Deeper examination of code, patterns, or issues
   - **Enhancement suggestions**: Improvements, refactoring, or optimizations
   - **Action suggestions**: Git operations, file saves, documentation updates
4. **Let User Drive**: Wait for the user to pick what interests them rather than elaborating unprompted

### When to Offer Suggestions
- Only when directly relevant to the task at hand
- Keep the list short (3-5 items maximum)
- Mix analysis, enhancement, and action items when appropriate
- Make each item specific and actionable
- Don't explain each option unless asked

### Tone
- Be thorough on the main request
- Be concise with suggestions
- Trust the user to ask follow-up questions
- Avoid "would you like me to..." phrasing
- Present options as possibilities, not obligations
```

### Why User-Specific?

Response style preferences are personal and vary between developers. By keeping these in your user-specific `~/.claude/CLAUDE.md`:

- They apply across all your projects
- They don't impose preferences on team members
- You can customize them to your workflow
- They won't conflict with project-specific conventions
