# AI QA Workflow Collection

A curated collection of tools, commands, and workflows for AI-powered QA processes across multiple platforms (Claude Code, Cursor, and more). This project implements a "define once, generate twice" approach to eliminate duplication and maintain consistency across different AI coding environments.

## 🚀 Quick Start

### For Claude Code Users
1. Copy the `.claude/` folder to your workspace
2. Use slash commands like `/bug-report-generator` in Claude Code

### For Cursor Users  
1. Copy the `.cursor/` folder to your workspace
2. Use slash commands like `/bug-report-generator` in Cursor

### For Other IDE Users
1. Check the `commands/` folder to understand command structure
2. Implement your own command system based on the markdown templates
3. Use `copy-command-to-platforms.md` to convert commands to your platform format

## 📋 Available Commands

| Command | Purpose | Input |
|---------|---------|-------|
| `/bug-report-generator` | Generate clear, well-structured bug reports for Jira, email, or documentation | Bug title, description, reproduction steps, actual/expected behavior |
| `/jira-issue-summary` | Generate AI-powered summary of Jira issue for customer communication | Jira issue key |
| `/jira-to-markdown` | Convert Jira ticket to Markdown format for documentation and sharing | Jira issue key |
| `/jira-trace` | Generate traceability matrix linking requirements to test cases | Jira issue key or requirements |
| `/qualityquest-scrum-task` | Generate detailed Scrum task content for QA Engineers | Task description |
| `/rewrite-text` | Rewrite text in simple, easy words while keeping the original meaning | Text to be rewritten |
| `/robot-log-analyzer` | Analyze Robot Framework test execution logs and generate insights | Robot Framework log file or content |
| `/test-planning-checklist` | Generate comprehensive test planning checklist for QA projects | Project details and testing scope |
| `/testlink-format` | Convert test cases to TestLink XML format for import | Test case data in various formats |
| `/copy-command-to-platforms` | Copy AI command prompt files to both AI coding platforms | Command file content |

## 📚 Documentation & Integration

### MCP Integrations
- **[MCP Atlassian Cheatsheet](docs/mcp-atlassian-cheatsheet.md)**: Integration reference for Atlassian tools
- **[MCP TestLink Cheatsheet](docs/mcp-testlink-cheatsheet.md)**: Integration reference for TestLink test management

### Additional Resources
- **[Design Guidelines](docs/brainstorming-session-results.md)**: Core design principles and standards

## 🛠️ For Developers

### Adding New Commands

1. **Create Command File**: Add your new command to the `commands/` folder following the markdown template
2. **Use Conversion Tool**: Use `copy-command-to-platforms.md` to convert your command to both platform formats
3. **Deploy to Platforms**: Copy the generated files to `.claude/commands/` and `.cursor/commands/` folders
4. **Test & Validate**: Ensure your command works correctly on both platforms

### Command Template Structure

Each command in `commands/` follows this standardized format:

```markdown
# Command Name

## Purpose
Clear, one-sentence description of what this does

## Input
- parameter_name (type): Description
- another_param (type, optional): Description

## Process
1. Step one
2. Step two
3. Step three

## Output
What gets created or modified

## Platform Notes
- Claude Code: /command-name
- Cursor: commandName, ctrl+shift+x
```

## 🏗️ Architecture & Standards

### Core Design Principles

1. **One Format to Rule Them All**: Markdown-based command definitions
2. **No Complex Schemas**: Plain text that's human-readable and editable
3. **Minimal Tooling**: Simple scripts, not complex frameworks
4. **Platform-Agnostic Core**: Logic that works everywhere
5. **Platform-Specific Adapters**: Minimal code to bridge differences

### File Structure

```
ai-qa-workflow/
├── commands/                    # Source command definitions
│   ├── bug-report-generator.md
│   ├── copy-command-to-platforms.md
│   ├── jira-issue-summary.md
│   ├── jira-to-markdown.md
│   ├── jira-trace.md
│   ├── qualityquest-scrum-task.md
│   ├── rewrite-text.md
│   ├── robot-log-analyzer.md
│   ├── test-planning-checklist.md
│   └── testlink-format.md
├── .claude/commands/           # Claude Code format
├── .cursor/commands/           # Cursor format
├── docs/                       # Documentation and guides
│   ├── brainstorming-session-results.md
│   ├── mcp-atlassian-cheatsheet.md
│   └── mcp-testlink-cheatsheet.md
└── README.md
```

### Contributing Guidelines

1. **Follow Standards**: Use the established markdown template for consistency
2. **Test Thoroughly**: Verify commands work on both Claude Code and Cursor
3. **Document Clearly**: Provide clear input/output descriptions
4. **Maintain Quality**: Keep the "define once, generate twice" principle
5. **Share Workflows**: Document how commands work together in real workflows

## 📄 License

This project is part of an internal AI QA workflow collection designed to improve testing efficiency and consistency across development teams.

---

*Built with simplicity and human-centric design in mind.*