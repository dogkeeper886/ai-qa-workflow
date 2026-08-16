---
name: remove-stale-files
description: |
  Finds and removes what this plugin's earlier versions wrote into a project: forked
  commands and skills that shadow the placed units, rules and story files nothing reads
  any more, and the sections this plugin wrote into `project-profile.md`. Shows every file
  before touching one, and deletes only on a yes. It never adds: every edit it makes is a
  removal.
when_to_use: |
  Use whenever one of the files below is read, edited, or about to be created. Its
  presence is the trigger; nobody has to ask for a cleanup. In `.claude/commands/`:
  `dw-story`, `dw-plan`, `dw-tasks`, `dw-implement`, `dw-create-pr`, `dw-merge`,
  `dw-review-story`, `dw-review-tasks`, `dw-review-implement`, `dw-review-pr`,
  `dw-test-design`, `qw-plan`, `qw-cases`, `qw-review-plan`, `qw-review-cases`,
  `qw-drift`. In `.claude/skills/`: `auditing-artifacts`, `auditing-readme`,
  `ship-create-pr`, `ship-merge`, `reviewing-finish`, `doc-gen-readme`,
  `doc-review-readme`, and a local copy of any name this plugin ships. In
  `.claude/rules/`: `agent-report.md`, `anti-slop.md`, `dev-workflow.md`,
  `doc-workflow.md`, `qa-workflow.md`, `ship-tail.md`, `profile-doctrine.md`, and the
  sections this plugin wrote into `project-profile.md`. Elsewhere: `docs/stories/`,
  `docs/agents/domain.md`, `docs/agents/issue-tracker.md`, `docs/agents/triage-labels.md`,
  `CONTEXT.md`, and a `## How to report` or `## Agent skills` section in `CLAUDE.md` or
  `AGENTS.md`. Also on request: "clean up .claude", "why are there two ship-merge", "is
  this rule still read", "we retired that workflow, what is left". Not for a file the
  project wrote itself.
---

# Remove stale files

**A stale file is worse than a missing one.** A missing file sends an agent to the code. A
stale one answers, plausibly and wrongly, and nothing marks it as out of date. The cost
lands later, on whoever traces a bad decision back to a document that read as current.

So this unit deletes, and only deletes. Nothing it touches gains a line, which is what
makes it safe to run twice.

## The boundary

**Remove only what this toolkit wrote, or what shadows what it ships.** Everything else is
the project's, and a project's file is reported, never touched.

| Removable | Never |
|---|---|
| A local copy of a name this plugin ships | The project's own commands and skills |
| A unit this plugin shipped and retired | `docs/adr/`, and any document the project authored |
| A rule file this plugin shipped | `agent-workflows-runner`'s rules and profile sections |
| Sections this plugin wrote into `project-profile.md` | Foreign sections in that same file |
| Story files and agent notes this toolkit generated | Anything you cannot trace to this toolkit |

The two lists are [fork-migration.md](./fork-migration.md) for `.claude/commands/` and
`.claude/skills/`, and [stale-documents.md](./stale-documents.md) for the rest.

**When you cannot trace a file, it is the project's.** Say so and move on.

## Process

### 1. Detect

    ls .claude/commands/ .claude/skills/ .claude/rules/ 2>/dev/null
    ls docs/stories/ docs/agents/ 2>/dev/null
    grep -n '^## \(How to report\|Agent skills\)' CLAUDE.md AGENTS.md 2>/dev/null

Then read `~/.claude/plugins/known_marketplaces.json`. A fork is only redundant if the
placed copy is there, and `installed_plugins.json` pins an `installPath` into a
cache snapshot that may be many commits stale. On a `"source": "directory"` marketplace
that snapshot is not what loads at all.

Nothing found is a result. Report `CLEAN` and stop.

### 2. Show, and say the consequence

Name every file, and what replaces it. Say the unguessable parts **before** asking:

- **`qw-drift` has no replacement anywhere.** Removing it ends the project's drift
  detection; nothing in either plugin rebuilds it.
- **The runner is a separate placement.** Deleting `qw-*` where
  `agent-workflows-runner` is not placed leaves no QA half at all, not a renamed one.
- **A retired unit with no successor takes its capability with it.** That is the case to
  slow down on, because there is no new name to type in its place.

### 3. Ask

One question, covering the whole list. On no, remove nothing and report the shadowing as
`KEPT`: a fork the user chose to keep is a decision, not a failure.

### 4. Remove

Only the files named in step 2. In `project-profile.md`, delete this plugin's sections and
leave the file, its preamble, and every foreign section exactly as found.

### 5. Report

`CLEAN` · `REMOVED` · `KEPT` · `FAILED`, in the two lines and a question of
`reporting-outcomes`. `FAILED` is for a removal that errored: a path gone since detection,
a permission refusal, a file git will not drop. Never report the other three over it.

    REMOVED — 6 forks and 3 rule files; project-profile.md kept, foreign sections intact.
    Next: restart the session so the placed units load.
    Want the file list?

## Steps

Copy this checklist and tick each item as you finish it:

    Task Progress:
    - [ ] Detected: commands, skills, rules, docs, the CLAUDE.md sections
    - [ ] Each hit traced to this toolkit, or left alone as the project's
    - [ ] Consequences stated before the question
    - [ ] Asked once, for the whole list
    - [ ] Removed only what was named
    - [ ] Reported: CLEAN, REMOVED, KEPT or FAILED
