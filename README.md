# agent-workflows

Slash commands that make an AI coding agent follow an **exact, documented order** — driven by GitHub issues and the story files in the repo. Two workflows ship in the plugin:

- **dev-workflow** (`dw-*`) — turn a need into shipped work through an ordered lifecycle: story → plan → tasks → implement → PR → merge. Each step is paired with a review; nothing skips ahead. The lifecycle is general — it disciplines any ordered action, not just code.
- **qa-workflow** (`qw-*`) — author test **docs** kept *separate* from the test scripts, each mapped to the story it verifies (**test ↔ script ↔ story**). Splitting the doc from the script means coverage isn't silently lost as the code changes across cycles.

![agent-workflows: two workflows — dev-workflow (dw-*) and qa-workflow (qw-*)](docs/diagrams/png/01-two-workflows.png)

## Contents

- [Why two workflows](#why-two-workflows)
- [Installation](#installation)
- [Usage](#usage)
- [Available commands](#available-commands)
- [Skills](#skills)
- [Project structure](#project-structure)
- [The agent family](#the-agent-family)
- [License](#license)

## Why two workflows

**dev-workflow is the discipline.** An agent that follows the order instead of improvising — every change flows from a single GitHub issue (the source of truth), and a human gate sits between each step, so nothing runs ahead of your review.

![dev-workflow pipeline: each producer gated by a paired review, from dw-story to dw-merge](docs/diagrams/png/02-dev-workflow-pipeline.png)

**qa-workflow is the anti-drift layer.** A test is a markdown **doc** (what to verify, mapped to a story); the **script** that runs it lives in the runner repo. The doc records its `story` + `story_hash`, so when the story changes the hash no longer matches and the test is flagged stale — drift is caught instead of quietly accumulating. Authoring is self-contained (markdown + GitHub); executing the scripts is the runner's job — see [the agent family](#the-agent-family).

![qa-workflow anti-drift: the test doc records the story hash; when the story changes the hash mismatches and the test is flagged stale](docs/diagrams/png/05-anti-drift.png)

## Installation

No build step. The toolkit ships as one Claude Code plugin, `agent-workflows`, and this repository is its own marketplace — so you install it once and every project on the machine gets it, at whatever version is placed.

```
/plugin marketplace add dogkeeper886/agent-workflows
/plugin install agent-workflows@agent-workflows
```

Restart your IDE to load the commands. The `dw-*` / `qw-*` commands run on your host's CLI — [`gh`](https://cli.github.com/) for GitHub, [`glab`](https://gitlab.com/gitlab-org/cli) for GitLab, worked out from the repository's git remote — so make sure the one you need is installed and authenticated.

**Then tell each project what it is:** every project that uses the workflows keeps its own `.claude/rules/project-profile.md` — paths, ID schemes, labels, branch/merge conventions, front-matter, platform wording, and review semantics. The commands and skills resolve every project-specific value from it, so you adapt the workflow there instead of editing the units. A project that has not declared one stops and says so rather than quietly borrowing another project's. Start from [this repo's](.claude/rules/project-profile.md).

## Usage

Drive a change from need to merge through the dev-workflow pipeline — each step suggests the next, none auto-runs it:

```
/dw-story    Add cross-repo sync     # capture the need as docs/stories/STORY-XXX.md
/dw-plan     STORY-007               # research → one GitHub plan issue (the approach)
/dw-tasks    STORY-007               # break the plan into task issues
/dw-implement 27                     # branch issue-27-<slug>, implement, commit
/dw-create-pr 27                     # push the branch, open the PR (Closes #27)
/dw-merge    27                      # merge, close the issue, clean up
```

Each producer has a paired review gate — `dw-review-story`, `dw-review-tasks`, `dw-review-implement` — run between the steps above. The full flow lives in [`rules/dev-workflow.md`](plugins/agent-workflows/rules/dev-workflow.md).

The qa-workflow turns a story into test docs the same gated way:

```
/qw-plan         STORY-007           # plan what to test
/qw-review-plan  STORY-007           # gate the plan
/qw-cases        STORY-007           # write the test docs in docs/tests/
/qw-review-cases STORY-007           # gate the docs
```

The full qa lifecycle spans two repos — this repo authors the docs; the runner binds and runs them:

![qa-workflow full lifecycle: authoring in agent-workflows hands off to execution (bind, review-bind, ci-run, drift) in agent-workflows-runner](docs/diagrams/png/03-qa-workflow-pipeline.png)

## Available commands

### [Dev Workflow (`dw-*`)](plugins/agent-workflows/commands/)

Issue-driven lifecycle: capture, plan, implement, review, ship.

`dw-story` · `dw-review-story` · `dw-plan` · `dw-tasks` · `dw-review-tasks` · `dw-implement` · `dw-review-implement` · `dw-create-pr` · `dw-merge`

### [QA Workflow (`qw-*`)](plugins/agent-workflows/commands/)

Test-doc authoring, each producer paired with a review.

`qw-plan` · `qw-review-plan` · `qw-cases` · `qw-review-cases`

## Skills

Skills shipped in the plugin, alongside the commands.

**The review skills (`reviewing-*`)** judge finished work — by judgment, not a scored checklist; a minimum bar, not an exhaustive one. Invoke them by hand.

![Review skills: human-read docs go to reviewing-phrasing (words) + reviewing-typography (look); agent-read tooling goes to reviewing-artifacts](docs/diagrams/png/07-review-skills.png)

**`reporting-outcomes`** shapes the reply an agent writes when it reports back in chat — the turn carrying progress, a verdict, reasons and a status at once. `agent-report.md` binds what a *command* prints at a gate; this puts the same shape on the conversational report-back, which nothing else covers. It fires on its own, not by hand, and states as carefully when it should stay out of the way.

## Project structure

```
agent-workflows/
├── .claude-plugin/
│   └── marketplace.json   # This repo is its own marketplace
├── plugins/agent-workflows/   # The shipped plugin — placed once, reaching every project
│   ├── commands/          # dw-* (dev), qw-* (qa), doc-* (README authoring)
│   ├── skills/            # Review skills (reviewing-*) + reporting-outcomes
│   └── rules/             # Doctrine: the pipelines, the report contract, profile-doctrine
├── .claude/rules/
│   └── project-profile.md # This project's values — the one file adoption touches
├── templates/             # Sample CLAUDE.md for projects adopting these workflows
├── docs/
│   ├── adr/               # Architecture decisions (ADR-*)
│   ├── stories/           # User stories (STORY-*)
│   └── tests/             # qa-workflow test-doc output
├── CLAUDE.md              # Behavioral guidelines + workflow discipline for the agent
└── README.md
```

## The agent family

This repo is the **`agent-workflows`** layer — the commands and the test docs they author. Two sibling repos complete the picture:

![The agent family: agent-workflows authors commands and test docs; agent-workflows-runner executes them; agent-studio wraps both into a product](docs/diagrams/png/09-agent-family.png)

| Repo | Role | Status |
|------|------|--------|
| **agent-workflows** (this repo) | dev-workflow + qa-workflow commands and the test docs they author | — |
| [**agent-workflows-runner**](https://github.com/dogkeeper886/agent-workflows-runner) | executes the test scripts the qa-workflow docs map to — a dual-judge framework (fast checks + opt-in LLM judge) | shipped |
| **agent-studio** | local-first web GUI over the workflows + runner; closes the Dev → QA → PM loop | working name (currently `ai-qa-studio`), planning |

## License

MIT
