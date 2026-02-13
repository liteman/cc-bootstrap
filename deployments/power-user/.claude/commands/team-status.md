Report the current agent team status.

Check and report on:

1. **Active Team**: Read the team configuration to determine if a team is active
2. **Teammates**: List active teammates, their roles, and current status (idle/working)
3. **Task List**: Use TaskList to get counts of pending, in-progress, and completed tasks
4. **Mailbox**: Check for any unread messages

Respond with:

```
Agent Team Status:
- Team: [team name or "No active team"]
- Teammates: [count active / count total]
  - [name]: [role] — [status]
- Task List: [pending] pending / [in_progress] in progress / [completed] completed
- Mailbox: [unread count] unread messages
```

If no team is active, suggest how to start one using the agent team workflow at `.claude/workflows/agent-team-development.md`.
