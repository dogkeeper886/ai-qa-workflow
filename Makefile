.PHONY: install-claude install-cursor install-all help

# Install commands to Claude Code
install-claude:
	@echo "Installing commands to Claude Code..."
	@mkdir -p ~/.claude/commands
	@cp commands/*/*.md ~/.claude/commands/
	@echo "✓ Commands installed to ~/.claude/commands"

# Install commands to Cursor
install-cursor:
	@echo "Installing commands to Cursor..."
	@mkdir -p ~/.cursor/commands
	@cp commands/*/*.md ~/.cursor/commands/
	@echo "✓ Commands installed to ~/.cursor/commands"

# Install commands to both IDEs
install-all: install-claude install-cursor
	@echo ""
	@echo "✓ All commands installed successfully"
	@echo "  Restart your IDE to use the commands"

# Show help
help:
	@echo "Available targets:"
	@echo "  make install-claude    - Install commands to Claude Code"
	@echo "  make install-cursor    - Install commands to Cursor"
	@echo "  make install-all       - Install commands to both IDEs (default)"
	@echo "  make help              - Show this help message"
	@echo ""
	@echo "Alternative: Use ./install.sh for more options"

# Default target
.DEFAULT_GOAL := install-all
