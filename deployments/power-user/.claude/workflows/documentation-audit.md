# Documentation Audit Workflow

> **When to read**: When running `/audit` command or performing manual documentation review

## Overview

The `/audit` command performs a comprehensive review of all `.claude/` documentation to ensure it remains current, accurate, and useful. This workflow documents the process Claude should follow when auditing documentation.

## When to Audit

### Regular Schedule
- **Monthly**: Quick scan for obvious issues
- **Quarterly**: Full comprehensive audit
- **After major changes**: Architecture updates, tech stack changes, team restructuring

### Triggered by Events
- After major refactoring
- When onboarding reveals gaps
- When documentation feels stale
- After removing/deprecating features
- When adding new major modules

## Audit Process

### Phase 1: Discovery

Read all documentation files in order:

```
1. CLAUDE.md (main configuration)
2. .claude/architecture.md
3. .claude/modules/*.md (all module guides)
4. .claude/workflows/*.md (all workflows)
5. .claude/conventions/*.md (all conventions)
```

### Phase 2: Analysis

For each file, check:

#### Content Quality
- [ ] Information is current and accurate
- [ ] References to code match actual codebase
- [ ] Examples work and are relevant
- [ ] No placeholder text remains
- [ ] Technical details are up to date

#### Structure Quality
- [ ] Follows template structure
- [ ] Sections are in logical order
- [ ] Headers are consistent
- [ ] File size is within guidelines
- [ ] Formatting is consistent

#### Cross-File Quality
- [ ] No conflicting information
- [ ] No significant duplication
- [ ] Internal links work correctly
- [ ] References between files are accurate
- [ ] Coverage gaps identified

#### Completeness
- [ ] All major modules documented
- [ ] All workflows documented
- [ ] All conventions documented
- [ ] No obvious missing sections

### Phase 3: Issue Identification

Categorize findings:

#### Critical Issues (Fix Immediately)
- Incorrect information that could cause bugs
- Security-sensitive outdated guidance
- Broken critical workflows
- Missing documentation for core modules

#### High Priority (Fix This Week)
- Significantly outdated information
- Confusing or contradictory content
- Missing important module docs
- Broken internal references

#### Medium Priority (Fix This Month)
- Minor outdated references
- Duplicate content that should be consolidated
- Files exceeding size guidelines
- Formatting inconsistencies

#### Low Priority (Fix When Convenient)
- Minor formatting issues
- Optional enhancements
- Nice-to-have additions
- Cosmetic improvements

### Phase 4: Reporting

Create audit report in `.claude/audit-reports/[YYYY-MM-DD]-audit.md`:

```markdown
# Documentation Audit Report
Date: [YYYY-MM-DD]
Auditor: Claude
Files Reviewed: [count]

## Executive Summary
[High-level overview of documentation health]

## Findings by Category

### Critical Issues
1. [Issue description]
   - Location: [file:line or section]
   - Impact: [what could go wrong]
   - Recommendation: [how to fix]

### High Priority Issues
[List with details]

### Medium Priority Issues
[List with details]

### Low Priority Issues
[List with details]

## Missing Documentation
- [ ] Module: [module-name] - [why it's needed]
- [ ] Workflow: [workflow-name] - [why it's needed]
- [ ] Convention: [convention-name] - [why it's needed]

## Duplicate Content
- [File 1] and [File 2]: [description of duplication]
  - Recommendation: [consolidation strategy]

## Oversized Files
- [filename]: [current size] lines (recommended: [recommended size])
  - Recommendation: [split strategy]

## Outdated References
- [File:section]: References [old-thing] which was replaced by [new-thing]
- [File:section]: Uses deprecated [pattern] 

## Inconsistencies
- [Issue description across files]

## Positive Findings
- [What's working well]
- [Recently updated sections]
- [Well-maintained areas]

## Action Plan

### Immediate Actions (This Week)
1. [Action item with priority]
2. [Action item with priority]

### Short Term Actions (This Month)
1. [Action item]
2. [Action item]

### Long Term Improvements
1. [Action item]
2. [Action item]

## Statistics
- Total files: [count]
- Files reviewed: [count]
- Issues found: [count]
- Critical: [count]
- High: [count]
- Medium: [count]
- Low: [count]
- Documentation coverage: [percentage]%
- Average file size: [lines]
- Largest file: [filename] ([size] lines)

## Next Audit
Recommended: [date based on findings]
```

### Phase 5: Remediation (Optional)

Based on user approval, perform fixes:

#### Auto-Fix Issues (Safe to do immediately)
- Fix broken internal links
- Update formatting consistency
- Remove trailing whitespace
- Fix markdown syntax errors
- Update dates in examples

#### Manual Fix Issues (Require review)
- Consolidate duplicate content
- Update outdated references
- Reorganize file structure
- Split oversized files
- Add missing sections

#### Create Missing Documentation
- Generate module templates
- Draft workflow skeletons
- Create convention outlines

## Specific Checks

### CLAUDE.md Checks
- [ ] All [PLACEHOLDERS] replaced
- [ ] Module list matches actual modules
- [ ] Workflow list matches actual workflows
- [ ] Convention list matches actual conventions
- [ ] Custom commands are documented
- [ ] File paths are correct

### architecture.md Checks
- [ ] Tech stack is current
- [ ] Architecture diagram matches reality
- [ ] Module list is complete
- [ ] Dependencies are current
- [ ] Infrastructure is accurate

### Module Documentation Checks
- [ ] Each major module has documentation
- [ ] No modules documented that no longer exist
- [ ] File paths in examples are correct
- [ ] API references match current code
- [ ] Examples work as written
- [ ] Dependencies are accurate

### Workflow Documentation Checks
- [ ] Workflows match actual team process
- [ ] Tools referenced are still used
- [ ] Steps are current
- [ ] Examples are relevant
- [ ] Checklists are complete

### Convention Documentation Checks
- [ ] Standards match current practice
- [ ] Tools are current versions
- [ ] Examples use current syntax
- [ ] No conflicting guidance
- [ ] Language-specific sections are accurate

## Common Issues & Solutions

### Issue: Outdated Code References
**Detection**: Code examples that don't compile or use deprecated APIs
**Solution**: Update examples to current codebase patterns
**Prevention**: Include code examples in CI/CD tests when possible

### Issue: Duplicate Content
**Detection**: Same information in multiple files
**Solution**: Consolidate in most appropriate location, add cross-references
**Prevention**: Use "See [file]" references instead of copying

### Issue: Missing Module Docs
**Detection**: Modules in codebase without corresponding .md file
**Solution**: Create module doc from template
**Prevention**: Add module doc creation to feature checklist

### Issue: Oversized Files
**Detection**: Files exceeding recommended line counts
**Solution**: Split into logical sub-files or extract to separate docs
**Prevention**: Monitor file growth, split proactively

### Issue: Broken Links
**Detection**: Internal references to non-existent files/sections
**Solution**: Fix paths or remove dead links
**Prevention**: Validate links when moving/renaming files

### Issue: Conflicting Information
**Detection**: Different files say different things
**Solution**: Determine correct approach, update all files
**Prevention**: Single source of truth for critical information

## Audit Checklist

### Pre-Audit
- [ ] Create audit-reports directory if it doesn't exist
- [ ] Note current date for report
- [ ] Identify any recent major changes to be aware of

### During Audit
- [ ] Read all documentation systematically
- [ ] Take notes on each file
- [ ] Categorize issues as found
- [ ] Note positive findings too
- [ ] Track statistics

### Post-Audit
- [ ] Generate comprehensive report
- [ ] Prioritize action items
- [ ] Get user approval for fixes
- [ ] Execute approved fixes
- [ ] Update files as needed
- [ ] Commit changes with "docs: audit and cleanup" message

## Best Practices

### Conducting Audits
- Be thorough but practical
- Focus on high-impact issues
- Note what's working well
- Provide specific recommendations
- Prioritize actionable items

### Writing Audit Reports
- Be specific about locations
- Explain impact of issues
- Provide clear recommendations
- Include examples where helpful
- Keep tone constructive

### Implementing Fixes
- Start with critical issues
- Test changes if applicable
- Update related files together
- Commit changes logically
- Document what was changed

### Preventing Issues
- Regular small audits better than rare large ones
- Update docs when code changes
- Review docs in code reviews
- Make it part of workflow
- Automate what you can

## Automation Opportunities

Consider automating:
- Link validation
- File size monitoring
- Placeholder detection
- Duplicate content detection
- Last-updated tracking
- Statistics gathering

## Success Metrics

A good audit:
- Identifies real issues
- Provides actionable recommendations
- Results in improvements
- Takes reasonable time
- Happens regularly

Documentation is healthy when:
- Coverage is >80% of modules
- No critical issues
- <5 high priority issues
- Files are reasonable size
- Content is current

## Example Audit Session

```
User: /audit

Claude: Starting documentation audit of .claude/ directory...

Reading files:
✓ CLAUDE.md (264 lines)
✓ architecture.md (312 lines)
✓ modules/auth.md (456 lines)
✓ modules/payments.md (523 lines)
✓ workflows/feature-development.md (589 lines)
✓ workflows/bug-fixes.md (498 lines)
✓ workflows/refactoring.md (467 lines)
✓ conventions/code-style.md (612 lines)
✓ conventions/testing.md (534 lines)
✓ conventions/git-workflow.md (445 lines)

Total: 10 files, 4,700 lines

Analyzing content...

FINDINGS:

Critical Issues (1):
- auth.md references SessionManager class that was removed in v2.0
  Impact: Developers following this guide will encounter errors
  Recommendation: Update to new AuthService pattern

High Priority (3):
- Duplicate content: payments.md and billing.md both explain payment flow
  Recommendation: Consolidate into payments.md, add reference from billing.md
- Missing module: notification-service has no documentation
  Recommendation: Create .claude/modules/notification-service.md
- code-style.md is 612 lines (recommended: <500)
  Recommendation: Split into code-style.md (general) and typescript-style.md (TS-specific)

Medium Priority (5):
- architecture.md references Redis but we now use Valkey
- payments.md example uses old Stripe API v2021-08-01
- Several files missing "Last Updated" dates
- Inconsistent code block formatting across files
- git-workflow.md doesn't mention our new trunk-based approach

Low Priority (2):
- Minor formatting inconsistencies
- Some examples could be more concise

POSITIVE FINDINGS:
- All major modules documented
- Workflows are comprehensive
- Recent updates to testing.md
- Good use of examples throughout

STATISTICS:
- Files reviewed: 10
- Issues found: 11 (1 critical, 3 high, 5 medium, 2 low)
- Documentation coverage: 90%
- Average file size: 470 lines

Detailed report saved to: .claude/audit-reports/2024-01-11-audit.md

RECOMMENDED ACTIONS:
1. Fix auth.md SessionManager reference (critical)
2. Consolidate payment documentation (high)
3. Create notification-service.md (high)
4. Split code-style.md (high)
5. Update Redis → Valkey references (medium)

Should I proceed with fixing issues 1-4? (I'll create the detailed report either way)
```

## Customization

Adjust this workflow for your needs:
- Add project-specific checks
- Modify issue categories
- Change audit frequency
- Add custom automation
- Include team-specific metrics

## Integration with Workflows

The audit process should integrate with:
- **Feature Development**: Check docs when adding modules
- **Bug Fixes**: Verify docs when fixing issues
- **Refactoring**: Update docs during refactors
- **Code Review**: Include doc review
- **Quarterly Planning**: Schedule audit reviews
