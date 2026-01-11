# GitHub Actions Setup Guide

This guide explains how to set up automated documentation audits using GitHub Actions.

## Overview

The automated documentation audit runs:
- **Monthly** (scheduled on the 1st)
- **On PR** (when documentation files are modified)
- **Manually** (via workflow dispatch)

It performs the same comprehensive audit as the `/audit` command but automatically in CI/CD.

## Quick Setup

### 1. Enable the Workflow

The workflow is provided as a template file to prevent it from running in the bootstrap repo. To enable it:

```bash
mv .github/workflows/documentation-audit.yml.template .github/workflows/documentation-audit.yml
```

### 2. Add Anthropic API Key to GitHub Secrets

1. Get your Anthropic API key from https://console.anthropic.com/
2. Go to your repository on GitHub
3. Navigate to **Settings** → **Secrets and variables** → **Actions**
4. Click **New repository secret**
5. Name: `ANTHROPIC_API_KEY`
6. Value: Your API key
7. Click **Add secret**

### 3. GitHub Action Files

The template includes these files:

```
.github/
├── workflows/
│   └── documentation-audit.yml.template  # Rename to .yml to enable
├── scripts/
│   └── audit-docs.py                     # Audit script
└── audit-config.yml                      # Configuration
```

### 3. Customize Configuration (Optional)

Edit `.github/audit-config.yml` to adjust:
- Which files to audit
- Audit thresholds
- CI/CD behavior
- Notifications

### 4. Test the Workflow

#### Manual Test
1. Go to **Actions** tab in GitHub
2. Select **Documentation Audit** workflow
3. Click **Run workflow**
4. Select branch and run

#### Automatic Test
Create a PR that modifies any `.claude/` file and the audit will run automatically.

## How It Works

### Workflow Triggers

```yaml
on:
  # Monthly on the 1st at 9 AM UTC
  schedule:
    - cron: '0 9 1 * *'
  
  # Manual trigger
  workflow_dispatch:
  
  # PRs modifying documentation
  pull_request:
    paths:
      - '.claude/**'
      - 'CLAUDE.md'
```

### Workflow Steps

1. **Checkout** repository
2. **Install** Python dependencies
3. **Run audit** using Claude API
4. **Upload** audit report as artifact
5. **Check** for critical issues
6. **Create issue** if critical issues found
7. **Comment on PR** with results (if PR)
8. **Commit report** to repo (if scheduled)

### What Gets Audited

The script audits all documentation in:
- `CLAUDE.md`
- `.claude/architecture.md`
- `.claude/modules/*.md`
- `.claude/workflows/*.md`
- `.claude/conventions/*.md`

Configurable in `.github/audit-config.yml`

## Outputs

### Audit Report

Saved to `.claude/audit-reports/latest-audit.md`

Contains:
- Executive summary
- Issues by priority
- Specific findings
- Coverage analysis
- Recommendations
- CI/CD status

### Workflow Artifacts

Download full report from:
1. **Actions** tab
2. Select workflow run
3. Download **audit-report-XXX** artifact

### GitHub Issue (Critical Findings)

Automatically created when critical issues are found:
- Summary of critical issues
- Link to full report
- Action items
- Labels: `documentation`, `critical`, `automated-audit`

### PR Comment (Documentation PRs)

Comments on PRs with:
- Audit summary
- Critical/high priority alerts
- Link to full report
- Status emoji (🚨/⚠️/✅)

## Configuration Options

### Basic Configuration

Edit `.github/audit-config.yml`:

```yaml
# Claude model
model: claude-sonnet-4-20250514

# Files to audit
documentation_paths:
  - CLAUDE.md
  - .claude/
  - docs/  # Add your paths

# Thresholds
thresholds:
  max_file_size: 600
  min_coverage: 80
```

### CI/CD Behavior

```yaml
ci_behavior:
  # Create issue on critical findings
  create_issue_on_critical: true
  
  # Comment on PRs
  comment_on_pr: true
  
  # Fail build on issues
  fail_on_critical: false
  fail_on_high_priority: false
```

### Notifications (Optional)

Add Slack/Discord/Email notifications:

```yaml
notifications:
  slack_webhook: ${{ secrets.SLACK_WEBHOOK }}
  email:
    - team@example.com
```

## Advanced Usage

### Custom Audit Instructions

Add project-specific guidance:

```yaml
custom_instructions: |
  Our project uses:
  - API endpoints documented in openapi.yml
  - Architecture in Mermaid diagrams
  - Module structure follows DDD patterns
  
  Focus on:
  - API documentation accuracy
  - Architecture diagram currency
  - Module boundary documentation
```

### Exclude Patterns

Skip certain files:

```yaml
exclude_patterns:
  - "**/archive/**"
  - "**/*-draft.md"
  - "**/examples/**"
```

### Schedule Customization

Change when audits run:

```yaml
on:
  schedule:
    # Weekly on Mondays
    - cron: '0 9 * * 1'
    
    # Bi-weekly
    - cron: '0 9 1,15 * *'
```

### Multiple Workflows

Create different workflows for different purposes:

**Quick check on every PR:**
```yaml
# .github/workflows/docs-quick-check.yml
on:
  pull_request:
# Run fast checks only
```

**Comprehensive monthly audit:**
```yaml
# .github/workflows/docs-full-audit.yml
on:
  schedule:
    - cron: '0 9 1 * *'
# Run all checks
```

## Troubleshooting

### Audit Fails with API Error

**Problem**: `ANTHROPIC_API_KEY not set` or API errors

**Solution**:
1. Check secret is named exactly `ANTHROPIC_API_KEY`
2. Verify API key is valid
3. Check API quota/limits

### No Audit Report Generated

**Problem**: Workflow runs but no report

**Solution**:
1. Check workflow logs for errors
2. Verify documentation files exist
3. Check file paths in config

### Critical Issues Not Creating Issue

**Problem**: Critical issues found but no GitHub issue

**Solution**:
1. Check workflow permissions:
   ```yaml
   permissions:
     contents: write
     issues: write
   ```
2. Verify `create_issue_on_critical: true` in config

### Reports Not Committing

**Problem**: Scheduled audits don't commit reports

**Solution**:
1. Check `commit_reports: true` in config
2. Verify workflow has write permissions
3. Check git configuration in workflow

## Cost Estimation

### API Usage

Each audit uses approximately:
- **Input tokens**: 10,000 - 50,000 (depending on docs size)
- **Output tokens**: 5,000 - 10,000

### Monthly Cost

For typical project:
- **Monthly scheduled run**: 1 audit
- **PR audits**: ~4-8 per month
- **Total audits**: ~5-9 per month

At current API pricing (~$3 per 1M input tokens):
- Cost per audit: $0.15 - $0.30
- Monthly cost: ~$1-3

### Optimization

Reduce costs by:
- Limiting PR audits to documentation-heavy PRs
- Running comprehensive audits less frequently
- Using smaller model for quick checks
- Caching audit results

## Integration with Other Tools

### Slack Notifications

```yaml
- name: Notify Slack
  if: steps.check_critical.outputs.critical_count > 0
  uses: slackapi/slack-github-action@v1
  with:
    payload: |
      {
        "text": "Documentation audit found critical issues!"
      }
  env:
    SLACK_WEBHOOK_URL: ${{ secrets.SLACK_WEBHOOK }}
```

### Discord Notifications

```yaml
- name: Notify Discord
  uses: sarisia/actions-status-discord@v1
  with:
    webhook: ${{ secrets.DISCORD_WEBHOOK }}
    title: "Documentation Audit"
    description: "Critical issues found"
```

### Email Notifications

```yaml
- name: Send Email
  uses: dawidd6/action-send-mail@v3
  with:
    server_address: smtp.gmail.com
    server_port: 465
    username: ${{ secrets.EMAIL_USERNAME }}
    password: ${{ secrets.EMAIL_PASSWORD }}
    subject: Documentation Audit Alert
    to: team@example.com
    from: GitHub Actions
    body: file://.claude/audit-reports/latest-audit.md
```

## Best Practices

### Scheduled Runs

✅ **Do**:
- Run comprehensive audits monthly
- Use consistent schedule (e.g., 1st of month)
- Commit reports to track trends
- Review reports during planning

❌ **Don't**:
- Run too frequently (wastes API calls)
- Ignore scheduled audit results
- Skip reviewing trends

### PR Checks

✅ **Do**:
- Run on documentation PRs
- Comment with results
- Make results visible to reviewers
- Use as quality gate

❌ **Don't**:
- Block all PRs on minor issues
- Run on every PR (costly)
- Ignore PR comments

### Issue Management

✅ **Do**:
- Auto-create issues for critical findings
- Use labels for organization
- Assign to documentation owner
- Track resolution

❌ **Don't**:
- Create duplicate issues
- Ignore automated issues
- Leave issues unassigned

## Examples

### Example Workflow Run

```
🚀 Starting Documentation Audit
============================================================
📋 Collecting documentation files...
✓ Found 10 documentation files
📊 Total documentation: 4,750 lines

🤖 Running Claude audit...
✓ Audit completed successfully
📄 Report saved to: .claude/audit-reports/latest-audit.md

============================================================
📊 AUDIT COMPLETE
============================================================
⚠️  Status: WARNING - High priority issues found

📄 Full report: .claude/audit-reports/latest-audit.md
```

### Example PR Comment

```markdown
⚠️ **Documentation Audit Results**

Overall Health: Good
Critical Issues: 0
High Priority Issues: 2

### ⚠️ High Priority Issues

Consider addressing high-priority issues identified in the audit.

<details>
<summary>View Audit Summary</summary>

- Missing module documentation for notification-service
- Duplicate content in payments.md and billing.md

Download the full audit report from the workflow artifacts 
for detailed findings and recommendations.

</details>
```

### Example Issue

```markdown
# 🚨 Documentation Audit - 2024-01-11 - Critical Issues Found

An automated documentation audit has identified critical issues 
that need immediate attention.

## Executive Summary

Overall Health: Needs Attention
Critical Issues: 1
High Priority Issues: 3

## Critical Issues

### 1. Outdated Code Reference
- Location: .claude/modules/auth.md:45
- Impact: Developers following guide will encounter errors
- Recommendation: Update SessionManager reference to AuthService

## Full Report

Download from workflow artifacts.

## Next Steps

1. Review critical issues above
2. Download full report
3. Fix critical issues immediately
4. Schedule time for high-priority fixes

---
*Automated issue from Documentation Audit workflow*
```

## Support

### Documentation
- Main guide: This file
- Workflow: `.github/workflows/documentation-audit.yml`
- Script: `.github/scripts/audit-docs.py`
- Config: `.github/audit-config.yml`

### Getting Help
- Check workflow logs in Actions tab
- Review audit reports
- Test locally: `python .github/scripts/audit-docs.py`
- Check GitHub Actions documentation

## Next Steps

1. ✅ Add `ANTHROPIC_API_KEY` to GitHub secrets
2. ✅ Review `.github/audit-config.yml`
3. ✅ Test with manual workflow run
4. ✅ Customize for your needs
5. ✅ Set up notifications (optional)
6. ✅ Document for your team

---

**You're all set!** Automated documentation audits will now help keep your docs healthy and current. 🎉
