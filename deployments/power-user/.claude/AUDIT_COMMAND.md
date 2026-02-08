# `/audit` Command - Quick Reference

## What It Does

The `/audit` command triggers a comprehensive review of all `.claude/` documentation to:
- Identify outdated information
- Find duplicate content
- Detect missing documentation
- Check file sizes
- Validate links and references
- Generate actionable recommendations

## When to Use

### Regular Schedule
- **Monthly**: Quick health check
- **Quarterly**: Full comprehensive audit

### Triggered Events
- After major refactoring
- After tech stack changes
- When onboarding reveals gaps
- When documentation feels stale
- After removing/deprecating features

## How to Use

Simply type:
```
/audit
```

Claude will:
1. Read all documentation files
2. Analyze for issues
3. Create detailed report in `.claude/audit-reports/YYYY-MM-DD-audit.md`
4. Present findings with priorities
5. Offer to fix certain issues

## What Gets Audited

- ✅ CLAUDE.md (main configuration)
- ✅ architecture.md
- ✅ All module guides
- ✅ All workflow documents
- ✅ All convention guides

## Issue Priorities

### Critical (Fix Immediately)
- Incorrect information that could cause bugs
- Security-sensitive outdated guidance
- Broken critical workflows

### High Priority (Fix This Week)
- Significantly outdated information
- Missing core module documentation
- Broken internal references

### Medium Priority (Fix This Month)
- Minor outdated references
- Duplicate content
- Files exceeding size limits

### Low Priority (Fix When Convenient)
- Formatting inconsistencies
- Minor improvements

## Example Session

```
User: /audit

Claude: Starting documentation audit...

Reading files:
✓ CLAUDE.md (264 lines)
✓ architecture.md (312 lines)
✓ 3 module guides
✓ 3 workflows
✓ 3 conventions

Analyzing...

FINDINGS:

Critical (1):
- auth.md references removed SessionManager class
  → Update to new AuthService pattern

High Priority (2):
- Missing notification-service.md module doc
  → Create from template
- Duplicate content in payments.md and billing.md
  → Consolidate into payments.md

Medium Priority (3):
- Redis references should be Valkey
- Old Stripe API version in examples
- code-style.md is 612 lines (recommended: <500)

Report saved to: .claude/audit-reports/2024-01-11-audit.md

Should I:
1. Fix SessionManager reference
2. Create notification-service.md template
3. Consolidate payment docs
```

## What the Report Includes

### Executive Summary
- Overall documentation health
- Key issues count
- Coverage percentage

### Findings by Priority
- Critical issues
- High priority issues
- Medium priority issues
- Low priority issues

### Detailed Analysis
- File-by-file review
- Coverage gaps
- Outdated references
- Duplicate content
- Structural issues

### Action Plan
- Immediate actions
- Short-term improvements
- Long-term enhancements

### Statistics
- File counts
- Size analysis
- Issue distribution
- Health metrics

## Auto-Fix Capabilities

Claude can automatically fix:
- ✅ Broken internal links
- ✅ Formatting inconsistencies
- ✅ Markdown syntax errors
- ✅ Date updates in examples

Requires approval for:
- ⚠️ Content consolidation
- ⚠️ Structural changes
- ⚠️ File splits/merges
- ⚠️ Removing sections

## Best Practices

### Before Running Audit
- Commit any pending changes
- Note recent major code changes
- Identify known issues

### After Audit
- Review the report
- Prioritize fixes
- Fix critical issues immediately
- Schedule other fixes
- Update team on findings

### Regular Maintenance
- Run monthly quick checks
- Full audit quarterly
- Update docs when code changes
- Review during code reviews

## Tips for Success

### Make It Part of Workflow
- Add to quarterly planning
- Include in sprint reviews
- Track as tech debt items
- Celebrate improvements

### Keep Reports
- Store all audit reports
- Track trends over time
- Review improvements
- Learn from patterns

### Act on Findings
- Don't just generate reports
- Fix critical issues quickly
- Schedule other work
- Monitor metrics

## Common Questions

**Q: How long does it take?**
A: 2-5 minutes for Claude to read and analyze, depending on doc size

**Q: Will it modify files automatically?**
A: Only with your approval, and only safe changes

**Q: What if I disagree with a finding?**
A: The report is advisory - you choose what to act on

**Q: How often should I run it?**
A: Monthly quick checks, quarterly full audits

**Q: Can I customize what gets checked?**
A: Yes - see `.claude/workflows/documentation-audit.md` for details

## Related Commands

- `/verify-context` - See what's currently loaded
- `/load-module <n>` - Load specific module for detailed review
- `/read-all-context` - Load everything (for manual review)

## See Also

- `.claude/workflows/documentation-audit.md` - Full audit workflow
- `.claude/audit-reports/TEMPLATE.md` - Report template
- Previous audit reports in `.claude/audit-reports/`

---

**Pro Tip**: Run `/audit` at the start of each quarter to keep documentation healthy and current!
