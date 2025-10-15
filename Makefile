.PHONY: install-claude install-cursor install-all install help

# Default installation prefix (can be overridden: make install PREFIX=/custom/path)
PREFIX ?= $(HOME)

# Install commands to Claude Code
install-claude:
	@echo "Installing commands to Claude Code..."
	@mkdir -p $(PREFIX)/.claude/commands
	@cp commands/*/*.md $(PREFIX)/.claude/commands/
	@echo "✓ Commands installed to $(PREFIX)/.claude/commands"

# Install commands to Cursor
install-cursor:
	@echo "Installing commands to Cursor..."
	@mkdir -p $(PREFIX)/.cursor/commands
	@cp commands/*/*.md $(PREFIX)/.cursor/commands/
	@echo "✓ Commands installed to $(PREFIX)/.cursor/commands"

# Install to custom directory (use: make install DESTDIR=/path/to/dir)
install:
	@echo "Installing commands to custom directory..."
	@mkdir -p $(DESTDIR)
	@cp commands/*/*.md $(DESTDIR)/
	@echo "✓ Commands installed to $(DESTDIR)"

# Install commands to both IDEs
install-all: install-claude install-cursor
	@echo ""
	@echo "✓ All commands installed successfully"
	@echo "  Restart your IDE to use the commands"

# Show help
help:
	@echo "Available targets:"
	@echo "  make install-claude          - Install commands to Claude Code (~/.claude/commands)"
	@echo "  make install-cursor          - Install commands to Cursor (~/.cursor/commands)"
	@echo "  make install-all             - Install commands to both IDEs (default)"
	@echo "  make install DESTDIR=/path   - Install to custom directory"
	@echo "  make help                    - Show this help message"
	@echo ""
	@echo "Variables:"
	@echo "  PREFIX=/path   - Change base directory (default: HOME)"
	@echo "  DESTDIR=/path  - Install directly to specified directory"
	@echo ""
	@echo "Examples:"
	@echo "  make install-claude PREFIX=/custom/path"
	@echo "  make install DESTDIR=/home/jack/src/TestCases"
	@echo ""
	@echo "Alternative: Use ./install.sh for more options"

# Default target
.DEFAULT_GOAL := install-all
