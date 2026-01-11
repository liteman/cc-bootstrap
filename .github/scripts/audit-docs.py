#!/usr/bin/env python3
"""
Automated Documentation Audit Script

This script uses Claude API to perform comprehensive documentation audits
that can be run in CI/CD pipelines (GitHub Actions).

Usage:
    python audit-docs.py [--output-file FILEPATH] [--config CONFIG_FILE]

Environment Variables:
    ANTHROPIC_API_KEY: Required. Your Anthropic API key.

Requirements:
    pip install anthropic python-dotenv pyyaml
"""

import os
import sys
import json
import yaml
from datetime import datetime
from pathlib import Path
from typing import Dict, List, Optional
import anthropic


class DocumentationAuditor:
    """Performs automated documentation audits using Claude API."""
    
    def __init__(self, api_key: str, config_path: Optional[str] = None):
        self.client = anthropic.Anthropic(api_key=api_key)
        self.config = self._load_config(config_path)
        self.model = self.config.get('model', 'claude-sonnet-4-20250514')
        self.max_tokens = self.config.get('max_tokens', 16000)
        
    def _load_config(self, config_path: Optional[str]) -> Dict:
        """Load configuration from YAML file or use defaults."""
        default_config = {
            'model': 'claude-sonnet-4-20250514',
            'max_tokens': 16000,
            'documentation_paths': [
                'CLAUDE.md',
                '.claude/architecture.md',
                '.claude/modules/',
                '.claude/workflows/',
                '.claude/conventions/'
            ],
            'output_path': '.claude/audit-reports/latest-audit.md',
            'checks': {
                'outdated_references': True,
                'duplicate_content': True,
                'missing_documentation': True,
                'file_sizes': True,
                'broken_links': True,
                'inconsistencies': True
            },
            'thresholds': {
                'max_file_size': 600,
                'min_coverage': 80,
                'max_duplicates': 5
            }
        }
        
        if config_path and os.path.exists(config_path):
            with open(config_path, 'r') as f:
                user_config = yaml.safe_load(f)
                default_config.update(user_config)
        
        return default_config
    
    def collect_documentation(self) -> Dict[str, str]:
        """Collect all documentation files."""
        docs = {}
        
        for path in self.config['documentation_paths']:
            if os.path.isfile(path):
                # Single file
                with open(path, 'r', encoding='utf-8') as f:
                    docs[path] = f.read()
            elif os.path.isdir(path):
                # Directory - collect all .md files
                for filepath in Path(path).rglob('*.md'):
                    # Skip template and audit reports
                    if 'template' in filepath.name.lower() or 'audit-report' in str(filepath):
                        continue
                    with open(filepath, 'r', encoding='utf-8') as f:
                        docs[str(filepath)] = f.read()
        
        return docs
    
    def build_audit_prompt(self, docs: Dict[str, str]) -> str:
        """Build the prompt for Claude to audit documentation."""
        
        # Build file list with sizes
        file_list = "\n".join([
            f"- {path} ({len(content.splitlines())} lines)"
            for path, content in docs.items()
        ])
        
        # Build documentation content
        doc_content = "\n\n---\n\n".join([
            f"FILE: {path}\n\n{content}"
            for path, content in docs.items()
        ])
        
        prompt = f"""I need you to perform a comprehensive audit of our project documentation. This is for an automated CI/CD check.

PROJECT DOCUMENTATION FILES:
{file_list}

CHECKS TO PERFORM:
{json.dumps(self.config['checks'], indent=2)}

THRESHOLDS:
{json.dumps(self.config['thresholds'], indent=2)}

DOCUMENTATION CONTENT:
{doc_content}

---

Please perform a thorough audit and generate a report following this structure:

# Documentation Audit Report
Date: {datetime.now().strftime('%Y-%m-%d')}
Auditor: Claude (Automated)
Files Reviewed: {len(docs)}

## Executive Summary
[Provide 2-3 sentence overview of documentation health]

Overall Health: [Excellent / Good / Fair / Needs Attention]
Critical Issues: [count]
High Priority Issues: [count]
Documentation Coverage: [percentage]%

---

## Findings by Priority

### Critical Issues (Fix Immediately)

[List each critical issue with:
- Issue description
- Location (file:line or section)
- Impact
- Recommendation
]

If no critical issues: "✅ No critical issues found."

### High Priority Issues (Fix This Week)

[List each high priority issue with same format]

If none: "✅ No high priority issues found."

### Medium Priority Issues (Fix This Month)

[List each medium priority issue]

### Low Priority Issues (Fix When Convenient)

[List each low priority issue]

---

## Specific Issues

### Outdated References
[List any references to removed code, old patterns, deprecated APIs]

### Duplicate Content
[List any significant duplication across files]

### Missing Documentation
[List modules/workflows/conventions that should be documented but aren't]

### File Size Issues
[List files exceeding {self.config['thresholds']['max_file_size']} lines]

### Broken Links
[List any broken internal references]

---

## Coverage Analysis

### Modules
- Documented: [count]
- Missing: [list]
- Coverage: [percentage]%

### Workflows  
- Documented: [list]
- Missing: [list]

### Conventions
- Documented: [list]
- Missing: [list]

---

## Statistics

- Total files: {len(docs)}
- Total lines: [sum of all lines]
- Average file size: [average lines]
- Issues found: [total count]

---

## Recommendations

[List top 3-5 actionable recommendations]

---

## CI/CD Status

Overall Status: [PASS / WARNING / FAIL]

- PASS: No critical issues, <5 high priority issues
- WARNING: 1-2 critical issues OR 5-10 high priority issues  
- FAIL: 3+ critical issues OR 10+ high priority issues

Exit Code Recommendation: [0 for PASS, 1 for WARNING, 2 for FAIL]

---

IMPORTANT: 
- Be specific about locations (file:line)
- Prioritize issues accurately
- Focus on actionable findings
- Keep the report concise but comprehensive
- The report will be used in automated CI/CD, so clarity is critical
"""
        
        return prompt
    
    def run_audit(self) -> str:
        """Execute the audit using Claude API."""
        print("📋 Collecting documentation files...")
        docs = self.collect_documentation()
        
        if not docs:
            return self._generate_no_docs_report()
        
        print(f"✓ Found {len(docs)} documentation files")
        print(f"📊 Total documentation: {sum(len(c.splitlines()) for c in docs.values())} lines")
        
        print("\n🤖 Running Claude audit...")
        prompt = self.build_audit_prompt(docs)
        
        try:
            message = self.client.messages.create(
                model=self.model,
                max_tokens=self.max_tokens,
                messages=[{
                    "role": "user",
                    "content": prompt
                }]
            )
            
            report = message.content[0].text
            print("✓ Audit completed successfully")
            
            return report
            
        except Exception as e:
            print(f"❌ Error during audit: {e}", file=sys.stderr)
            return self._generate_error_report(str(e))
    
    def _generate_no_docs_report(self) -> str:
        """Generate report when no documentation is found."""
        return f"""# Documentation Audit Report
Date: {datetime.now().strftime('%Y-%m-%d')}
Auditor: Claude (Automated)
Files Reviewed: 0

## Executive Summary

**ERROR**: No documentation files found.

Overall Health: Needs Attention
Critical Issues: 1

---

## Findings by Priority

### Critical Issues (Fix Immediately)

#### 1. No Documentation Found
- **Location**: Project root
- **Impact**: Cannot verify documentation quality - no files to audit
- **Recommendation**: Add CLAUDE.md and .claude/ directory structure

---

## CI/CD Status

Overall Status: FAIL
Exit Code Recommendation: 2
"""
    
    def _generate_error_report(self, error: str) -> str:
        """Generate report when audit fails."""
        return f"""# Documentation Audit Report
Date: {datetime.now().strftime('%Y-%m-%d')}
Auditor: Claude (Automated)
Status: ERROR

## Executive Summary

**ERROR**: Audit failed to complete.

---

## Error Details

```
{error}
```

---

## CI/CD Status

Overall Status: FAIL
Exit Code Recommendation: 2

---

*Please check the error details above and ensure:*
- ANTHROPIC_API_KEY is set correctly
- Documentation files are accessible
- Network connectivity is available
"""
    
    def save_report(self, report: str, output_path: Optional[str] = None) -> str:
        """Save the audit report to file."""
        path = output_path or self.config['output_path']
        
        # Ensure directory exists
        os.makedirs(os.path.dirname(path), exist_ok=True)
        
        # Write report
        with open(path, 'w', encoding='utf-8') as f:
            f.write(report)
        
        print(f"📄 Report saved to: {path}")
        return path
    
    def get_exit_code(self, report: str) -> int:
        """Extract recommended exit code from report."""
        # Look for exit code recommendation in report
        if "Exit Code Recommendation: 0" in report:
            return 0
        elif "Exit Code Recommendation: 1" in report:
            return 1
        else:
            return 2


def main():
    """Main entry point."""
    import argparse
    
    parser = argparse.ArgumentParser(
        description='Automated documentation audit using Claude API'
    )
    parser.add_argument(
        '--output-file',
        help='Output file path for audit report',
        default=None
    )
    parser.add_argument(
        '--config',
        help='Path to configuration YAML file',
        default='.github/audit-config.yml'
    )
    parser.add_argument(
        '--fail-on-issues',
        action='store_true',
        help='Exit with non-zero code if issues are found'
    )
    
    args = parser.parse_args()
    
    # Check for API key
    api_key = os.environ.get('ANTHROPIC_API_KEY')
    if not api_key:
        print("❌ Error: ANTHROPIC_API_KEY environment variable not set", file=sys.stderr)
        print("\nSet it in your environment or GitHub secrets:", file=sys.stderr)
        print("  export ANTHROPIC_API_KEY='your-key-here'", file=sys.stderr)
        sys.exit(1)
    
    print("🚀 Starting Documentation Audit")
    print("=" * 60)
    
    # Run audit
    auditor = DocumentationAuditor(api_key, args.config)
    report = auditor.run_audit()
    
    # Save report
    output_path = auditor.save_report(report, args.output_file)
    
    # Print summary
    print("\n" + "=" * 60)
    print("📊 AUDIT COMPLETE")
    print("=" * 60)
    
    # Extract key metrics from report
    if "Critical Issues: 0" in report and "High Priority Issues: 0" in report:
        print("✅ Status: PASS - No critical or high priority issues")
        exit_code = 0
    elif "Critical Issues: 0" in report:
        print("⚠️  Status: WARNING - High priority issues found")
        exit_code = 1
    else:
        print("❌ Status: FAIL - Critical issues found")
        exit_code = 2
    
    print(f"\n📄 Full report: {output_path}")
    
    if args.fail_on_issues:
        sys.exit(exit_code)
    else:
        # Always exit 0 unless there was an error
        sys.exit(0 if "ERROR" not in report else 1)


if __name__ == '__main__':
    main()
