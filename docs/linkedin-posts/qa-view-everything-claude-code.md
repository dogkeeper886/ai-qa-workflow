# I Let an AI Code Agent Analyze the 35.6k-Star "Everything Claude Code" Repo

An open-source repository containing production-ready Claude Code configurations — agents, skills, hooks, commands, rules, and MCP setups. Won the Anthropic x Forum Ventures hackathon (NYC). Built over 10+ months of daily use. 35.6k GitHub stars.

**Repo:** github.com/affaan-m/everything-claude-code

Today I asked my AI code agent to break down the architecture, test strategy, and GitHub workflows of this repo.

## Architecture

Six layers. Each has a distinct role.

```
┌─────────────────────────────────────────────┐
│  User Input (natural language or /command)   │
└──────────────────────┬──────────────────────┘
                       ▼
┌─────────────────────────────────────────────┐
│  Commands (/plan, /tdd, /e2e, /verify ...)  │
│  Entry point. Routes to the right agent.    │
└──────────────────────┬──────────────────────┘
                       ▼
┌─────────────────────────────────────────────┐
│  Agents (planner, tdd-guide, e2e-runner,    │
│  code-reviewer, security-reviewer ...)      │
│  Specialized workers. Execute the task.     │
└──────────┬───────────────────────┬──────────┘
           ▼                       ▼
┌────────────────────┐  ┌────────────────────┐
│  Skills            │  │  Rules             │
│  Domain knowledge. │  │  Always-on guard   │
│  Agents read these │  │  rails. Security,  │
│  to know HOW.      │  │  style, coverage.  │
└────────────────────┘  └────────────────────┘
           │                       │
           └───────────┬───────────┘
                       ▼
┌─────────────────────────────────────────────┐
│  MCPs (GitHub, Supabase, Playwright ...)    │
│  External tool connections for real actions. │
└──────────────────────┬──────────────────────┘
                       ▼
┌─────────────────────────────────────────────┐
│  Hooks (pre-tool, post-tool, session)       │
│  Event-driven automation.                   │
│  Validate → Persist → Learn patterns.       │
└─────────────────────────────────────────────┘
```

## Task → Test Pipeline

How a task becomes tested code:

```
Describe task (natural language)
       │
       ▼
  /plan ──→ Planner agent breaks into subtasks
       │     with acceptance criteria
       ▼
  /tdd ──→ TDD-guide writes FAILING test first
       │     RED → GREEN → REFACTOR
       ▼
  /e2e ──→ E2E-runner creates Playwright
       │     browser journey tests
       ▼
  /code-review ──→ Code reviewer checks quality
       │
       ▼
  /security-scan ──→ Security reviewer checks OWASP
       │
       ▼
  /verify ──→ Final gate. All tests pass → merge.
```

## Test Framework Stack

| Layer | Framework | Gate |
|-------|-----------|------|
| Unit | Jest or Vitest | 80% coverage minimum |
| Component | React Testing Library | BDD-style assertions |
| E2E | Playwright | Screenshots, video, traces |
| Security | OWASP checklist + AgentShield | 102 static analysis rules |
| Go | `go test` | Language-specific agent |
| Python | `pytest` | Language-specific agent |

## GitHub Workflows (.github/workflows/)

7 workflow files. 3 trigger types: code change, scheduled, manual.

### CI Pipeline — Every PR Gets the Full Gate

4 parallel jobs on every push to main or PR. Tests run across 33 OS × Node × package-manager combinations. Validation checks every component type. Security audit reports but doesn't block. Markdown is linted as product code.

```
┌─────────────────────────────────────────────────────────────────┐
│  ci.yml  (trigger: push to main / PR)                          │
│  Concurrency: cancel duplicate runs per ref                    │
│  Permissions: read-only                                        │
└──┬──────────────┬──────────────────┬──────────────┬────────────┘
   │              │                  │              │
   ▼              ▼                  ▼              ▼
┌────────┐  ┌──────────┐  ┌──────────────┐  ┌──────────┐
│  test  │  │ validate │  │   security   │  │   lint   │
└───┬────┘  └────┬─────┘  └──────┬───────┘  └────┬─────┘
    │            │               │               │
    ▼            ▼               ▼               ▼
┌─────────────────────────────────────────────────────────────────┐
│  test ──→ reusable-test.yml                                     │
│                                                                 │
│  ┌─────────┐   ┌─────────┐   ┌─────────┐                       │
│  │ ubuntu  │   │ windows │   │  macos  │   ← 3 OS              │
│  └─────────┘   └─────────┘   └─────────┘                       │
│       ×                                                         │
│  ┌─────────┐   ┌─────────┐   ┌─────────┐                       │
│  │  18.x   │   │  20.x   │   │  22.x   │   ← 3 Node versions  │
│  └─────────┘   └─────────┘   └─────────┘                       │
│       ×                                                         │
│  ┌─────────┐   ┌─────────┐   ┌─────────┐   ┌─────────┐        │
│  │   npm   │   │  pnpm   │   │  yarn   │   │   bun   │  ← 4pm │
│  └─────────┘   └─────────┘   └─────────┘   └─────────┘        │
│                                                                 │
│  Excludes: bun + windows                                        │
│  Total combinations: 33  (3×3×4 − 3 excluded)                  │
│  fail-fast: false     timeout: 10min                            │
│  Artifacts uploaded on failure                                  │
└─────────────────────────────────────────────────────────────────┘
┌─────────────────────────────────────────────────────────────────┐
│  validate ──→ reusable-validate.yml                             │
│                                                                 │
│  ┌──────────────────┐  ┌──────────────────┐                     │
│  │ validate-agents  │  │ validate-hooks   │                     │
│  └──────────────────┘  └──────────────────┘                     │
│  ┌──────────────────┐  ┌──────────────────┐                     │
│  │validate-commands │  │ validate-skills  │                     │
│  └──────────────────┘  └──────────────────┘                     │
│  ┌──────────────────┐                                           │
│  │ validate-rules   │  All must pass (continue-on-error: false) │
│  └──────────────────┘                                           │
└─────────────────────────────────────────────────────────────────┘
┌─────────────────────────────────────────────────────────────────┐
│  security                                                       │
│  npm audit --audit-level=high                                   │
│  Non-blocking (continue-on-error: true)                         │
└─────────────────────────────────────────────────────────────────┘
┌─────────────────────────────────────────────────────────────────┐
│  lint                                                           │
│  ESLint ──→ scripts/**/*.js, tests/**/*.js                      │
│  markdownlint ──→ agents/, skills/, commands/, rules/ (*.md)    │
└─────────────────────────────────────────────────────────────────┘
```

### Release Pipeline — Tag It, Ship It

When a version tag is pushed, the workflow validates the semver format, cross-checks it against `plugin.json`, generates a changelog, and creates a GitHub Release. Tag and code must agree.

```
┌─────────────────────────────────────────────────────────────────┐
│  release.yml  (trigger: tag push v*)                            │
│  ──→ reusable-release.yml                                       │
│                                                                 │
│  Validate semver format ──→ Cross-check plugin.json version     │
│  ──→ Generate changelog from git log ──→ Create GitHub Release  │
└─────────────────────────────────────────────────────────────────┘
```

### Maintenance — Catching Decay Before It Catches You

A weekly job checks for outdated dependencies, scans for vulnerabilities, and closes stale issues. Not triggered by code changes — because software decays even when nobody touches it.

```
┌─────────────────────────────────────────────────────────────────┐
│  maintenance.yml  (trigger: weekly, Mon 9AM UTC)                │
│                                                                 │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────────────┐   │
│  │ npm outdated │  │  npm audit   │  │ stale issue cleanup  │   │
│  │ (dep check)  │  │ (vuln scan)  │  │ (30d flag, 7d close) │   │
│  └──────────────┘  └──────────────┘  └──────────────────────┘   │
└─────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────┐
│  copilot-setup-steps.yml  (trigger: manual)                     │
│  Node 20 + npm ci + verify environment                          │
└─────────────────────────────────────────────────────────────────┘
```

## Continuous Learning — The System That Teaches Itself

Most AI coding setups are static. Configure once, run forever. This repo has a self-improving loop built on three stages.

**Observe.** Hooks on every tool call silently log what you do — every edit, every command, every file read. Fires 100% of the time, scoped per project.

**Learn.** A background agent reads observations and detects patterns: user corrections, repeated workflows, error resolutions. Each pattern becomes an "instinct" — a small behavior with a confidence score (0.3 tentative → 0.9 near-certain). Confidence rises when the pattern repeats, drops when the user corrects it.

**Evolve.** `/evolve` clusters related instincts and promotes them into new capabilities. Three instincts about database tables become a `/new-table` command. Three about functional style become a `functional-patterns` skill. Four about debugging steps become a `debugger` agent.

Project-scoped by default — React patterns stay in React, Python conventions stay in Python. When the same instinct appears across 2+ projects with high confidence, it auto-promotes to global.

```
Session work → Hooks capture every tool call
                      │
                      ▼
              Observations (per project)
                      │
                      ▼
              Background agent detects patterns
                      │
                      ▼
              Instincts (confidence-scored)
                      │
                      ▼
              /evolve clusters into Commands, Skills, or Agents
                      │
                      ▼
              Agents read new capabilities → better output next session
```

## Closing Thoughts

What impressed me most: the command and skill system breaks a plan into tasks, then drives each task into a test. `/plan` → subtasks with acceptance criteria → `/tdd` → failing test → code → pass. The test is born from the plan, not written after the fact.

The GitHub Actions setup backs this up. `ci.yml` alone runs 33 matrix combinations, validates every component's structure, scans for vulnerabilities, and lints both code and documentation — all on every PR.

This repo is clearly well-structured development. But it leads me to a question: how do they manage test cases and documentation over time?
