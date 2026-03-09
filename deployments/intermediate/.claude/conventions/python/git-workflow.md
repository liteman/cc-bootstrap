# Git Workflow — Python Projects

> **When to read**: Before creating branches, making commits, or submitting PRs

Git workflow conventions are language-agnostic. See the main `../git-workflow.md` for the full reference.

## Python-Specific Notes

- Use `ruff check` and `ruff format` before committing
- Run `python -m pytest` to verify tests pass before pushing
- Include `pyproject.toml` changes in commits that add/remove dependencies
- Never commit `.env`, `__pycache__/`, `.venv/`, or `*.pyc` files
