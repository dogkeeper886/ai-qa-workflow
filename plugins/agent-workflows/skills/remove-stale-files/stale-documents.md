# Remove list: rules, story files, and the profile

These are documents this toolkit wrote into a project. Each one was true when written and
none of them is read by anything now, which is the shape that costs an agent a wrong answer
rather than no answer.

## `.claude/rules/`

Delete outright. Every unit that cited these now carries what it needs inline.

`agent-report.md` · `anti-slop.md` · `dev-workflow.md` · `doc-workflow.md` ·
`qa-workflow.md` · `ship-tail.md` · `profile-doctrine.md`

**Except:** `agent-report.md` and `qa-workflow.md` where `agent-workflows-runner` is
placed. They are its, not ours. Check `known_marketplaces.json` before deleting either.

## `.claude/rules/project-profile.md`

**Keep the file. Delete this plugin's sections from it.**

| Delete | Leave |
|---|---|
| `Labels`, `Linking & branch`, `Platform`, `Git`, `Docs & diagrams`, `Reports`, `Review semantics` | the preamble, and every section this plugin did not write |

The units resolve none of these any more: each states its own default and says the
project's declaration wins. Where the runner is placed, its sections stay and it keeps
reading them.

If the file holds nothing but our sections, it is empty of meaning; say so and let the user
decide whether the file goes too.

## Story files and agent notes

Delete outright.

`docs/stories/` · `docs/agents/domain.md` · `docs/agents/issue-tracker.md` ·
`docs/agents/triage-labels.md` · `CONTEXT.md`

A story file was a frozen spec that the issue replaced. The agent notes described a triage
and tracker layout the units now derive from the platform at run time.

## `CLAUDE.md` or `AGENTS.md`

Delete the section, not the file.

| Section | Why it goes |
|---|---|
| `## How to report` | It cites `rules/agent-report.md` and `project-profile.md → Reports`, neither of which ships. `reporting-outcomes` carries the contract |
| `## Agent skills` | It points at `docs/agents/`, which this list deletes |

Leave every other section. A project's coding guidelines are not this plugin's business.

## Never

`docs/adr/` and `docs/diagrams/`. ADRs are the project's record of its own decisions, and
diagrams are `gen-readme`'s current output. Neither is stale by being old.
