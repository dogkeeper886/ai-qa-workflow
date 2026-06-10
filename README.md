# AI QA Workflow

A toolkit of slash commands for AI coding agents: a GitHub-driven development lifecycle (**dev-workflow**) and test-doc authoring (**qa-workflow**), both in `.claude/commands/`.

## Project Goal

Enable **issue-driven development** where every change flows from a GitHub issue through implementation, PR, review, and merge. AI coding agents:

1. **Plan** work as GitHub issues
2. **Implement** on feature branches with story-aware context
3. **Ship** through PRs with automated review and merge

> **Note:** This repo now ships two products — **dev-workflow** (the issue-driven lifecycle below) and **qa-workflow** (test-doc authoring, `qw-*`). Binding test docs to a runner and executing them is the consuming project's own layer.

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

Same flow — tell your agent to re-read `CLAUDE.md`. It compares, detects changes, and syncs updates.

## Two-Tier Architecture

Commands are organized in two tiers to reduce maintenance across multiple projects:

| Tier | Location | Scope | What belongs here |
|------|----------|-------|-------------------|
| **Home** | `~/.claude/commands/` | Every project | Universal commands that work without modification anywhere |
| **Project** | `.claude/commands/`, `.claude/skills/` | One project | Commands needing project-specific MCP servers or paths |

**Home tier** — install once, use everywhere:
- Utility: `evolve`, `session-summary`
- Dev Workflow: `dw-story`, `dw-plan`, `dw-implement`, `dw-create-pr`, `dw-merge`
- QA Workflow: `qw-plan`, `qw-review-plan`, `qw-cases`, `qw-review-cases`

**Project tier** — install per project as needed:
- Governance skills (`auditing-artifacts`, `auditing-readme`)

## Test Lifecycle

The **qa-workflow** commands (`qw-*`) turn a story into trustworthy test docs in `docs/tests/`: `qw-plan` → `qw-cases`, each paired with a review (`qw-review-plan`, `qw-review-cases`). The authoring is self-contained (markdown + GitHub); binding docs to a runner and executing them is the consuming project's layer. See [`.claude/rules/qa-workflow.md`](.claude/rules/qa-workflow.md) and the [test-doc format](docs/tests/README.md).

## Agent Skills

No lifecycle router skills are defined — the workflow logic lives in the `dev-workflow` and `qa-workflow` command groups under `.claude/commands/`.

Governance skills (`auditing-artifacts`, `auditing-readme`) live in `.claude/skills/` as project-local audit helpers.

## Issue-Driven Development

The dev workflow commands (`dw-*`) provide a structured development lifecycle where every change is driven by a GitHub issue.

```
/dw-plan → /dw-implement → /dw-create-pr → /dw-merge
    │            │               │             │
 Create      Branch &        Push & open    Merge PR,
 issues      implement       PR (Fixes #N)  auto-close
 with        on feature      with summary   issue,
 labels      branch          & test plan    clean up
```

```
/dw-plan Add cross-repo sync commands     # Break request into GitHub issues
/dw-implement 27                           # Pick up issue, create branch, implement
/dw-create-pr 27                           # Push branch, open PR linked to issue
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

### [Dev Workflow Commands (dw-*)](.claude/commands/dev-workflow/)
Issue-driven development lifecycle: plan issues, implement on branches, open PRs, review, and merge.

`dw-story` · `dw-plan` · `dw-tasks` · `dw-implement` · `dw-test-design` · `dw-create-pr` · `dw-merge`

### [QA Workflow Commands (qw-*)](.claude/commands/qa-workflow/)
Test-doc authoring: turn a story into trustworthy test docs in `docs/tests/`, each producer paired with a review.

`qw-plan` · `qw-review-plan` · `qw-cases` · `qw-review-cases`

### Utility Commands (home tier)
Self-improvement and session recording. These live at the home tier (`~/.claude/commands/`), not in this repo.

`evolve` · `session-summary`

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
├── .claude/
│   ├── commands/
│   │   ├── dev-workflow/   # Dev lifecycle commands (dw-*)
│   │   └── qa-workflow/    # Test-doc authoring commands (qw-*)
│   ├── skills/             # Governance/review skills
│   └── rules/              # Workflow rules (dev-workflow, qa-workflow)
├── templates/          # Sample CLAUDE.md for projects adopting this workflow
├── docs/
│   ├── design/         # Design principles and patterns
│   ├── integrations/   # MCP integration guides
│   ├── references/     # Command and skill format specs
│   ├── stories/        # User stories (STORY-*)
│   └── tests/          # Test-doc format contract (qa-workflow output)
└── README.md
```

## For Developers

### Adding New Commands

1. Create markdown file in the appropriate `.claude/commands/` subfolder
2. Follow the [command format spec](docs/references/command-format.md) (or use existing commands as examples)
3. Tell your AI agent to re-read `CLAUDE.md` and sync the new command
4. Commit only the source file

### Adding New Skills

1. Create `.claude/skills/<gerund-name>/SKILL.md` with YAML frontmatter (`name`, `description`)
2. Route each step to an existing slash command — skills should not duplicate command logic
3. Tell your AI agent to re-read `CLAUDE.md` and sync the new skill
4. Commit only the source file under `.claude/skills/`

### Updating Commands

Pull the latest changes, then tell your AI agent to re-read `CLAUDE.md` — it will compare and sync updates automatically.

## License

MIT
