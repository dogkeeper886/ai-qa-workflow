# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

AI QA Workflow provides slash commands for a GitHub-driven development lifecycle (the dev-workflow commands) plus project and utility commands for AI coding agents.

## Git Workflow

- Default: open PR for review before merging
- PRs require review approval before merging
- Delete the feature branch after merging

### Direct Push to Main

Trivial, low-risk changes may be committed and pushed directly to main without a PR:
- Docs-only changes (adding/editing markdown, no code)
- Typo or formatting fixes
- CLAUDE.md or config-only updates

Everything else (code changes, new commands/skills, refactors) requires a feature branch and PR.

### Branch Naming

- General work: `feature/<description>` (e.g. `feature/add-sync-commands`)
- Issue-based work: `issue-<N>-<slug>` (e.g. `issue-27-release-notes`)

### PR Conventions

- Title: short, imperative, under 70 characters
- Body: include `Fixes #N` or `Closes #N` to auto-close the linked issue
- Body: include `## Summary` (1-3 bullet points) and `## Test plan` sections

### Dev Workflow Commands

For structured issue-driven development, use the `dw-*` commands:
1. `/dw-story` — Create structured user story from requirements
2. `/dw-plan` — Break request into GitHub issues with labels
3. `/dw-tasks` — Break an existing story file into GitHub issues
4. `/dw-implement` — Pick up issue, create branch, implement (story-aware)
5. `/dw-test-design` — Design tests for the implementation (detects project test infra)
6. `/dw-create-pr` — Push and open PR with issue linkage (story-aware)
7. `/dw-review-pr` — Review PR against checklist (adapts to CI and project type)
8. `/dw-merge` — Merge PR and clean up (story-aware)

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

## Installation

Installation is agent-driven. When an AI agent reads this file, it should guide the user through installing commands and skills using the compare/sync protocol.

### Agent Installation Flow

1. **Orient** — Read this CLAUDE.md to understand available modules (see Directory Structure and Skills sections)
2. **Detect context** — Examine the user's current working directory:
   - Read its CLAUDE.md (if it exists) to understand the project
   - Check what MCP servers are configured: look in `.claude/settings.local.json`, `mcp.json`, or ask the user
   - Check what's already installed in `.claude/commands/` and `.claude/skills/` (project and home)
   - If no project context is detected (e.g., empty directory), ask the user what they're working on
3. **Ask the user**:
   - Where to install: project folder (`.claude/commands/`) or home folder (`~/.claude/commands/`), or per-module
   - What modules to install: recommend based on context, let user override
4. **Compare & sync** — Read `~/.claude/commands/compare.md` and `~/.claude/commands/sync.md` for the protocol (the utility commands live at the home tier), then:
   - Compare source (`commands/`) with target for each selected module
   - Classify each file: new / identical / diverged / target-only
   - For key changes: prompt user with explanation before applying
   - Adapt project-specific values when installing into a different repo
5. **Report** — Save a summary of what was installed, updated, or skipped

### Module Groups

| Module | Default Target | Reason |
|--------|---------------|--------|
| Utility (evolve, session-summary, compare, sync, review-install) | `~/.claude/commands/` | Universal cross-repo tools, used everywhere |
| Dev Workflow (dw-*) | `~/.claude/commands/` | Generic dev lifecycle |
| Skills | `.claude/skills/` | Project-specific, governance/review |

### Tier Design

Commands and skills are organized in two tiers to reduce maintenance across multiple projects:

| Tier | Location | Scope | What belongs here |
|------|----------|-------|-------------------|
| **Home** | `~/.claude/commands/` | Every project | Universal commands that work without modification in any project |
| **Project** | `.claude/commands/`, `.claude/skills/` | One project | Commands with project-specific paths, tools, or workflow patterns |

**Decision rule:** If a command references no project-specific paths, tools, or patterns → home level. Otherwise → project level.

**Same-name conflict:** Home level wins. A project-level command with the same name as a home command is shadowed (unreachable) and should be removed.

**Audit:** Run `/review-install` to detect duplicates, misplacements, and drift between home, project, and this source repo.

### First-Time Home Setup

When adopting ai-qa-workflow across multiple projects for the first time:

1. **Create `~/.claude/CLAUDE.md`** — Define your identity (roles, project types), universal git workflow rules, information leak prevention rules, and the command hierarchy (what's at home vs project level)
2. **Install home-level commands** — Install the universal commands at `~/.claude/commands/`:
   - Utility (home tier): evolve, session-summary, compare, sync, review-install
   - `commands/dev-workflow/` → dw-story, dw-plan, dw-tasks, dw-implement, dw-test-design, dw-create-pr, dw-review-pr, dw-merge
3. **Audit all projects** — Run `/review-install all` to scan every project for duplicates, misplacements, and drift
4. **Clean up duplicates** — Run `/review-install --fix` per project to remove commands shadowed by home level
5. **Update project CLAUDE.md files** — Remove references to deleted commands, update counts and listings

### Ongoing Maintenance

- **After updating a command in ai-qa-workflow:** copy it to `~/.claude/commands/` and run `/review-install all` to check for drift
- **After adding a new project:** run `/review-install` in that project to verify no duplicates
- **Periodic audit:** run `/review-install all` quarterly to catch drift and info leaks

### Updates

Updates follow the same flow as installation. The agent re-reads this CLAUDE.md (from the latest repo — local or GitHub), compares with what's installed, and syncs changes. Key or breaking changes should prompt the user and save a report.

## Architecture

### Three-Tier Route: CLAUDE.md → Skills → Commands

The agent navigates this project in three layers. Each layer has a specific job and a specific size.

1. **CLAUDE.md (this file) — Orientation.** Read first. Provides the project overview, directory map, Skills table (when to invoke what), and Key Workflows. The agent reads CLAUDE.md to find the right entry point for the user's intent.

2. **Skills (`skills/<name>/SKILL.md`) — Routers.** Loaded on demand when the trigger condition matches. Each skill is a thin step sequence + progress checklist; it orchestrates the workflow and delegates implementation to commands. Skills answer WHAT to do at the workflow level. Typical size: 50-150 lines.

3. **Commands (`commands/<folder>/<cmd>.md`) — Implementation.** Hold the detail: MCP tool names, parameter shapes, HTML formatting rules, API quirks, error handling. Commands answer HOW each step is executed. Size varies by complexity — some are 8 lines, some are 500.

### Why the layering

- **Skills stay lean** because the heavy lifting lives in commands.
- **Commands can be minimal where the task is LLM-native** (e.g., "summarize this page" needs no instructions beyond the tool name) and rich where it's not (e.g., a `dw-implement` command with branch setup, issue linkage, and `gh` calls).
- **CLAUDE.md changes once** when adding a new workflow; skills change per orchestration tweak; commands change per integration detail.

### When to write what

| You're adding... | Touch... |
|------------------|----------|
| A new top-level workflow / lifecycle phase | CLAUDE.md (Skills table, Key Workflows) + new skill + supporting commands |
| A new step in an existing workflow | Existing skill (insert step) + new command (the step's detail) |
| A new way to call an existing integration | New command in the right subfolder; no skill change needed |
| A reusable convention (rules, format guides) | Reference command (rules/conventions) + cross-references from siblings |

### Command-as-Documentation Pattern

Each command markdown file is both documentation and executable instruction. Commands include: purpose, expected input format, step-by-step processing, MCP call details. Skills are installed to `.claude/skills/`; commands are installed to `.claude/commands/` or `~/.claude/commands/` depending on whether they're project-specific or universal (see [Tier Design](#tier-design)).

### Directory Structure

```
commands/
└── dev-workflow/  # Dev lifecycle: story, plan, implement, PR, review, merge (dw-*)
docs/
├── design/        # Design principles
├── integrations/  # MCP server setup guides
└── references/    # Claude Code command and skill format specs
```

### MCP Dependencies

The remaining commands require no MCP servers — the dev-workflow commands use the `gh` CLI. The following MCP integration is configured but no longer used by any command in this repo:
- **playwright-mcp** (microsoft/playwright-mcp) - Browser automation

Additional integrations documented in `docs/integrations/` but not currently used by any command: `wpa-mcp` (WPA supplicant control), `radius-sql` (RADIUS database queries).

## Adding New Commands

1. Create markdown file in appropriate `commands/` subfolder
2. Follow the conventions of sibling commands in the same subfolder. Reference exemplar:
   - **Task commands** (multi-step workflows with `gh`/MCP calls): `commands/dev-workflow/dw-implement.md` — `## PURPOSE`, `## WORKFLOW` (ASCII tree), `## EXAMPLE`, `## API Notes`
3. Tell your AI agent to re-read `CLAUDE.md` and sync the new command
4. Commit only the source file in `commands/`

## Skills

Root `skills/` is currently empty — no lifecycle skills are defined in this repo.

Governance skills live in `.claude/skills/` (`auditing-artifacts`, `auditing-readme`) and are project-local audit helpers rather than lifecycle phases.

## Key Workflows

The end-to-end QA test workflow (discover → plan → design → manage → execute) is being migrated to a forthcoming `qa-workflow` command group, which is not yet present in the repo. Test-management integration has moved to a separate repo.
