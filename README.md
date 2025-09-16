# AI QA Workflow Collection

A curated collection of tools, commands, and workflows for AI-powered QA processes across multiple platforms (Claude Code, Cursor, and more). This project implements a "define once, generate twice" approach to eliminate duplication and maintain consistency across different AI coding environments.

## 🎯 Collection Goals

- **Tool Curation**: Collect and organize the most effective QA tools and commands
- **Workflow Design**: Create reusable workflow patterns for common QA tasks
- **Tool Integration**: Seamlessly connect tools across different AI coding platforms
- **Knowledge Sharing**: Document best practices and tool usage patterns

## 🏗️ Collection Architecture

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
│   ├── copy-command-to-platforms.md
│   └── rewrite-text.md
├── .claude/commands/           # Claude Code format
├── .cursor/commands/           # Cursor format
├── docs/                       # Documentation and guides
│   ├── brainstorming-session-results.md
│   └── mcp-atlassian-cheatsheet.md
└── README.md
```

## 📝 Command Definition Standards

Each command follows a standardized markdown template:

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

## 🚀 Current Tools & Commands

### 1. Copy Command to Platforms
**Purpose**: Copy AI command prompt files to both AI coding platforms

**Usage**:
- Claude Code: `/copy-command-to-platforms`
- Cursor: `copyCommandToPlatforms`

**Input**: Command file content

### 2. Rewrite Text
**Purpose**: Rewrite text in simple, easy words while keeping the original meaning

**Usage**:
- Claude Code: `/rewrite-text`
- Cursor: `rewriteText`

**Input**: Text to be rewritten

### 3. Bug Report Generator
**Purpose**: Generate clear, well-structured bug reports for easy copying to Jira, email, or documentation

**Usage**:
- Claude Code: `/bug-report-generator`
- Cursor: `bugReportGenerator`

**Input**: Bug title, description, reproduction steps, actual/expected behavior, and optional notes

### 4. Jira Issue Summary Generator
**Purpose**: Generate AI-powered summary of Jira issue for customer communication and reporting

**Usage**:
- Claude Code: `/jira-issue-summary`
- Cursor: `jiraIssueSummary`

**Input**: Jira issue key

### 5. Jira to Markdown Converter
**Purpose**: Convert Jira ticket to Markdown format for documentation and sharing

**Usage**:
- Claude Code: `/jira-to-markdown`
- Cursor: `jiraToMarkdown`

**Input**: Jira issue key

### 6. QualityQuest Scrum Task Generator
**Purpose**: Generate detailed Scrum task content for Software Quality Assurance Engineers based on task description

**Usage**:
- Claude Code: `/qualityquest-scrum-task`
- Cursor: `qualityquestScrumTask`

**Input**: Task description

## 🛠️ Collection Workflow

1. **Tool Discovery**: Identify useful QA tools and commands
2. **Tool Design**: Create standardized definitions following our template
3. **Tool Integration**: Deploy tools across supported platforms
4. **Tool Testing**: Verify tools work correctly in different environments
5. **Tool Documentation**: Document usage patterns and best practices

## 📚 Documentation

- **[Design Guidelines](docs/brainstorming-session-results.md)**: Core design principles and standards
- **[MCP Atlassian Cheatsheet](docs/mcp-atlassian-cheatsheet.md)**: Integration reference for Atlassian tools

## 🔧 Integration Features

- **MCP Atlassian Integration**: Seamless connection to Confluence and Jira
- **Cross-Platform Compatibility**: Works with Claude Code, Cursor, and other AI coding platforms
- **Version Control**: Git-based tracking of tool evolution
- **Tool Synchronization**: Keep tools in sync across all platforms

## 🤝 Contributing

1. **Add New Tools**: Follow the established markdown template for new commands
2. **Improve Existing Tools**: Enhance current tools with better functionality
3. **Document Workflows**: Share how you use tools together in workflows
4. **Test Across Platforms**: Verify tools work on all supported platforms
5. **Maintain Standards**: Keep the "define once, generate twice" principle

## 📄 License

This project is part of an internal AI QA workflow collection designed to improve testing efficiency and consistency across development teams.

---

*Built with simplicity and human-centric design in mind.*