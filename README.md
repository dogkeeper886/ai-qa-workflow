# AI QA Workflow

A toolkit of slash commands for AI coding agents, covering a GitHub-driven development lifecycle.

## Project Goal

Enable **issue-driven development** where every change flows from a GitHub issue through implementation, PR, review, and merge. AI coding agents:

1. **Plan** work as GitHub issues
2. **Implement** on feature branches with story-aware context
3. **Ship** through PRs with automated review and merge

> **Note:** The end-to-end QA test workflow (discover → plan → design → manage → execute) is being migrated to a forthcoming `qa-workflow` command group, not yet present in the repo. Test-management integration has moved to a separate repo.

## Notable Features

| Feature | Description |
|---------|-------------|
| **Agent-Driven Installation** | No installer script — the AI agent reads CLAUDE.md, detects context, and syncs commands |
| **Two-Tier Architecture** | Home tier (universal) + project tier (specific) eliminates duplication across projects |
| **Single Source of Truth** | Work flows from GitHub issues through implementation to merge |
| **Issue-Driven Development** | Every change is driven by a GitHub issue, from planning through PR and merge |
| **Detect-and-Route** | Entry commands detect the type of work (new feature / enhancement / bug fix) and hand off to the right specialist command |
| **Agent Skills** | Thin routers covering complete lifecycle phases with progress checklists |
| **Self-Improvement** | `/evolve` analyzes project history and proposes actionable improvements |

## Quick Start

### Installation

Installation is agent-driven — no installer script, no build step. Your AI agent reads `CLAUDE.md` and does the work.

```
git clone https://github.com/dogkeeper886/ai-qa-workflow
```

Then tell your AI agent:

> "Read /path/to/ai-qa-workflow/CLAUDE.md and install the commands I need"

The agent will:
1. Detect your project context and configured MCP servers
2. Recommend relevant modules (e.g., dev-workflow commands for issue-driven development)
3. Ask where to install — home folder or project folder (see [Two-Tier Architecture](#two-tier-architecture))
4. Compare with any existing commands and sync only the differences

### After Installation

**Activate:**

1. Restart your IDE to load new commands
2. Configure MCP integrations (see [docs/integrations/](docs/integrations/))

**What's now available:**

- Individual commands (e.g., `/dw-plan`, `/dw-implement`)

### Updating

Same flow — tell your agent to re-read `CLAUDE.md`. It compares, detects changes, and syncs updates. Use `/compare` to preview drift before syncing.

## Two-Tier Architecture

Commands are organized in two tiers to reduce maintenance across multiple projects:

| Tier | Location | Scope | What belongs here |
|------|----------|-------|-------------------|
| **Home** | `~/.claude/commands/` | Every project | Universal commands that work without modification anywhere |
| **Project** | `.claude/commands/`, `.claude/skills/` | One project | Commands needing project-specific MCP servers or paths |

**Home tier** — install once, use everywhere:
- Utility: `evolve`, `session-summary`, `compare`, `sync`, `review-install`
- Dev Workflow: `dw-story`, `dw-plan`, `dw-implement`, `dw-create-pr`, `dw-review-pr`, `dw-merge`

**Project tier** — install per project as needed:
- Governance skills (`auditing-artifacts`, `auditing-readme`)

### Maintenance Tools

| Command | Purpose |
|---------|---------|
| `/review-install` | Audit your setup — catches duplicates, misplacements, and drift |
| `/compare` | Detect what's out of sync between source repo and installed commands |
| `/sync` | Push updates from source to target |

## Test Lifecycle

> **Note:** The end-to-end QA test workflow (discover → plan → design → manage → execute) is being migrated to a forthcoming `qa-workflow` command group, not yet present in the repo. Test-management integration has moved to a separate repo.

## Agent Skills

Root `skills/` is currently empty — no lifecycle skills are defined in this repo.

Governance skills (`auditing-artifacts`, `auditing-readme`) live in `.claude/skills/` as project-local audit helpers.

## Issue-Driven Development

The dev workflow commands (`dw-*`) provide a structured development lifecycle where every change is driven by a GitHub issue.

```
/dw-plan → /dw-implement → /dw-create-pr → /dw-review-pr → /dw-merge
    │            │               │                │              │
 Create      Branch &        Push & open       Approve or    Merge PR,
 issues      implement       PR (Fixes #N)     request       auto-close
 with        on feature      with summary       changes       issue,
 labels      branch          & test plan                      clean up
```

```
/dw-plan Add cross-repo sync commands     # Break request into GitHub issues
/dw-implement 27                           # Pick up issue, create branch, implement
/dw-create-pr 27                           # Push branch, open PR linked to issue
/dw-review-pr 30                           # Review PR against checklist
/dw-merge 30                               # Merge PR, clean up branch and labels
```

Branches follow `issue-<N>-<short-slug>` convention (e.g., `issue-27-release-notes`). Issues get status labels and progress comments automatically. The PR's `Fixes #N` auto-closes the issue on merge.

## Self-Improvement Loop

The `/evolve` command analyzes project history and proposes improvements to CLAUDE.md, commands, and skills.

```
/evolve                     # Full analysis (issues + commits, last 90 days)
/evolve issues              # Analyze GitHub issues only
/evolve commits             # Analyze git commits only
/evolve --since 30d         # Override time range
```

**How it works:** Collects GitHub issues, git commits, and session summaries → detects workflow gaps, friction points, usage patterns, and knowledge decay → scores each finding by confidence → proposes grouped actions → applies selected changes with confirmation.

**Integration with `/session-summary`:** When session summaries exist, `/evolve` incorporates recurring friction points (3+ occurrences become high-confidence insights) into its analysis. Reports are saved to `docs/evolve/`.

## Available Commands

### [Dev Workflow Commands (dw-*)](commands/dev-workflow/)
Issue-driven development lifecycle: plan issues, implement on branches, open PRs, review, and merge.

`dw-story` · `dw-plan` · `dw-tasks` · `dw-implement` · `dw-test-design` · `dw-create-pr` · `dw-review-pr` · `dw-merge`

### Utility Commands (home tier)
Self-improvement, cross-repo sync, and installation auditing. These live at the home tier (`~/.claude/commands/`), not in this repo.

`evolve` · `session-summary` · `compare` · `sync` · `review-install`

## Documentation

### Integrations

**Optional** — documented but not currently called by any command:

- [MCP Playwright](docs/integrations/mcp-playwright.md) - Browser automation
- [MCP WPA](docs/integrations/mcp-wpa.md) - WPA supplicant control
- [MCP RADIUS SQL](docs/integrations/mcp-radius-sql.md) - RADIUS database queries

**Related framework:**

- [Test Framework Template](docs/integrations/test-framework-template.md) - Dual-judge execution

### Design

- [Principles](docs/design/principles.md) - Core design guidelines

### References

- [Command Format](docs/references/command-format.md) - Slash command format specification
- [Skill Format](docs/references/skill-format.md) - Skill directory and SKILL.md format

## Related Projects

| Project | Purpose | Repository |
|---------|---------|------------|
| **Test Framework Template** | Dual-judge test execution | [dogkeeper886/test-framework-template](https://github.com/dogkeeper886/test-framework-template) |

## Project Structure

```
ai-qa-workflow/
├── commands/
│   └── dev-workflow/   # Dev lifecycle commands (dw-*)
├── templates/          # Sample CLAUDE.md for projects adopting this workflow
├── docs/
│   ├── design/         # Design principles and patterns
│   ├── integrations/   # MCP integration guides
│   └── references/     # Command and skill format specs
└── README.md
```

## For Developers

### Adding New Commands

1. Create markdown file in the appropriate `commands/` subfolder
2. Follow the [command format spec](docs/references/command-format.md) (or use existing commands as examples)
3. Tell your AI agent to re-read `CLAUDE.md` and sync the new command
4. Commit only the source file

### Adding New Skills

1. Create `skills/<gerund-name>/SKILL.md` with YAML frontmatter (`name`, `description`)
2. Route each step to an existing slash command — skills should not duplicate command logic
3. Tell your AI agent to re-read `CLAUDE.md` and sync the new skill
4. Commit only the source file under `skills/`

### Updating Commands

Pull the latest changes, then tell your AI agent to re-read `CLAUDE.md` — it will compare and sync updates automatically. Use `/review-install` to audit across projects.

## License

MIT
