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

| Phase | Action | Skill | Commands |
|-------|--------|-------|----------|
| 1. Discover | Gather requirements | `/receiving-tickets` | `/jr-trace` |
| 2. Plan | Create test strategy | `/planning-tests` | `/tw-plan-init` |
| 3. Design | Write test cases | `/designing-cases` | `/tw-case-init` |
| 3b. Review | Notify stakeholders | `/drafting-review-email` | `/pm-demo-email` |
| 4. Manage | Import to TestLink | `/syncing-testlink` | `/tl-sync` |
| 4b. Execute | Run via browser | `/executing-tests` | `/tl-execute-case` |
| 5. Automate | Create YAML tests | — | [test-framework-template](https://github.com/dogkeeper886/test-framework-template) |
| 6. Report | Analyze failures | `/analyzing-logs` | `/robot-log-analyzer` |

See [docs/workflows/test-lifecycle.md](docs/workflows/test-lifecycle.md) for the complete workflow guide.

## Notable Features

| Feature | Description |
|---------|-------------|
| **Single Source of Truth** | Requirements flow from Jira/Confluence through test design to execution |
| **MCP Integrations** | Direct access to Atlassian, TestLink, and Playwright via Model Context Protocol |
| **Agent Skills** | 8 high-level skills cover complete lifecycle phases with built-in checklists |
| **53 Slash Commands** | Granular commands for targeted, atomic operations |
| **Dual-Judge Framework** | Test execution with both deterministic and semantic (LLM) verification |
| **Define Once, Deploy Twice** | Commands work in both Claude Code and Cursor IDEs |
| **Orchestration Pattern** | Skills and commands detect context and route to focused sub-tasks |
| **Complete Workflow** | Covers discovery, planning, design, management, automation, and reporting |

## Orchestration Pattern

Commands use a **detect-and-route** pattern: a short entry-point command reads the project context, classifies it, and routes to the right specialist command. Each command ends with a "Next step" hint so the agent always knows what to do next.

### Orchestration Styles

| Style | Entry Point | How It Works |
|-------|-------------|--------------|
| **Sequential Pipeline** | `/jr-trace` | Chains through fetch → structure → docs in a fixed order |
| **Fan-out Router** | `/tw-plan-init` | Detects type (feature/enhance/bugfix) and routes to one specialist |
| **Smart Diff** | `/tl-sync` | Compares local files against TestLink, applies only the changes |

### End-to-End Flow

**Using skills (recommended):**
```
/receiving-tickets → /planning-tests → /designing-cases → /syncing-testlink → /executing-tests
                                              │
                                   /drafting-review-email
```

**Using commands (granular):**
```
/jr-trace → /tw-plan-init → /tw-plan-review → /tw-case-init → /tw-case-review → /tl-sync
  │              │                                   │
  ├─ fetch       ├─ feature                          ├─ feature
  ├─ structure   ├─ enhance                          ├─ enhance
  └─ docs        └─ bugfix                           └─ bugfix
```

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
2. Skills available as slash commands (e.g., `/receiving-tickets`)
3. All 53 commands also available (e.g., `/jr-trace`)
4. Configure MCP integrations (see [docs/integrations/](docs/integrations/))

## Agent Skills

Skills are the recommended high-level interface. Each skill covers a complete lifecycle phase with a built-in progress checklist, validation steps, and references for detailed guidance.

| Skill | Invoke as | Phase | Description |
|---|---|---|---|
| `receiving-tickets` | `/receiving-tickets` | 1 — Discover | Fetch Jira ticket + linked issues + Confluence pages, create project workspace |
| `planning-tests` | `/planning-tests` | 2 — Plan | Detect ticket type, write test plan, publish to Confluence |
| `designing-cases` | `/designing-cases` | 3 — Design | Write detailed test cases from plan, publish to Confluence |
| `drafting-review-email` | `/drafting-review-email` | 3 — Review | Draft stakeholder review email and meeting invite |
| `syncing-testlink` | `/syncing-testlink` | 4 — Manage | Sync test cases into TestLink, build test plan |
| `executing-tests` | `/executing-tests` | 4/6 — Execute | Execute test plan via browser automation, record results |
| `creating-demo` | `/creating-demo` | — | Create demo PPTX with browser-verified screenshots |
| `analyzing-logs` | `/analyzing-logs` | 6 — Report | Analyze Robot Framework logs, group failures, suggest fixes |

See [docs/workflows/skills.md](docs/workflows/skills.md) for invocation patterns, trigger phrases, and MCP requirements per skill.

## Available Commands

### Test Workflow Commands (tw-*)

| Command | Purpose |
|---------|---------|
| `/tw-plan-init` | Initialize test planning (routes to feature/enhance/bugfix) |
| `/tw-plan-feature` | Create test plan for new features |
| `/tw-plan-enhance` | Create test plan for enhancements |
| `/tw-plan-bugfix` | Create test plan for bug fixes |
| `/tw-plan-review` | Review test plan quality |
| `/tw-case-init` | Initialize test case creation (routes by plan type) |
| `/tw-case-feature` | Create test cases for new features |
| `/tw-case-enhance` | Create test cases for enhancements |
| `/tw-case-bugfix` | Create test cases for bug fixes |
| `/tw-case-review` | Review test case quality |
| `/tw-diagrams` | Generate test diagrams |
| `/tw-script-review` | Review test scripts against documentation |
| `/tw-templates` | Test workflow templates reference |

### Project Commands (pm-*)

| Command | Purpose |
|---------|---------|
| `/pm-init` | Initialize test project structure |
| `/pm-bug-report` | Generate well-structured bug reports |
| `/pm-scrum-task` | Generate Scrum task content for QA |
| `/pm-meeting-invite` | Create meeting invite for reviews |
| `/pm-demo-content` | Generate demo presentation content |
| `/pm-demo-review` | Review demo content quality |
| `/pm-demo-ppt` | Create PowerPoint slide outline |
| `/pm-demo-email` | Draft demo announcement email |

### Jira Commands (jr-*)

| Command | Purpose |
|---------|---------|
| `/jr-trace` | Trace tickets and gather all related information |
| `/jr-trace-fetch` | Fetch Jira ticket and linked issues |
| `/jr-trace-structure` | Structure traced data into project files |
| `/jr-trace-docs` | Fetch related Confluence documents |
| `/jr-issue-summary` | Generate AI-powered issue summary |
| `/jr-to-markdown` | Convert Jira ticket to Markdown |

### Confluence Commands (cf-*)

| Command | Purpose |
|---------|---------|
| `/cf-page-summary` | Generate page summary |
| `/cf-to-markdown` | Convert page to Markdown |
| `/cf-create-page` | Create page from markdown content |
| `/cf-update-page` | Update existing Confluence page |
| `/cf-review-page` | Review Confluence page quality |
| `/cf-format-guide` | Confluence formatting guidelines |

### TestLink Commands (tl-*)

| Command | Purpose |
|---------|---------|
| `/tl-list-projects` | List all TestLink projects |
| `/tl-list-suites` | List test suites in project |
| `/tl-list-cases` | List test cases in suite |
| `/tl-list-requirements` | List requirements |
| `/tl-create-suite` | Create new test suite |
| `/tl-create-case` | Create test case with HTML formatting |
| `/tl-get-case` | Retrieve test case details |
| `/tl-get-cases-for-plan` | Get test cases for a plan |
| `/tl-update-case` | Update existing test case |
| `/tl-update-suite` | Update existing test suite |
| `/tl-create-plan` | Create new test plan |
| `/tl-add-case-to-plan` | Assign test case to plan |
| `/tl-create-execution` | Record test execution result |
| `/tl-read-execution` | Read test execution details |
| `/tl-execute-case` | Execute test via browser automation |
| `/tl-sync` | Sync test cases with local files |
| `/tl-identify-type` | Categorize test as GUI/API/Other |
| `/tl-format` | TestLink HTML formatting reference |

### Utility Commands

| Command | Purpose |
|---------|---------|
| `/rewrite-text` | Simplify text while keeping meaning |
| `/robot-log-analyzer` | Analyze Robot Framework logs |

## Documentation

### Integrations

- [MCP Atlassian](docs/integrations/mcp-atlassian.md) - Jira and Confluence access
- [MCP TestLink](docs/integrations/mcp-testlink.md) - Test management
- [MCP Playwright](docs/integrations/mcp-playwright.md) - Browser automation
- [Test Framework Template](docs/integrations/test-framework-template.md) - Dual-judge execution

### Workflows

- [Agent Skills](docs/workflows/skills.md) - Skills guide: invocation, trigger phrases, MCP requirements
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
│   ├── confluence/     # Confluence commands (cf-*)
│   ├── jira/           # Jira commands (jr-*)
│   ├── project/        # Project management commands (pm-*)
│   ├── testlink/       # TestLink commands (tl-*)
│   ├── test-workflow/  # Test planning and case workflows (tw-*)
│   └── utility/        # Utility commands
├── skills/
│   ├── receiving-tickets/    # Phase 1: Fetch ticket, create workspace
│   ├── planning-tests/       # Phase 2: Create test plan
│   ├── designing-cases/      # Phase 3: Write test cases
│   ├── drafting-review-email/ # Phase 3: Stakeholder review email
│   ├── syncing-testlink/     # Phase 4: Import cases to TestLink
│   ├── executing-tests/      # Phase 4/6: Browser test execution
│   ├── creating-demo/        # Demo PPTX generation
│   └── analyzing-logs/       # Phase 6: Robot Framework log analysis
├── demo/               # YouTube video script and example outputs
│   ├── examples/       # Sample command outputs
│   └── v1_commands/    # Original v1.0 monolithic commands
├── docs/
│   ├── integrations/   # MCP integration guides
│   ├── workflows/      # End-to-end workflows (test-lifecycle.md, skills.md)
│   └── design/         # Design principles
├── Makefile            # Installation automation
└── README.md
```

## For Developers

### Adding New Skills

1. Create `skills/<gerund-name>/SKILL.md` with YAML frontmatter (`name`, `description`, `disable-model-invocation`, `tools`)
2. Create `skills/<gerund-name>/references/*.md` for detailed content (API params, templates, rules)
3. Run `make install-skills` to deploy
4. Commit only source files under `skills/`

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
