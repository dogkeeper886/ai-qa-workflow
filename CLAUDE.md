# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

AI QA Workflow is a QA automation toolkit that connects AI coding agents with test management systems through MCP (Model Context Protocol) integrations. It provides 60 slash commands for end-to-end test automation across Jira, Confluence, TestLink, Playwright, and GitHub.

## Git Workflow

- Never commit directly to main
- Open PR for review before merging
- PRs require review approval before merging
- Delete the feature branch after merging

### Branch Naming

- General work: `feature/<description>` (e.g. `feature/add-sync-commands`)
- Issue-based work: `issue-<N>-<slug>` (e.g. `issue-27-release-notes`)

### PR Conventions

- Title: short, imperative, under 70 characters
- Body: include `Fixes #N` or `Closes #N` to auto-close the linked issue
- Body: include `## Summary` (1-3 bullet points) and `## Test plan` sections

### Dev Workflow Commands

For structured issue-driven development, use the `dw-*` commands:
1. `/dw-plan` — Break request into GitHub issues with labels
2. `/dw-implement` — Pick up issue, create branch, implement
3. `/dw-create-pr` — Push and open PR with issue linkage
4. `/dw-review-pr` — Review PR against checklist
5. `/dw-merge` — Merge PR and clean up

## Information Leak Check

This is an open-source repository. Before committing, verify no private identifiers remain in `commands/` or `demo/`:

All commands must return **no results**. Examples must use only generic placeholders:

| Type | Allowed Pattern | Example |
|------|----------------|---------|
| Jira ticket | `PROJ-NNNNN` | `PROJ-12345` |
| Feature request | `FR-NNNN` | `FR-1234` |
| Confluence page ID | Generic digits | `123456789` |
| Project name | `User Session Management` / `USM` | |
| Product name | `Cloud management platform` | |

## Build and Installation

```bash
make install           # Install commands + skills to Claude Code
make install-claude    # Claude Code only (~/.claude/commands/)
make install-skills    # Skills to Claude Code only (~/.claude/skills/)
make uninstall         # Remove installed commands
make uninstall-skills  # Remove installed skills
```

After installation, restart the IDE to load commands.

## Architecture

### Command-as-Documentation Pattern

Each command is a markdown file in `commands/` that serves as both documentation and executable instruction for AI agents. Commands include:
- Purpose and expected input format
- Step-by-step agent processing instructions
- HTML formatting rules (for TestLink)
- API call details and best practices

Commands are installed by copying markdown files to `~/.claude/commands/`. Skills are thin routers that delegate to slash commands — each SKILL.md contains only the step sequence and progress checklist, routing to commands for implementation details.

### Directory Structure

```
commands/
├── confluence/    # Confluence page operations (6 commands, cf-*)
├── dev-workflow/  # Dev lifecycle: plan, implement, PR, review, merge (5 commands, dw-*)
├── github/        # GitHub tracking and traceability (4 commands, gh-*)
├── jira/          # Jira ticket tracing and conversion (7 commands, jr-*)
├── project/       # Project management commands (8 commands, pm-*)
├── testlink/      # TestLink CRUD and execution (18 commands, tl-*)
├── test-workflow/ # Test planning and case workflows (15 commands, tw-*)
└── utility/       # Text rewriting, log analysis, self-improvement, cross-repo sync (7 commands)
skills/
├── receiving-tickets/    # Fetch Jira ticket + set up project workspace
├── planning-tests/       # Create test plan from ticket, publish to Confluence
├── designing-cases/      # Write test cases from plan, publish to Confluence
├── drafting-review-email/ # Draft stakeholder review email + meeting invite
├── syncing-testlink/     # Import test cases into TestLink, build test plan
├── executing-tests/      # Execute TestLink plan via browser automation
├── creating-demo/        # Create PPTX demo with browser-verified screenshots
├── analyzing-logs/       # Analyze Robot Framework logs, report failures
├── tracking-changes/     # Track QA artifact changes in GitHub
└── reviewing-commands/   # Audit command quality against best practices
docs/
├── integrations/  # MCP server setup guides
├── references/    # Claude Code command and skill format specs
├── workflows/     # End-to-end test lifecycle guide
└── design/        # Design principles
```

### MCP Dependencies

Commands expect these MCP servers configured in the IDE:
- **mcp-atlassian** (sooperset/mcp-atlassian) - Jira/Confluence API access
- **testlink-mcp** (dogkeeper886/testlink-mcp) - TestLink API access
- **playwright-mcp** (microsoft/playwright-mcp) - Browser automation
- **wpa-mcp** (dogkeeper886/wpa-mcp) - WPA supplicant control
- **radius-sql** (dogkeeper886/ldap) - RADIUS database queries

## Adding New Commands

1. Create markdown file in appropriate `commands/` subfolder
2. Follow this template structure:
   ```markdown
   # Command Name

   ## Purpose
   One-sentence description

   ## Agent Instructions:
   1. Step-by-step processing guidance
   
   ## Expected User Input Format:
   What parameters the user should provide
   
   ## Example Usage:
   Concrete examples with agent processing steps
   
   ## API Notes:
   MCP tool calls and quirks
   ```
3. Run `make install` to deploy
4. Commit only the source file in `commands/`

## Skills

Skills are loaded on demand. The agent reads this table to decide which skill to invoke.

| Skill | Trigger Condition |
|-------|-------------------|
| `receiving-tickets` | When given a Jira ticket ID to investigate or start a new QA project |
| `planning-tests` | When requirements are gathered and a test plan is needed |
| `designing-cases` | When a test plan exists and detailed test cases need to be written |
| `drafting-review-email` | When test artifacts are ready for stakeholder review |
| `syncing-testlink` | When test cases need to be imported into TestLink |
| `executing-tests` | When a TestLink test plan is ready for browser-based execution |
| `creating-demo` | When a demo presentation needs to be created from test results |
| `analyzing-logs` | When Robot Framework logs need failure analysis |
| `tracking-changes` | When QA artifacts are created, modified, or reviewed — track in GitHub |
| `reviewing-commands` | When command files need quality auditing against best practices |

Skills are thin routers — each SKILL.md contains the step sequence and progress checklist, delegating to commands for implementation details. Do not load all skills at once; load only when the trigger condition matches.

## Key Workflows

The test lifecycle flows through 6 phases:
1. **Discover** - Gather requirements via `/jr-trace`
2. **Plan** - Create test strategy via `/tw-plan-init` (routes to feature/enhance/bugfix)
3. **Design** - Write test cases via `/tw-case-init` (routes to feature/enhance/bugfix)
4. **Manage** - Import to TestLink via `/tl-create-case`
5. **Automate** - Create YAML tests with test-framework-template
6. **Execute** - Run tests and record via `/tl-create-execution`

## TestLink HTML Formatting

TestLink commands automatically apply HTML formatting:
- Summaries: `<p>` tags with `<strong>` for emphasis
- Preconditions: `<ul><li>` lists
- Steps: `<p>` for actions, `<br>•` or `<ul><li>` for expected results
- HTML entities: `&gt;`, `&lt;`, `&quot;`, `&amp;`, `&apos;`
