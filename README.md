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
┌─────────────────────────────────────────────────────────────────────────┐
│                         COMPLETE TEST LIFECYCLE                         │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  ┌──────────────┐    ┌──────────────┐    ┌──────────────┐              │
│  │   PHASE 1    │    │   PHASE 2    │    │   PHASE 3    │              │
│  │   DISCOVER   │───▶│    PLAN      │───▶│   DESIGN     │              │
│  │              │    │              │    │              │              │
│  │ Jira/Conflu- │    │ Test Plan    │    │ Test Cases   │              │
│  │ ence via MCP │    │ Checklist    │    │ Checklist    │              │
│  └──────────────┘    └──────────────┘    └──────────────┘              │
│         │                   │                   │                      │
│         ▼                   ▼                   ▼                      │
│  ┌──────────────┐    ┌──────────────┐    ┌──────────────┐              │
│  │   PHASE 4    │    │   PHASE 5    │    │   PHASE 6    │              │
│  │   MANAGE     │───▶│   AUTOMATE   │───▶│   EXECUTE    │              │
│  │              │    │              │    │              │              │
│  │ TestLink     │    │ Test         │    │ Run & Report │              │
│  │ via MCP      │    │ Framework    │    │ Results      │              │
│  └──────────────┘    └──────────────┘    └──────────────┘              │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

| Phase | Action | Skill | Key Command |
|-------|--------|-------|-------------|
| 1. Discover | Gather requirements | `/receiving-tickets` | `/jr-trace` |
| 2. Plan | Create test strategy | `/planning-tests` | `/tw-plan-init` |
| 3. Design | Write test cases | `/designing-cases` | `/tw-case-init` |
| 4. Manage | Import to TestLink | `/syncing-testlink` | `/tl-sync` |
| 5. Automate | Create YAML tests | — | [test-framework-template](https://github.com/dogkeeper886/test-framework-template) |
| 6. Execute | Run & record results | `/executing-tests` | `/tl-execute-case` |

See [docs/workflows/test-lifecycle.md](docs/workflows/test-lifecycle.md) for the complete workflow guide.

## Notable Features

| Feature | Description |
|---------|-------------|
| **Single Source of Truth** | Requirements flow from Jira/Confluence through test design to execution |
| **MCP Integrations** | Direct access to Atlassian, TestLink, and Playwright via Model Context Protocol |
| **Agent Skills** | High-level skills route to slash commands, covering complete lifecycle phases |
| **Slash Commands** | Granular commands for targeted, atomic operations |
| **Dual-Judge Framework** | Test execution with both deterministic and semantic (LLM) verification |
| **Layered Architecture** | Skills (routers) → Commands (operations) → MCP tools |
| **Orchestration Pattern** | Skills and commands detect context and route to focused sub-tasks |

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
  ├─ docs        └─ bugfix                           └─ bugfix
  └─ verify
```

## Issue-Driven Development with `dw-*`

The dev workflow commands provide a structured development lifecycle where every change is driven by a GitHub issue.

### Usage

```
/dw-plan Add cross-repo sync commands     # Break request into GitHub issues
/dw-implement 27                           # Pick up issue, create branch, implement
/dw-create-pr 27                           # Push branch, open PR linked to issue
/dw-review-pr 30                           # Review PR against checklist
/dw-merge 30                               # Merge PR, clean up branch and labels
```

### Flow

```
/dw-plan → /dw-implement → /dw-create-pr → /dw-review-pr → /dw-merge
    │            │               │                │              │
 Create      Branch &        Push & open       Approve or    Merge PR,
 issues      implement       PR (Fixes #N)     request       auto-close
 with        on feature      with summary       changes       issue,
 labels      branch          & test plan                      clean up
```

Each step uses the GitHub issue as the single source of truth. Issues get status labels (`status:in-progress`, `status:needs-review`) and progress comments automatically. The PR's `Fixes #N` auto-closes the issue on merge.

### Branch Naming

Branches follow `issue-<N>-<short-slug>` convention (e.g., `issue-27-release-notes`), keeping the issue linkage visible in git history.

## Self-Improvement with `/evolve`

The `/evolve` command is an evidence-based self-improvement loop that analyzes project history and proposes actionable improvements to CLAUDE.md, commands, and skills.

### Usage

```
/evolve                     # Full analysis (issues + commits, last 90 days)
/evolve issues              # Analyze GitHub issues only
/evolve commits             # Analyze git commits only
/evolve --since 30d         # Override time range
/evolve commits --since 30d # Combine arguments
```

### 7-Phase Workflow

| Phase | Name | What It Does |
|-------|------|--------------|
| 0 | Read Prior Reports | Load previous evolve report to establish baseline |
| 1 | Data Collection | Gather GitHub issues, git commits, file changes, and session summaries |
| 2 | Pattern Detection | Detect workflow gaps, friction points, usage patterns, and knowledge decay |
| 3 | Generate Insights | Score each pattern by confidence (Low / Medium / High) with cited evidence |
| 4 | Evaluate Prior Actions | Check if previously applied actions were effective |
| 5 | Propose Actions | Group suggestions into CLAUDE.md updates, new/updated commands, skill improvements |
| 6–7 | Report & Apply | Output structured report, then apply selected actions with confirmation |

### Detection Categories

- **Workflow Gaps** — missing commands, manual steps that could be automated
- **Friction Points** — recurring fixes, reverts, long issue threads
- **Usage Patterns** — files always modified together, high-churn directories, unused commands
- **Knowledge Decay** — CLAUDE.md contradicted by recent commits, stale references

### Integration with `/session-summary`

When session summaries exist at `docs/session_summaries/patterns.md`, `/evolve` incorporates recurring friction points (3+ occurrences become high-confidence insights) and improvement candidates into its analysis.

### Reports

Reports are saved to `docs/evolve/[YYYY-MM-DD]_evolve_report.md` and include an effectiveness scorecard tracking whether prior actions achieved their goals.

## Quick Start

### Installation

Installation is agent-driven — your AI agent reads `CLAUDE.md` and guides you through it.

**From a local clone:**
```
git clone https://github.com/dogkeeper886/ai-qa-workflow
```
Then tell your AI agent: "Read /path/to/ai-qa-workflow/CLAUDE.md and install the commands I need"

The agent will:
1. Detect your project context and what MCP servers you have
2. Recommend relevant modules (e.g., Jira commands if you use mcp-atlassian)
3. Ask where to install — project folder or home folder
4. Compare with any existing commands and sync intelligently

### After Installation

1. Restart your IDE to load new commands
2. Skills available as slash commands (e.g., `/receiving-tickets`)
3. All commands also available (e.g., `/jr-trace`)
4. Configure MCP integrations (see [docs/integrations/](docs/integrations/))

### Updating

Same flow — tell your agent to re-read `CLAUDE.md` and it will compare, detect changes, and sync updates.

## Agent Skills

Skills are the recommended high-level interface. Each skill is a thin router that covers a complete lifecycle phase with a built-in progress checklist, routing to slash commands for each step.

| Skill | Invoke as | Phase | Description |
|---|---|---|---|
| `receiving-tickets` | `/receiving-tickets` | Discover | Fetch Jira ticket, linked issues, and Confluence pages; create project workspace |
| `planning-tests` | `/planning-tests` | Plan | Detect ticket type, write test plan, publish to Confluence |
| `designing-cases` | `/designing-cases` | Design | Write detailed test cases from plan, publish to Confluence |
| `drafting-review-email` | `/drafting-review-email` | Review | Draft stakeholder review email and meeting invite |
| `syncing-testlink` | `/syncing-testlink` | Manage | Sync test cases into TestLink with suites, cases, and test plan |
| `executing-tests` | `/executing-tests` | Execute | Execute test plan via browser automation, record pass/fail results |
| `creating-demo` | `/creating-demo` | — | Create demo PPTX with content outline and browser-verified screenshots |
| `analyzing-logs` | `/analyzing-logs` | Report | Analyze Robot Framework logs, group failures, suggest fixes |
| `tracking-changes` | `/tracking-changes` | Track | Track QA artifact changes in GitHub with full provenance |
| `reviewing-commands` | `/reviewing-commands` | — | Audit slash commands against quality dimensions and best practices |

See [docs/workflows/skills.md](docs/workflows/skills.md) for invocation patterns, trigger phrases, and MCP requirements per skill.

## Available Commands

### [Jira Commands (jr-*)](commands/jira/)
Trace tickets, fetch linked issues, and convert Jira content to Markdown.

`jr-trace` · `jr-trace-fetch` · `jr-trace-structure` · `jr-trace-docs` · `jr-trace-verify` · `jr-issue-summary` · `jr-to-markdown`

### [Confluence Commands (cf-*)](commands/confluence/)
Summarize, convert, create, update, and review Confluence pages.

`cf-page-summary` · `cf-to-markdown` · `cf-create-page` · `cf-update-page` · `cf-review-page` · `cf-format-guide`

### [Test Workflow Commands (tw-*)](commands/test-workflow/)
Plan test strategies and design test cases, with fan-out routing by ticket type (feature/enhance/bugfix).

`tw-plan-init` · `tw-plan-feature` · `tw-plan-enhance` · `tw-plan-bugfix` · `tw-plan-review` · `tw-case-init` · `tw-case-feature` · `tw-case-enhance` · `tw-case-bugfix` · `tw-case-review` · `tw-case-publish` · `tw-case-verify-refs` · `tw-diagrams` · `tw-script-review` · `tw-templates`

### [TestLink Commands (tl-*)](commands/testlink/)
Manage test suites, cases, plans, and execution results in TestLink via MCP.

`tl-list-projects` · `tl-list-suites` · `tl-list-cases` · `tl-list-requirements` · `tl-create-suite` · `tl-create-case` · `tl-get-case` · `tl-get-cases-for-plan` · `tl-update-case` · `tl-update-suite` · `tl-create-plan` · `tl-add-case-to-plan` · `tl-create-execution` · `tl-read-execution` · `tl-execute-case` · `tl-sync` · `tl-identify-type` · `tl-format`

### [GitHub Commands (gh-*)](commands/github/)
Set up milestone/label tracking for QA artifacts and monitor progress through GitHub issues.

`gh-init` · `gh-track` · `gh-status` · `gh-close`

### [Dev Workflow Commands (dw-*)](commands/dev-workflow/)
Issue-driven development lifecycle: plan issues, implement on branches, open PRs, review, and merge.

`dw-story` · `dw-plan` · `dw-implement` · `dw-create-pr` · `dw-review-pr` · `dw-merge`

### [Project Commands (pm-*)](commands/project/)
Cross-cutting project management: bug reports, scrum tasks, meeting invites, and demo materials.

`pm-init` · `pm-bug-report` · `pm-scrum-task` · `pm-meeting-invite` · `pm-demo-content` · `pm-demo-review` · `pm-demo-ppt` · `pm-demo-email`

### [Utility Commands](commands/utility/)
Text rewriting, log analysis, self-improvement, cross-repo sync, and command quality auditing.

`rewrite-text` · `robot-log-analyzer` · `evolve` · `session-summary` · `command-review` · `compare` · `sync`

## Documentation

### Integrations

- [MCP Atlassian](docs/integrations/mcp-atlassian.md) - Jira and Confluence access
- [MCP TestLink](docs/integrations/mcp-testlink.md) - Test management
- [MCP Playwright](docs/integrations/mcp-playwright.md) - Browser automation
- [Test Framework Template](docs/integrations/test-framework-template.md) - Dual-judge execution

### Workflows

- [Agent Skills](docs/workflows/skills.md) - Skills guide: invocation, trigger phrases, MCP requirements
- [Test Lifecycle](docs/workflows/test-lifecycle.md) - Complete end-to-end workflow
- [Trace and Evolve](docs/workflows/trace-and-evolve.md) - GitHub tracking, session summaries, and continuous improvement loop

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
│   ├── dev-workflow/   # Dev lifecycle commands (dw-*)
│   ├── github/         # GitHub tracking commands (gh-*)
│   ├── jira/           # Jira commands (jr-*)
│   ├── project/        # Project management commands (pm-*)
│   ├── testlink/       # TestLink commands (tl-*)
│   ├── test-workflow/  # Test planning and case workflows (tw-*)
│   └── utility/        # Utility commands
├── skills/
│   ├── analyzing-logs/        # Phase 6: Robot Framework log analysis
│   ├── creating-demo/         # Demo PPTX generation
│   ├── designing-cases/       # Phase 3: Write test cases
│   ├── drafting-review-email/ # Phase 3: Stakeholder review email
│   ├── executing-tests/       # Phase 4/6: Browser test execution
│   ├── planning-tests/        # Phase 2: Create test plan
│   ├── receiving-tickets/     # Phase 1: Fetch ticket, create workspace
│   ├── reviewing-commands/    # Command quality auditing
│   ├── syncing-testlink/      # Phase 4: Import cases to TestLink
│   └── tracking-changes/     # GitHub artifact tracking
├── templates/          # Project templates
├── docs/
│   ├── design/         # Design principles
│   ├── examples/       # Sample command outputs
│   ├── integrations/   # MCP integration guides
│   └── workflows/      # End-to-end workflows
├── Makefile            # Legacy installation (deprecated — use agent-driven install via CLAUDE.md)
└── README.md
```

## For Developers

### Adding New Skills

1. Create `skills/<gerund-name>/SKILL.md` with YAML frontmatter (`name`, `description`, `disable-model-invocation`, `tools`)
2. Route each step to an existing slash command — skills should not duplicate command logic
3. Tell your AI agent to re-read `CLAUDE.md` and sync the new skill
4. Commit only the source file under `skills/`

### Adding New Commands

1. Create markdown file in appropriate `commands/` subfolder
2. Follow the standard template (see existing commands)
3. Tell your AI agent to re-read `CLAUDE.md` and sync the new command
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

Pull the latest changes, then tell your AI agent to re-read `CLAUDE.md` — it will compare and sync updates automatically.

## License

MIT
