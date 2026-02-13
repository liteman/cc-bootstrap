Create a new custom subagent definition from the template.

1. Read `.claude/agents/_template.md` to get the template structure
2. Copy it to `.claude/agents/$ARGUMENTS.md`
3. Ask the user for:
   - **Role**: What does this agent specialize in?
   - **Model**: Which model? (opus for reasoning, sonnet for implementation, haiku for review)
   - **Tools**: Which tools does it need? (Read, Glob, Grep, Bash, Edit, Write)
   - **Constraints**: What should this agent NOT do?
4. Fill in the template with the provided details and write the file

If `$ARGUMENTS` is empty, ask the user what they want to name the agent.

After creating, confirm the file was written and suggest adding it to the Agent Teams section in CLAUDE.md.
