# agent-workflows

**The layer wrapped around [`mattpocock/skills`](https://github.com/mattpocock/skills).** His set carries an idea to a commit — `/grill-with-docs`, `/to-spec`, `/to-tickets`, `/implement`, `/code-review-2axis` — and stops there. This plugin does the two things his set leaves undone: it kills the slop in what the agent writes, and it carries a commit the rest of the way to merged.

These two are **complements, not alternatives**. Install both.

![One pipeline, two halves: mattpocock/skills carries idea to commit; agent-workflows carries commit to merged, and kills agent slop with the reviewing-* skills, the report contract, and the doc-workflow README gate](docs/diagrams/png/01-the-complement.png)

## Contents

- [What this adds](#what-this-adds)
- [Getting started](#getting-started)
- [Usage](#usage)
- [What ships](#what-ships)
- [Project structure](#project-structure)
- [The agent family](#the-agent-family)
- [License](#license)

## What this adds

**Killing agent slop.** An agent writes prose that is fluent, shaped like the real thing, and carrying less than it appears to. His set generates documents; none of his skills judges one that already exists. The `reviewing-*` skills do — the words of a doc, its look, the commands and rules an agent reads, and the debris a committed change left in the codebase. `doc-gen-readme` / `doc-review-readme` are a README author and its accuracy gate — the gate leans on those same skills, then checks the claims against the code.

The same discipline covers what the agent says back to you. A reply that blends what was done, what is suspected, what was skipped on purpose and what is still uncertain into one paragraph is unreadable at exactly the moment it matters. `rules/agent-report.md` keeps those parts distinct — bound from your project's `CLAUDE.md`, so it holds even when the agent is the one producing the mess.

**Convenience at the seam** — the stretch between a commit and a merge. His chain stops just short of it: `/implement` ends at *"commit your work to the current branch"*, nothing pushes or opens a change request, no feature branch was ever cut, and `/triage` leaves a `ready-for-agent` state nothing upstream clears. `ship-create-pr` moves those commits onto a branch if they landed on the default, pushes, and opens the PR linked to its issue. `ship-merge` merges, clears both labels — that triage state included — deletes the branch, and puts you back on the default. Each stops for a human rather than running on into the next.

`reviewing-finish` spans both jobs. `/code-review-2axis` reads the diff but cannot run your build; this runs the project's own tooling, so "verified" means observed rather than asserted, and it removes the imports and files *your* change orphaned. Run it **after** the two-axis review, never instead of it.

Looking for the QA half — planning what to test, writing the test docs, binding them to what runs? That lives in [`agent-workflows-runner`](https://github.com/dogkeeper886/agent-workflows-runner), which owns authoring and execution together.

## Getting started

Two separate things, and only one of them repeats.

### Placement — once, for all projects

Both plugins. This one is its own marketplace; nothing to clone, no build step:

```
/plugin marketplace add dogkeeper886/agent-workflows
/plugin install agent-workflows@agent-workflows
```

Then install [`mattpocock/skills`](https://github.com/mattpocock/skills) for the front half, following its own instructions. Restart your IDE and both sets are there. `/plugin update agent-workflows@agent-workflows` moves every project at once — there is no per-project copy to go stale behind you.

The commands drive your host's CLI — [`gh`](https://cli.github.com/) for GitHub, [`glab`](https://gitlab.com/gitlab-org/cli) for GitLab — worked out from the repo's git remote. Make sure the one you need is authenticated.

### Adoption — once per project

The placed units don't know what *your* project is. One skill asks and writes it down:

```
setup-agent-workflows
```

It derives what it can from your git remote, asks about the few values a default would get wrong, and writes `.claude/rules/project-profile.md` — the label names (including the triage state `ship-merge` clears), the branch pattern, the merge strategy, where diagrams live, the verdict words a review reports in, and the audience it judges jargon against. It also binds the report contract in your `CLAUDE.md`, and finds the forked copies of retired commands that still sit in `.claude/commands/` shadowing the placed ones.

Everything a unit would otherwise hardcode resolves from that file — you adapt the workflow there, never the units. The values it writes reproduce this repo's own behaviour, so accepting all of them is safe.

A repo that declares nothing **stops and says so**. There is deliberately no fallback to a global profile: a silent one would run another project's conventions with nothing in the session to reveal it. Running the setup skill is what stops that being your first experience of the plugin.

Installing [`agent-workflows-runner`](https://github.com/dogkeeper886/agent-workflows-runner) too? It reads its own sections of the same file and has its own `setup-agent-runner`. Each writes only what it reads, in either order — neither overwrites the other.

Starting a repo with no `CLAUDE.md` at all? The skill writes the one section this plugin needs and stops there — your coding guidelines aren't its business. [`templates/CLAUDE.md`](templates/CLAUDE.md) is this repo's own, if you want a fuller starting point.

## Usage

Drive a change from idea to merged. The first five steps are Matt's; the last three are this plugin's:

```
/grill-with-docs   Add cross-repo sync   # interview the idea until it holds up
/to-spec                                 # publish the agreed need as a spec issue
/to-tickets                              # decompose it, with blocking edges declared
/implement         27                    # build it, ending at a commit
/code-review-2axis                       # the diff, against standards and spec
                                         # ── the handoff ──
reviewing-finish                         # run the tooling; clear leftovers and orphans
/ship-create-pr    27                    # push, open the PR, link it (Fixes #27)
                                         # ── a human reviews and tests ──
/ship-merge        30                    # merge, clear the labels, delete the branch
```

## What ships

Every unit is a skill under
[`plugins/agent-workflows/skills/`](plugins/agent-workflows/skills/), and its `/` name is
its directory name. Arriving in a plugin also gives each one a namespaced form —
`/agent-workflows:ship-merge` — and the bare `/ship-merge` works unless something else in
your setup already claims that name. All are invoked by hand.

**The pipelines**, run in order, each step stopping for a human:

| Group | Units | Job |
|-------|-------|-----|
| **Ship tail** | `ship-create-pr` · `ship-merge` | commit → merged, with the branch and labels cleaned up |
| **Doc workflow** | `doc-gen-readme` · `doc-review-readme` | a codebase → its README, and the accuracy gate |

**The rest**, reached when you need them:

| Skill | What it's aimed at |
|-------|--------------------|
| `setup-agent-workflows` | adopting this plugin into a project — run once, first |
| `reviewing-phrasing` | the words of a human-read doc |
| `reviewing-typography` | its look — hierarchy, grouping, emphasis, density |
| `reviewing-artifacts` | agent-read tooling — commands, skills, rules, `CLAUDE.md` |
| `reviewing-finish` | a committed change, before it becomes a change request |
| `reporting-outcomes` | the reply an agent writes when it reports back in chat |

`reviewing-phrasing`, `reviewing-typography` and `reviewing-artifacts` route by **who reads the file you changed**:

![Review skills: human-read docs go to reviewing-phrasing (words) + reviewing-typography (look); agent-read tooling goes to reviewing-artifacts](docs/diagrams/png/07-review-skills.png)

The `reviewing-*` skills judge finished work rather than score it — a minimum bar, not an exhaustive checklist — and each ends in a verdict that routes somewhere.

The other two review nothing. `reporting-outcomes` shapes a chat turn rather than a file — `agent-report.md` binds what a unit prints at a gate, and this puts the same shape on the conversational report-back. `setup-agent-workflows` runs once per repo, before any of the rest: it writes the profile they all resolve against.

## Project structure

```
agent-workflows/
├── .claude-plugin/
│   └── marketplace.json   # This repo is its own marketplace
├── plugins/agent-workflows/   # The shipped plugin — placed once, reaching every project
│   ├── skills/            # Every unit: ship-* (ship tail), doc-* (README authoring),
│   │                      #   setup-agent-workflows, reviewing-*, reporting-outcomes
│   └── rules/             # Doctrine: the pipelines, the report contract, anti-slop, profile-doctrine
├── .claude/rules/
│   └── project-profile.md # This project's values — the one file adoption touches
├── templates/             # CLAUDE.md for projects adopting these workflows
├── docs/
│   ├── adr/               # Architecture decisions (ADR-*)
│   └── stories/           # Historical story records (no command writes these now)
├── CLAUDE.md              # Behavioral guidelines + workflow discipline for the agent
└── README.md
```

## The agent family

This repo is the **`agent-workflows`** layer. Two sibling repos complete the picture:

![The agent family: agent-workflows authors the commands and review skills; agent-workflows-runner owns the test docs and runs them; agent-studio wraps both into a product](docs/diagrams/png/09-agent-family.png)

| Repo | Role | Status |
|------|------|--------|
| **agent-workflows** (this repo) | the ship tail, the review skills, and the doc workflow | — |
| [**agent-workflows-runner**](https://github.com/dogkeeper886/agent-workflows-runner) | the whole QA half — planning what to test, writing the test docs, binding them, and running them under a dual judge (fast checks + opt-in LLM judge) | shipped |
| **agent-studio** | local-first web GUI over the workflows + runner; closes the Dev → QA → PM loop | working name (currently `ai-qa-studio`), planning |

## License

MIT
