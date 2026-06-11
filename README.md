# agent-workflows

Slash commands that make an AI coding agent follow an **exact, documented order** — driven by GitHub issues and a repo's file structure. Two workflows live in `.claude/commands/`:

- **dev-workflow** (`dw-*`) — turn a need into shipped work through an ordered lifecycle: story → plan → tasks → implement → PR → merge. Each step is paired with a review; nothing skips ahead. The lifecycle is general — it disciplines any ordered action, not just code.
- **qa-workflow** (`qw-*`) — author test **docs** kept *separate* from the test scripts, each mapped to the story it verifies (test ↔ script ↔ story). Splitting the doc from the script means coverage isn't silently lost as the code changes across cycles.

## Why two workflows

**dev-workflow is the discipline.** An agent that follows the order instead of improvising. Every change flows from a GitHub issue through implementation, review, PR, and merge — the issue is the single source of truth, and each producer (`dw-story`, `dw-plan`, `dw-tasks`, `dw-implement`) is paired with a review so nothing ships ungated.

**qa-workflow is the anti-drift layer.** A test is a markdown **doc** (what to verify, mapped to a story); the **script** that runs it lives in the runner repo. The doc records a `story` + `story_hash`, so when the story changes the hash no longer matches and the test is flagged stale — drift is caught instead of quietly accumulating. Authoring is self-contained (markdown + GitHub); executing the scripts is the runner's job — see the [agent-* family](#the-agent-family) below.

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
git clone https://github.com/dogkeeper886/agent-workflows
```

Then tell your AI agent:

> "Read /path/to/agent-workflows/CLAUDE.md and install the commands I need"

The agent will:
1. Detect your project context and configured MCP servers
2. Recommend relevant modules (e.g., dev-workflow commands for issue-driven development)
3. Ask where to install — home folder or project folder (see [Two-Tier Architecture](#two-tier-architecture))
4. Compare with any existing commands and sync only the differences

### After Installation

**Activate:**

1. Restart your IDE to load new commands
2. (Optional) Wire up MCP servers to extend what your agents can do (see [docs/integrations/](docs/integrations/))

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

### Optional MCP servers

The workflows themselves need no MCP servers — they run on the `gh` CLI. These are **optional**: wire any of them up to extend what your agents can *do* (drive a browser, control WiFi, query a database, work a Jira ticket). The first three ship a full config cheat-sheet; the rest link to their own repos for setup.

| Server | Wire an agent to… | Setup |
|--------|-------------------|-------|
| **Playwright** | drive a browser for end-to-end web testing | [cheat-sheet](docs/integrations/mcp-playwright.md) |
| **wpa-mcp** | control WiFi via `wpa_supplicant` | [cheat-sheet](docs/integrations/mcp-wpa.md) |
| **RADIUS SQL** | query RADIUS auth/accounting records | [cheat-sheet](docs/integrations/mcp-radius-sql.md) |
| **ai-qa-step-graph** | reuse test steps semantically from a pgvector step-store | [repo](https://github.com/dogkeeper886/ai-qa-step-graph) |
| **android-wifi-mcp** | control WiFi on Android devices via ADB | [repo](https://github.com/dogkeeper886/android-wifi-mcp) |
| **testlink-mcp** | read/write cases in [TestLink](https://github.com/dogkeeper886/testlink-code) | [repo](https://github.com/dogkeeper886/testlink-mcp) |
| **Atlassian Rovo MCP** | work Jira / Confluence from the agent | [docs](https://www.atlassian.com/platform/remote-mcp-server) |

### Related framework

- [Test Framework Template](docs/integrations/test-framework-template.md) — dual-judge execution; the runner that executes qa-workflow's test scripts

### Design

- [Principles](docs/design/principles.md) - Core design guidelines

### References

- [Command Format](docs/references/command-format.md) - Slash command format specification
- [Skill Format](docs/references/skill-format.md) - Skill directory and SKILL.md format

## The agent family

This repo is the **`agent-workflows`** layer — the commands and the test docs they author. Two sibling repos complete the picture:

```
agent-workflows   →   agent-workflows-runner   →   agent-studio
 (this repo)            (executes the scripts)        (product layer)
 commands +             the qa-workflow docs          over the workflows
 test docs              map test → script             + runner
```

| Repo | Role | Status |
|------|------|--------|
| **agent-workflows** (this repo) | dev-workflow + qa-workflow commands and the test docs they author | — |
| **agent-workflows-runner** | executes the test scripts the qa-workflow docs map to | rename planned ([test-framework-template](https://github.com/dogkeeper886/test-framework-template)) |
| **agent-studio** | product layer over the workflows + runner | rename planned (currently `ai-qa-studio`) |

## Project Structure

```
agent-workflows/
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
