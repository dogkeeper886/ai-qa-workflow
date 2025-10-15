# AI QA Workflow - Command Installation Makefile
# Follows GNU Coding Standards conventions

# Installation directories
prefix      = $(HOME)
exec_prefix = $(prefix)
bindir      = $(exec_prefix)/bin
datarootdir = $(prefix)/share
datadir     = $(datarootdir)

# Claude Code and Cursor specific directories
CLAUDE_DIR  = $(prefix)/.claude/commands
CURSOR_DIR  = $(prefix)/.cursor/commands

# Source directory
SRCDIR      = commands

# Installation command
INSTALL         = install
INSTALL_DATA    = $(INSTALL) -m 644

# All command files
COMMANDS = $(wildcard $(SRCDIR)/*/*.md)

.PHONY: all install install-claude install-cursor uninstall clean help

# Default target
all:
	@echo "Run 'make install' to install commands"
	@echo "Run 'make help' for more options"

# Standard install target - installs to both IDEs
install: install-claude install-cursor
	@echo ""
	@echo "Installation complete."
	@echo "Restart your IDE to load the commands."

# Install to Claude Code
install-claude:
	@echo "Installing commands to Claude Code..."
	@mkdir -p $(DESTDIR)$(CLAUDE_DIR)
	@for file in $(COMMANDS); do \
		$(INSTALL_DATA) $$file $(DESTDIR)$(CLAUDE_DIR)/; \
	done
	@echo "Commands installed to $(DESTDIR)$(CLAUDE_DIR)"

# Install to Cursor
install-cursor:
	@echo "Installing commands to Cursor..."
	@mkdir -p $(DESTDIR)$(CURSOR_DIR)
	@for file in $(COMMANDS); do \
		$(INSTALL_DATA) $$file $(DESTDIR)$(CURSOR_DIR)/; \
	done
	@echo "Commands installed to $(DESTDIR)$(CURSOR_DIR)"

# Uninstall - remove installed commands
uninstall:
	@echo "Removing installed commands..."
	@rm -f $(DESTDIR)$(CLAUDE_DIR)/*.md
	@rmdir $(DESTDIR)$(CLAUDE_DIR) 2>/dev/null || true
	@rm -f $(DESTDIR)$(CURSOR_DIR)/*.md
	@rmdir $(DESTDIR)$(CURSOR_DIR) 2>/dev/null || true
	@echo "Commands uninstalled."

# Clean - nothing to clean in source directory
clean:
	@echo "Nothing to clean."

# Help message
help:
	@echo "AI QA Workflow - Command Installation"
	@echo ""
	@echo "Targets:"
	@echo "  make               - Show this help"
	@echo "  make install       - Install commands to both Claude Code and Cursor"
	@echo "  make install-claude - Install commands to Claude Code only"
	@echo "  make install-cursor - Install commands to Cursor only"
	@echo "  make uninstall     - Remove installed commands"
	@echo "  make help          - Show this help message"
	@echo ""
	@echo "Variables (GNU standard):"
	@echo "  prefix=DIR         - Installation prefix (default: HOME)"
	@echo "  DESTDIR=DIR        - Stage installation to DIR (for packaging)"
	@echo ""
	@echo "Examples:"
	@echo "  make install                           # Install to ~/.claude and ~/.cursor"
	@echo "  make install prefix=/usr/local         # Install to /usr/local/.claude, etc."
	@echo "  make install DESTDIR=/tmp/staging      # Stage for package creation"
	@echo "  make install-claude prefix=/opt/tools  # Install to /opt/tools/.claude only"
	@echo "  make uninstall                         # Remove all installed commands"
