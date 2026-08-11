# agent-workflows

Slash commands that make an AI coding agent follow an **exact, documented order** — driven by GitHub issues and the story files in the repo. Two workflows ship in the plugin:

- **dev-workflow** (`dw-*`) — turn a need into shipped work through an ordered lifecycle: story → plan → tasks → implement → PR → merge. Each step is paired with a review; nothing skips ahead. The lifecycle is general — it disciplines any ordered action, not just code.
- **qa-workflow** (`qw-*`) — author test **docs** kept *separate* from the test scripts, each mapped to the story it verifies (**test ↔ script ↔ story**). Splitting the doc from the script means coverage isn't silently lost as the code changes across cycles.

![agent-workflows: two workflows — dev-workflow (dw-*) and qa-workflow (qw-*)](docs/diagrams/png/01-two-workflows.png)

## Contents

- [Why two workflows](#why-two-workflows)
- [Getting started](#getting-started)
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

## Getting started

Two separate things, and only one of them repeats.

### Placement — once, for all projects

The toolkit is a single Claude Code plugin, and this repository is its own marketplace. Nothing to clone, no files to copy, no build step:

```
/plugin marketplace add dogkeeper886/agent-workflows
/plugin install agent-workflows@agent-workflows
```

Restart your IDE and the commands are there. One copy exists, so `/plugin update agent-workflows@agent-workflows` moves every project at once — there is no per-project copy to go stale behind you.

The `dw-*` / `qw-*` commands drive your host's CLI — [`gh`](https://cli.github.com/) for GitHub, [`glab`](https://gitlab.com/gitlab-org/cli) for GitLab — worked out from the repo's git remote. Make sure the one you need is authenticated.

### Adoption — once per project

The placed commands don't know what *your* project is. Each repo says so in one file:

```
mkdir -p .claude/rules && curl -o .claude/rules/project-profile.md \
  https://raw.githubusercontent.com/dogkeeper886/agent-workflows/main/.claude/rules/project-profile.md
```

Then edit it. What it declares:

- where stories and test docs live, and how they're numbered
- label names and colours
- the branch-name pattern and merge strategy
- test-doc front matter and how staleness is detected
- the change-request noun your host uses — `PR` or `MR`
- the verdict words a review reports in

Everything a command would otherwise hardcode resolves from this file — you adapt the workflow here, never the units. The shipped values reproduce this repo's own behaviour, so changing nothing is safe.

This is the one file adoption touches, and it cannot be shared between projects. A repo that declares nothing **stops and says so** — there is deliberately no fallback to a global profile, because a silent one would run another project's conventions with nothing in the session to reveal it.

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

All of them live in [`plugins/agent-workflows/commands/`](plugins/agent-workflows/commands/).

### Dev Workflow (`dw-*`)

Issue-driven lifecycle: capture, plan, implement, review, ship.

`dw-story` · `dw-review-story` · `dw-plan` · `dw-tasks` · `dw-review-tasks` · `dw-implement` · `dw-review-implement` · `dw-create-pr` · `dw-merge`

### QA Workflow (`qw-*`)

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
