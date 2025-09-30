.PHONY: sync-commands

sync-commands:
	@echo "Syncing commands to IDE directories..."
	@cp commands/jira/*.md .cursor/commands/
	@cp commands/jira/*.md .claude/commands/
	@cp commands/qa/*.md .cursor/commands/
	@cp commands/qa/*.md .claude/commands/
	@cp commands/utilities/*.md .cursor/commands/
	@cp commands/utilities/*.md .claude/commands/
	@cp commands/confluence/*.md .cursor/commands/
	@cp commands/confluence/*.md .claude/commands/
	@cp commands/testlink/*.md .cursor/commands/
	@cp commands/testlink/*.md .claude/commands/
	@echo "Commands synced successfully"
