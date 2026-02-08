# Documentation Audit Report Template

> This is a template for audit reports. When running `/audit`, Claude will create a new report in this directory named `YYYY-MM-DD-audit.md`

## Report Structure

```markdown
# Documentation Audit Report
Date: [YYYY-MM-DD]
Auditor: Claude
Files Reviewed: [count]
Total Lines: [count]

## Executive Summary

[2-3 sentence overview of documentation health]

Overall Health: [Excellent / Good / Fair / Needs Attention]
Key Issues: [count critical], [count high priority]
Documentation Coverage: [percentage]%

---

## Findings by Priority

### Critical Issues (Fix Immediately)

#### 1. [Issue Title]
- **Location**: `[file]:[section]` or line [number]
- **Impact**: [What could go wrong if not fixed]
- **Details**: [Specific description of the issue]
- **Recommendation**: [Specific action to take]
- **Effort**: [Low/Medium/High]

### High Priority Issues (Fix This Week)

#### 1. [Issue Title]
- **Location**: `[file]:[section]`
- **Impact**: [Impact description]
- **Details**: [Issue description]
- **Recommendation**: [Action to take]
- **Effort**: [Low/Medium/High]

### Medium Priority Issues (Fix This Month)

#### 1. [Issue Title]
- **Location**: `[file]:[section]`
- **Details**: [Issue description]
- **Recommendation**: [Action to take]
- **Effort**: [Low/Medium/High]

### Low Priority Issues (Fix When Convenient)

#### 1. [Issue Title]
- **Location**: `[file]:[section]`
- **Details**: [Issue description]
- **Recommendation**: [Action to take]

---

## Detailed Analysis by File

### CLAUDE.md
- **Size**: [lines]
- **Last Updated**: [date if available]
- **Status**: [Good/Needs Update/Problematic]
- **Issues Found**: [count]
- **Notes**:
  - [Specific observation]
  - [Specific observation]

### .claude/architecture.md
- **Size**: [lines]
- **Status**: [status]
- **Issues Found**: [count]
- **Coverage**: [What's documented vs missing]
- **Notes**:
  - [Observation]

### Module Documentation

#### .claude/modules/[module-name].md
- **Size**: [lines]
- **Status**: [status]
- **Issues Found**: [count]
- **Notes**:
  - [Observation]

[Repeat for each module]

### Workflow Documentation

#### .claude/workflows/[workflow-name].md
- **Size**: [lines]
- **Status**: [status]
- **Issues Found**: [count]
- **Notes**:
  - [Observation]

[Repeat for each workflow]

### Convention Documentation

#### .claude/conventions/[convention-name].md
- **Size**: [lines]
- **Status**: [status]
- **Issues Found**: [count]
- **Notes**:
  - [Observation]

[Repeat for each convention]

---

## Coverage Analysis

### Module Coverage
- **Modules in Codebase**: [count]
- **Modules Documented**: [count]
- **Coverage**: [percentage]%

**Missing Module Documentation**:
- [ ] `[module-name]` - [reason it's needed]
- [ ] `[module-name]` - [reason it's needed]

**Documented but Removed**:
- [ ] `[module-name]` - [should be archived or removed]

### Workflow Coverage
- **Common Workflows**: [list expected workflows]
- **Documented Workflows**: [list actual workflows]
- **Coverage**: [Good/Partial/Incomplete]

**Missing Workflows**:
- [ ] `[workflow-name]` - [description]

### Convention Coverage
- **Expected Conventions**: [list]
- **Documented Conventions**: [list]
- **Coverage**: [Good/Partial/Incomplete]

**Missing Conventions**:
- [ ] `[convention-name]` - [description]

---

## Content Quality Issues

### Outdated References

1. **[File:Section]**: References `[old-thing]`
   - Should reference: `[new-thing]`
   - Last updated: [date or "unknown"]
   - Action: Update to current pattern

[List all outdated references]

### Broken Links

1. **[File]**: Link to `[target]` is broken
   - Line: [number]
   - Issue: [file doesn't exist / section removed / path wrong]
   - Action: [Fix path / Remove link / Update reference]

### Inconsistencies

1. **[Topic]**: Conflicting information
   - **[File 1]** says: [statement]
   - **[File 2]** says: [different statement]
   - **Correct approach**: [which is right]
   - **Action**: Update [file(s)] to align

### Duplicate Content

1. **[Topic]**: Duplicated across files
   - **[File 1]**: [section] ([lines])
   - **[File 2]**: [section] ([lines])
   - **Similarity**: [High/Medium/Low]
   - **Recommendation**: [Keep in File 1, reference from File 2]

---

## Structure & Organization Issues

### Oversized Files

1. **[filename]**: [actual size] lines (recommended: [recommended size])
   - **Sections that could be extracted**:
     - [Section name] → New file: `[suggested-filename]`
     - [Section name] → New file: `[suggested-filename]`
   - **Effort**: [Low/Medium/High]

### Missing Sections

1. **[filename]**: Missing expected section
   - **Missing**: [section name]
   - **Recommendation**: Add section covering [topic]
   - **Template available**: [Yes/No]

### Organization Suggestions

1. **[Area]**: Could be better organized
   - **Current state**: [description]
   - **Suggestion**: [improvement]
   - **Benefit**: [why it would help]

---

## Positive Findings

### Well-Maintained Areas
- ✅ [File/section] is comprehensive and current
- ✅ [File/section] has excellent examples
- ✅ [File/section] recently updated

### Best Practices Observed
- ✅ [Specific good practice]
- ✅ [Specific good practice]

### Recent Improvements
- ✅ [What was improved and when]

---

## Statistics

### File Count
- Total documentation files: [count]
- Module guides: [count]
- Workflows: [count]
- Conventions: [count]
- Other: [count]

### Size Analysis
- Total lines of documentation: [count]
- Average file size: [lines]
- Largest file: `[filename]` ([lines])
- Smallest file: `[filename]` ([lines]
- Files exceeding size guidelines: [count]

### Issue Distribution
- **Critical**: [count]
- **High Priority**: [count]
- **Medium Priority**: [count]
- **Low Priority**: [count]
- **Total**: [count]

### Health Metrics
- Documentation coverage: [percentage]%
- Files needing attention: [count]/[total] ([percentage]%)
- Average issues per file: [number]
- Files with zero issues: [count]

---

## Action Plan

### Immediate Actions (This Week)

Priority 1: Fix Critical Issues
- [ ] [Specific action] - [File] - Effort: [Low/Med/High] - Owner: [if applicable]
- [ ] [Specific action] - [File] - Effort: [Low/Med/High]

Priority 2: High Priority Issues
- [ ] [Specific action] - [File] - Effort: [Low/Med/High]
- [ ] [Specific action] - [File] - Effort: [Low/Med/High]

**Estimated Total Effort**: [hours/days]

### Short Term Actions (This Month)

- [ ] [Action item] - [File(s)] - Effort: [estimate]
- [ ] [Action item] - [File(s)] - Effort: [estimate]
- [ ] [Action item] - [File(s)] - Effort: [estimate]

**Estimated Total Effort**: [hours/days]

### Long Term Improvements (This Quarter)

- [ ] [Improvement] - Benefit: [description]
- [ ] [Improvement] - Benefit: [description]
- [ ] [Improvement] - Benefit: [description]

### Ongoing Maintenance

- [ ] Set up monthly quick audits
- [ ] Add documentation review to PR process
- [ ] Update docs when code changes
- [ ] Monitor file sizes
- [ ] Track documentation coverage

---

## Recommendations

### Process Improvements

1. **[Recommendation]**
   - Current state: [description]
   - Proposed: [improvement]
   - Benefit: [why it helps]
   - Effort: [estimate]

### Tool Additions

1. **[Tool/Automation]**
   - Purpose: [what it would do]
   - Benefit: [how it helps]
   - Examples: [similar tools]

### Documentation Standards

1. **[Standard to add/update]**
   - Rationale: [why needed]
   - Implementation: [how to add]
   - Impact: [who it affects]

---

## Next Audit

**Recommended Date**: [date based on findings]

**Reason**: [Why this timing - based on issue count, upcoming changes, etc.]

**Focus Areas for Next Audit**:
- [Specific area to watch]
- [Specific area to watch]

**Success Criteria**:
- All critical issues resolved
- <5 high priority issues
- Documentation coverage >85%
- All modules documented

---

## Appendix

### Audit Methodology

This audit was conducted using:
- Manual review of all documentation files
- Cross-reference with actual codebase
- Comparison against templates and best practices
- Analysis of file structure and organization
- Validation of links and references

### Files Reviewed

Complete list of files reviewed:
1. `CLAUDE.md`
2. `.claude/architecture.md`
3. `.claude/modules/[module].md`
... [complete list]

### Review Checklist

For each file, verified:
- [ ] Content is accurate and current
- [ ] Examples work as written
- [ ] References to code match reality
- [ ] Links are not broken
- [ ] Formatting is consistent
- [ ] Size is within guidelines
- [ ] No placeholder text remains
- [ ] Cross-references are accurate

---

## Sign-off

**Audit Completed**: [Date and Time]
**Next Steps**: [Brief summary of immediate actions]
**Questions**: [Any questions for the team]

---

*This audit report was generated by the `/audit` command. For questions about specific findings, refer to `.claude/workflows/documentation-audit.md` for the audit methodology.*
```

## Usage Instructions

When Claude runs `/audit`, it should:

1. Create a new file: `.claude/audit-reports/[YYYY-MM-DD]-audit.md`
2. Follow this template structure
3. Fill in all sections with actual findings
4. Be specific about locations and recommendations
5. Prioritize issues appropriately
6. Provide actionable next steps

## Report Naming Convention

- Format: `YYYY-MM-DD-audit.md`
- Example: `2024-01-11-audit.md`
- Include type suffix if needed: `2024-01-11-quick-audit.md`

## Retention Policy

Keep audit reports to track documentation health over time:
- Store all reports for historical reference
- Review trends quarterly
- Archive reports older than 1 year (optional)
