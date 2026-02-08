---
name: audit
description: Perform a comprehensive review of .claude/ documentation to identify outdated information, duplicates, missing docs, and generate actionable recommendations.
argument-hint: [quick|full]
model: haiku
allowed-tools: Read, Glob, Grep, Write, Edit, Bash, AskUserQuestion
---

# Documentation Audit Skill

Perform a documentation audit based on the mode specified in `$ARGUMENTS`:
- **empty or `full`**: Complete 5-phase audit with remediation
- **`quick`**: Fast scan focusing on critical/high issues only

## Phase 1: Discovery

1. Use Glob to find all markdown files:
   ```
   Glob: .claude/**/*.md
   Glob: CLAUDE.md
   Glob: docs/design/**/*.md
   Glob: docs/adr/**/*.md
   ```

2. Read files in this order, tracking line counts:
   - `CLAUDE.md` (root)
   - `.claude/architecture.md`
   - `.claude/modules/*.md`
   - `.claude/workflows/*.md`
   - `.claude/conventions/*.md`
   - `.claude/design/**/*.md` (if exists)
   - `docs/design/**/*.md` (if exists)
   - `docs/adr/**/*.md` (if exists)

3. Report progress:
   ```
   Reading files:
   ✓ CLAUDE.md (X lines)
   ✓ architecture.md (X lines)
   ✓ X module guides
   ✓ X workflows
   ✓ X conventions
   ✓ X design workflows (if present)
   ✓ X ADRs (if present)

   Total: X files, X lines
   ```

## Phase 2: Analysis

For each file, check these categories:

### Content Quality
- Information is current and accurate
- References to code match actual codebase
- Examples are relevant and work
- No placeholder text like [BRACKETS] remains
- Technical details are up to date

### Structure Quality
- Follows expected template structure
- Sections in logical order
- File size within guidelines (<500 lines recommended)
- Consistent formatting

### Cross-File Quality (skip in quick mode)
- No conflicting information between files
- No significant duplication
- Internal links work correctly (check file paths exist)
- References between files are accurate

### Completeness
- All major modules have documentation
- All workflows documented
- All conventions documented
- No obvious missing sections

### Design Documentation Quality (if `.claude/design/` exists)
- All 6 design phase workflows present (exploration, requirements, options, decision, detail, validation)
- Design templates exist (DESIGN_DOCUMENT.md, ADR_TEMPLATE.md, SESSION_NOTES.md)
- Design thinking conventions documented
- ADR index in architecture.md is up-to-date
- ADR files match index entries
- Stale design documents flagged (>30 days without updates)
- Design commands present in CLAUDE.md (/start-design-session, /load-design-phase, /finalize-design)

## Phase 3: Issue Identification

Categorize all findings:

### Critical (Fix Immediately)
- Incorrect information that could cause bugs
- Security-sensitive outdated guidance
- Broken critical workflows
- Missing documentation for core modules
- ADR index out of sync with actual ADR files (could lead to wrong decisions)

### High Priority (Fix Soon)
- Significantly outdated information
- Confusing or contradictory content
- Missing important module docs
- Broken internal references
- Missing design phase workflows (if design/ exists but incomplete)
- Stale design documents blocking implementation (>30 days old)

### Medium Priority (skip in quick mode)
- Minor outdated references
- Duplicate content needing consolidation
- Files exceeding 500 lines
- Formatting inconsistencies

### Low Priority (skip in quick mode)
- Minor formatting issues
- Optional enhancements
- Cosmetic improvements

## Phase 4: Reporting

1. Create the audit-reports directory if needed:
   ```bash
   mkdir -p .claude/audit-reports
   ```

2. Generate report at `.claude/audit-reports/YYYY-MM-DD-audit.md` using this structure:

```markdown
# Documentation Audit Report

**Date**: YYYY-MM-DD
**Mode**: [Quick|Full]
**Files Reviewed**: X
**Total Lines**: X

## Executive Summary

[Overall health: Excellent/Good/Fair/Needs Attention]
[1-2 sentence summary of key findings]

## Findings by Priority

### Critical Issues
1. **[Issue title]**
   - Location: `file.md:section`
   - Impact: [what could go wrong]
   - Recommendation: [how to fix]

### High Priority Issues
[Same format]

### Medium Priority Issues (full mode only)
[Same format]

### Low Priority Issues (full mode only)
[Same format]

## Coverage Analysis

| Category | Documented | Missing |
|----------|------------|---------|
| Modules | X | [list] |
| Workflows | X | [list] |
| Conventions | X | [list] |
| Design Phases (if applicable) | X/6 | [list] |
| ADRs (if applicable) | X | N/A |

## Duplicate Content (full mode only)
- [File 1] and [File 2]: [description]
  - Recommendation: [consolidation strategy]

## Oversized Files (full mode only)
- `filename.md`: X lines (recommended: <500)

## Positive Findings
- [What's working well]

## Statistics
- Files reviewed: X
- Issues found: X (Critical: X, High: X, Medium: X, Low: X)
- Documentation coverage: X%
- Average file size: X lines
- Largest file: `filename.md` (X lines)

## Recommended Actions
1. [Prioritized action items]
```

3. Present summary to user:
   ```
   AUDIT COMPLETE

   Critical: X | High: X | Medium: X | Low: X

   Report saved to: .claude/audit-reports/YYYY-MM-DD-audit.md
   ```

## Phase 5: Remediation (full mode only)

Ask user using AskUserQuestion:

"Would you like me to fix any issues?"

Options:
1. **Auto-fix safe issues** - Fix broken links, formatting, markdown syntax
2. **Show me what to fix manually** - List issues requiring human judgment
3. **Skip remediation** - Keep report only

### Auto-Fix Capabilities (safe)
- Fix broken internal links (update paths)
- Fix formatting inconsistencies
- Fix markdown syntax errors
- Update obvious date references

### Manual Fix Required (list only)
- Content consolidation
- Structural reorganization
- Splitting oversized files
- Removing/rewriting sections
- Adding missing documentation

After any fixes, report what was changed.

---

## Quick Mode Summary

When `$ARGUMENTS` = `quick`:
1. Discovery: Read all files (same)
2. Analysis: Skip cross-file checks
3. Issues: Report Critical + High only
4. Reporting: Abbreviated report
5. Remediation: Skip entirely

---

## Reference

For comprehensive audit details, see:
- `.claude/workflows/documentation-audit.md` - Full workflow documentation
- `.claude/AUDIT_COMMAND.md` - Quick reference guide
- `.claude/audit-reports/TEMPLATE.md` - Report template
