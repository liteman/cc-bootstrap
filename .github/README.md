# GitHub Actions - Documentation Audit

Automated documentation audits using Claude API in CI/CD.

## 📁 Files

- **workflows/documentation-audit.yml** - Main GitHub Action workflow
- **scripts/audit-docs.py** - Python script that runs the audit
- **audit-config.yml** - Configuration file
- **SETUP.md** - Complete setup and usage guide

## 🚀 Quick Start

1. **Enable the Workflow**
   ```bash
   mv .github/workflows/documentation-audit.yml.template .github/workflows/documentation-audit.yml
   ```

2. **Add API Key to GitHub Secrets**
   - Go to Settings → Secrets → Actions
   - Add `ANTHROPIC_API_KEY` with your key

3. **Test the Workflow**
   - Go to Actions tab
   - Run "Documentation Audit" manually

4. **Customize** (optional)
   - Edit `audit-config.yml`
   - See SETUP.md for details

## 📖 Documentation

See [SETUP.md](./SETUP.md) for:
- Detailed setup instructions
- Configuration options
- Troubleshooting
- Best practices
- Examples

## 🔄 When It Runs

- **Monthly**: 1st of month at 9 AM UTC
- **On PRs**: When `.claude/` files are modified
- **Manual**: Via Actions tab

## 📊 What It Does

1. Collects all documentation files
2. Runs Claude API audit
3. Generates detailed report
4. Creates issue if critical problems found
5. Comments on PRs with results

## 🎯 Use Cases

### For Teams
- **Quality gate** for documentation PRs
- **Monthly health checks** automated
- **Track trends** with historical reports
- **Alert on critical issues** automatically

### For Projects
- **Maintain docs** with minimal effort
- **Catch issues early** before they spread
- **Standardize quality** across team
- **Document improvements** over time

## 💡 Pro Tips

- Run comprehensive audits monthly
- Use PR checks for doc-heavy changes
- Review trends in audit reports
- Customize config for your needs
- Set up Slack/Discord notifications

## 🔧 Local Testing

Test the audit script locally:

```bash
# Set API key
export ANTHROPIC_API_KEY='your-key-here'

# Run audit
python .github/scripts/audit-docs.py

# Check output
cat .claude/audit-reports/latest-audit.md
```

## 📈 Cost

Typical monthly cost: **$1-3**
- ~5-9 audits per month
- ~$0.15-0.30 per audit
- Based on current Claude API pricing

## 🆘 Support

- **Setup help**: See SETUP.md
- **Configuration**: See audit-config.yml
- **Troubleshooting**: Check workflow logs
- **Local testing**: Run script directly

## 🎉 Benefits

- ✅ Automated quality checks
- ✅ Early issue detection
- ✅ Consistent standards
- ✅ Trend tracking
- ✅ Team accountability
- ✅ Minimal manual effort

---

**Ready to get started?** See [SETUP.md](./SETUP.md) for detailed instructions!
