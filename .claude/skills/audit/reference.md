# Audit Skill Reference

This skill is a condensed, executable version of the full documentation audit workflow.

## Related Documentation

- **Full Workflow**: `.claude/workflows/documentation-audit.md`
  - Complete 443-line guide with all checks, examples, and best practices
  - Detailed issue categories and remediation strategies
  - Automation opportunities and success metrics

- **Quick Reference**: `.claude/AUDIT_COMMAND.md`
  - User-facing guide for the `/audit` command
  - FAQ and common questions

- **Report Template**: `.claude/audit-reports/TEMPLATE.md`
  - Detailed template for audit reports
  - All sections and formatting guidelines

## When to Read Full Workflow

Load the full workflow (`.claude/workflows/documentation-audit.md`) when:
- Customizing audit checks for a specific project
- Understanding the rationale behind specific checks
- Troubleshooting audit issues
- Training on audit best practices

## Audit Schedule Recommendations

| Type | Frequency | Mode |
|------|-----------|------|
| Health check | Monthly | `/audit quick` |
| Full audit | Quarterly | `/audit full` |
| After major changes | As needed | `/audit full` |
| CI/CD integration | On PR | See `.github/workflows/` |
