#!/bin/bash

# AI QA Workflow - Installation Script
# This script installs command files to your IDE's command directory

set -e  # Exit on error

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Default installation paths
CLAUDE_PATH="$HOME/.claude/commands"
CURSOR_PATH="$HOME/.cursor/commands"

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="$SCRIPT_DIR/commands"

print_usage() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --claude          Install to Claude Code only (~/.claude/commands)"
    echo "  --cursor          Install to Cursor only (~/.cursor/commands)"
    echo "  --all             Install to both Claude Code and Cursor (default)"
    echo "  --path <path>     Install to custom path"
    echo "  --help            Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0                          # Install to both IDEs"
    echo "  $0 --claude                 # Install to Claude Code only"
    echo "  $0 --path /custom/path      # Install to custom location"
}

install_commands() {
    local target_dir="$1"
    local ide_name="$2"

    echo -e "${BLUE}Installing commands to $ide_name...${NC}"

    # Create target directory if it doesn't exist
    mkdir -p "$target_dir"

    # Copy all command files from subdirectories
    local count=0
    for subdir in "$SOURCE_DIR"/*; do
        if [ -d "$subdir" ]; then
            for file in "$subdir"/*.md; do
                if [ -f "$file" ]; then
                    cp "$file" "$target_dir/"
                    ((count++))
                fi
            done
        fi
    done

    echo -e "${GREEN}✓ Installed $count commands to $target_dir${NC}"
}

# Parse command line arguments
INSTALL_CLAUDE=false
INSTALL_CURSOR=false
CUSTOM_PATH=""

if [ $# -eq 0 ]; then
    # No arguments - install to both
    INSTALL_CLAUDE=true
    INSTALL_CURSOR=true
else
    while [ $# -gt 0 ]; do
        case "$1" in
            --claude)
                INSTALL_CLAUDE=true
                shift
                ;;
            --cursor)
                INSTALL_CURSOR=true
                shift
                ;;
            --all)
                INSTALL_CLAUDE=true
                INSTALL_CURSOR=true
                shift
                ;;
            --path)
                CUSTOM_PATH="$2"
                shift 2
                ;;
            --help)
                print_usage
                exit 0
                ;;
            *)
                echo -e "${RED}Error: Unknown option $1${NC}"
                print_usage
                exit 1
                ;;
        esac
    done
fi

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo -e "${RED}Error: Source directory not found: $SOURCE_DIR${NC}"
    exit 1
fi

echo -e "${BLUE}======================================${NC}"
echo -e "${BLUE}  AI QA Workflow - Command Installer${NC}"
echo -e "${BLUE}======================================${NC}"
echo ""

# Install to specified locations
if [ -n "$CUSTOM_PATH" ]; then
    install_commands "$CUSTOM_PATH" "custom location"
else
    if [ "$INSTALL_CLAUDE" = true ]; then
        install_commands "$CLAUDE_PATH" "Claude Code"
    fi

    if [ "$INSTALL_CURSOR" = true ]; then
        install_commands "$CURSOR_PATH" "Cursor"
    fi
fi

echo ""
echo -e "${GREEN}======================================${NC}"
echo -e "${GREEN}Installation complete!${NC}"
echo -e "${GREEN}======================================${NC}"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "  1. Restart your IDE if it's currently running"
echo "  2. Commands will be available as slash commands"
echo "  3. Run this script again anytime to update commands"
echo ""
