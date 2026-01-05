# AI QA Workflow

A complete QA automation toolkit that connects AI coding agents with test management systems through MCP (Model Context Protocol) integrations.

## Project Goal

Enable **end-to-end test automation** from a single source of truth. Instead of manually copying information between Jira, Confluence, TestLink, and test scripts, we use AI coding agents to:

1. **Discover** requirements from Jira and Confluence via MCP
2. **Plan** test strategies using intelligent checklists
3. **Design** detailed test cases from requirements
4. **Manage** tests in TestLink via MCP
5. **Automate** test execution with the dual-judge framework
6. **Report** results back to source systems

This eliminates duplication, maintains traceability, and accelerates the QA process.

## Complete Test Lifecycle

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         COMPLETE TEST LIFECYCLE                              │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌──────────────┐    ┌──────────────┐    ┌──────────────┐                   │
│  │   PHASE 1    │    │   PHASE 2    │    │   PHASE 3    │                   │
│  │   DISCOVER   │───▶│    PLAN      │───▶│   DESIGN     │                   │
│  │              │    │              │    │              │                   │
│  │ Jira/Conflu- │    │ Test Plan    │    │ Test Cases   │                   │
│  │ ence via MCP │    │ Checklist    │    │ Checklist    │                   │
│  └──────────────┘    └──────────────┘    └──────────────┘                   │
│         │                   │                   │                            │
│         ▼                   ▼                   ▼                            │
│  ┌──────────────┐    ┌──────────────┐    ┌──────────────┐                   │
│  │   PHASE 4    │    │   PHASE 5    │    │   PHASE 6    │                   │
│  │   MANAGE     │───▶│   AUTOMATE   │───▶│   EXECUTE    │                   │
│  │              │    │              │    │              │                   │
│  │ TestLink     │    │ Test         │    │ CI/CD        │                   │
│  │ via MCP      │    │ Framework    │    │ Pipeline     │                   │
│  └──────────────┘    └──────────────┘    └──────────────┘                   │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

| Phase | Action | Tool/Command |
|-------|--------|--------------|
| 1. Discover | Gather requirements | MCP Atlassian, `/jira-trace` |
| 2. Plan | Create test strategy | `/test-planning-checklist` |
| 3. Design | Write test cases | `/test-case-design-checklist` |
| 4. Manage | Import to TestLink | MCP TestLink, `/create-test-case` |
| 5. Automate | Create YAML tests | [test-framework-template](https://github.com/dogkeeper886/test-framework-template) |
| 6. Execute | Run and report | `npm test`, `/create-test-execution` |

See [docs/workflows/test-lifecycle.md](docs/workflows/test-lifecycle.md) for the complete workflow guide.

## Notable Features

| Feature | Description |
|---------|-------------|
| **Single Source of Truth** | Requirements flow from Jira/Confluence through test design to execution |
| **MCP Integrations** | Direct access to Atlassian, TestLink, and Playwright via Model Context Protocol |
| **Intelligent Commands** | AI-powered test planning and case design checklists |
| **Dual-Judge Framework** | Test execution with both deterministic and semantic (LLM) verification |
| **Define Once, Deploy Twice** | Commands work in both Claude Code and Cursor IDEs |
| **Complete Workflow** | Covers discovery, planning, design, management, automation, and reporting |

## Quick Start

### Installation

```bash
# Clone the repository
git clone https://github.com/dogkeeper886/ai-qa-workflow
cd ai-qa-workflow

# Install commands to your IDE
make install

# Or install to specific IDE only
make install-claude    # Claude Code only
make install-cursor    # Cursor only
```

### After Installation

1. Restart your IDE
2. Commands available as slash commands (e.g., `/jira-trace`)
3. Configure MCP integrations (see [docs/integrations/](docs/integrations/))

## Available Commands

### QA Workflow Commands

| Command | Purpose |
|---------|---------|
| `/test-planning-checklist` | Create comprehensive test plan from requirements |
| `/test-case-design-checklist` | Design detailed test cases from test plan |
| `/bug-report-generator` | Generate well-structured bug reports |
| `/qualityquest-scrum-task` | Generate Scrum task content for QA |

### Jira Commands

| Command | Purpose |
|---------|---------|
| `/jira-trace` | Trace tickets and gather all related information |
| `/jira-issue-summary` | Generate AI-powered issue summary |
| `/jira-to-markdown` | Convert Jira ticket to Markdown |

### Confluence Commands

| Command | Purpose |
|---------|---------|
| `/confluence-page-summary` | Generate page summary |
| `/confluence-to-markdown` | Convert page to Markdown |
| `/create-confluence-page` | Create page from markdown content |

### TestLink Commands

| Command | Purpose |
|---------|---------|
| `/list-projects` | List all TestLink projects |
| `/list-test-suites` | List test suites in project |
| `/create-test-suite` | Create new test suite |
| `/create-test-case` | Create test case with HTML formatting |
| `/get-test-case` | Retrieve test case details |
| `/update-test-case` | Update existing test case |
| `/create-test-plan` | Create new test plan |
| `/add-test-case-to-test-plan` | Assign test case to plan |
| `/create-test-execution` | Record test execution result |
| `/execute-test-case` | Execute test via browser automation |

### Utility Commands

| Command | Purpose |
|---------|---------|
| `/rewrite-text` | Simplify text while keeping meaning |
| `/robot-log-analyzer` | Analyze Robot Framework logs |
| `/identify-test-type` | Categorize test as GUI/API/Other |

## Documentation

### Integrations

- [MCP Atlassian](docs/integrations/mcp-atlassian.md) - Jira and Confluence access
- [MCP TestLink](docs/integrations/mcp-testlink.md) - Test management
- [MCP Playwright](docs/integrations/mcp-playwright.md) - Browser automation
- [Test Framework Template](docs/integrations/test-framework-template.md) - Dual-judge execution

### Workflows

- [Test Lifecycle](docs/workflows/test-lifecycle.md) - Complete end-to-end workflow

### Design

- [Principles](docs/design/principles.md) - Core design guidelines

## Related Projects

| Project | Purpose | Repository |
|---------|---------|------------|
| **Test Framework Template** | Dual-judge test execution | [dogkeeper886/test-framework-template](https://github.com/dogkeeper886/test-framework-template) |
| **TestLink MCP** | TestLink API integration | [dogkeeper886/testlink-mcp](https://github.com/dogkeeper886/testlink-mcp) |
| **MCP Atlassian** | Jira/Confluence integration | [sooperset/mcp-atlassian](https://github.com/sooperset/mcp-atlassian) |

## Project Structure

```
ai-qa-workflow/
├── commands/
│   ├── confluence/     # Confluence commands
│   ├── jira/           # Jira commands
│   ├── qa/             # QA workflow commands
│   ├── testlink/       # TestLink commands
│   └── utilities/      # Utility commands
├── docs/
│   ├── integrations/   # MCP integration guides
│   ├── workflows/      # End-to-end workflows
│   └── design/         # Design principles
├── Makefile            # Installation automation
└── README.md
```

## For Developers

### Adding New Commands

1. Create markdown file in appropriate `commands/` subfolder
2. Follow the standard template (see existing commands)
3. Test with `make install`
4. Commit only the source file

### Command Template

```markdown
# Command Name

## Purpose
One-sentence description

## Input
- parameter_name (type): Description

## Process
1. Step one
2. Step two

## Output
What gets created
```

### Updating Commands

```bash
git pull
make install    # Updates all IDE commands
```

## License

MIT
