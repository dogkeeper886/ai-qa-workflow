---
name: setup-agent-workflows
description: |
  Adopts the agent-workflows plugin into a project — writes the profile sections these
  units resolve against, binds the report contract in CLAUDE.md, and finds the forked
  copies of retired commands that silently shadow the placed ones. Use before the first
  run of ship-create-pr, ship-merge, doc-gen-readme or the reviewing skills, when a unit
  stops because it cannot resolve a project value, or when migrating a repo that holds
  `dw-*` / `qw-*` forks.
---

# Setup agent-workflows

**Placement puts the units where an agent loads them. This is the other half — adoption.**
The placed units describe *some* project; this makes them describe *this* one. It runs once
per repo, and again only to change an answer.

Three things, and the third is the one nobody expects to need:

- **Profile values** — the sections these units resolve against, so no unit stops on an
  unresolvable value
- **The report contract binding** — a line in `CLAUDE.md` that holds every session, rather
  than waiting for a skill to invoke itself
- **Fork migration** — the local copies of retired commands that still appear in the menu
  with nothing announcing which one ran

This is prompt-driven, not a script. Explore, present what you found, confirm, then write.

## It writes only what this plugin owns

A project may place several plugins that all read one `project-profile.md`. The rules are
in `profile-doctrine.md` → "More than one plugin writes this file", and they bind here:
own only what you read, add or update in place and never truncate, and treat a value
already there as a decision rather than something to overwrite.

The sections this plugin owns, and nothing else:
**Labels · Linking & branch · Platform · Git · Docs & diagrams · Reports · Review
semantics.** See [profile-sections.md](./profile-sections.md).

If `agent-workflows-runner` is also placed, its sections — `Paths`, `ID schemes`, the test
front-matter contract, the project's binding and run layer — belong to **its** setup unit.
Leave them alone whether they are present or absent, and say at the end that
`setup-agent-runner` covers them.

## Process

### 1. Explore

Read the repo's actual starting state. Don't assume, and don't ask for anything a command
can answer:

- `git remote get-url origin` — which host, so the CLI and change-request noun are derived
  rather than requested. No remote is a real state; note it and don't guess one
- `.claude/rules/project-profile.md` — does it exist? Which sections? Which of **ours** are
  missing, and which are present with values differing from the defaults?
- `CLAUDE.md`, `AGENTS.md` — which exists? Does either already bind the report contract?
  Is there an `## Agent skills` section (written by `setup-matt-pocock-skills`)?
- `docs/agents/triage-labels.md` — if it exists, the triage state name comes from there,
  not from a question
- `.claude/commands/`, `.claude/skills/` — local units. Flag any `dw-*`, `qw-*`,
  `auditing-*`, or a local copy of a name this plugin ships
- `~/.claude/plugins/known_marketplaces.json` — what is actually placed, and from a
  directory or a pinned commit. Also tells you whether the runner is placed
- The project's existing layout — a diagrams directory, a docs tree — so a proposed path
  matches what is there instead of imposing a default

### 2. Present findings and ask

Summarise what is present, what is missing, and what conflicts. Then take the sections in
order — one topic, one answer, then the next.

**Lead each with the recommended answer so it can be accepted in a word.** Explain only
where the choice genuinely branches. Skip a topic entirely when exploration already
settled it — a derived platform is not a question, and neither is a triage label name that
`docs/agents/triage-labels.md` already states.

Worth actually asking about, because the default is a guess and the cost of a wrong one is
real: the **triage state label** (`ship-merge` is its only exit, so a mismatch strands it
on closed work), the **branch-name pattern**, the **merge strategy**, and the **audience**
for human-read docs. The rest have defaults that reproduce this toolkit's behaviour — say
so, and move on.

### 3. Confirm

Show a draft before writing anything:

- the profile sections to add, and any existing value you propose to change
- the `CLAUDE.md` block
- the forks found, and what each one became

Let the user edit. A section you are adding is cheap to correct now and annoying later.

On a refusal, write nothing and report what would have been written — a project that
declines adoption is a state to record, not an error, and the draft is what makes the next
run cheap.

### 4. Write the profile

Create `.claude/rules/project-profile.md` with the doctrine preamble if it is absent.
Otherwise leave the preamble and every foreign section exactly as found, and add or update
only ours.

Seed values and the per-section guidance: [profile-sections.md](./profile-sections.md).

### 5. Bind the report contract

Edit `CLAUDE.md` if it exists; else `AGENTS.md`; if neither, ask which to create rather
than picking. **Never create one when the other is already there.**

Creating one means writing **this section and nothing else**. A project's coding
guidelines are not this plugin's business, and a file arriving full of opinions nobody
asked for is the thing an adopter deletes wholesale — taking the binding with it.

The binding — placed as its own section, adapted to the file's existing numbering:

```markdown
## How to report

Every reply reporting on work — progress, a verdict, a finding, a status — keeps its
parts distinct: what was done, what is suspected, what was skipped on purpose, what is
still uncertain, and what is next. Blending those into one paragraph is the failure this
guards against. The contract is the plugin's `rules/agent-report.md`; the words it uses
are `.claude/rules/project-profile.md` → Reports.

This binds the session rather than waiting for a skill to invoke itself. An agent
producing a muddled report is the least likely thing to notice it is producing one.
```

If that section already exists, update it in place. **Do not touch the `## Agent skills`
section** — another setup unit owns it, and appending a second copy is the failure this
rule exists to prevent.

### 6. Migrate the forks — ask before removing

Skip entirely when exploration found none.

This is the destructive half, so it inherits the discipline `ship-create-pr` uses for
moving commits: **show exactly what would go, touch nothing else, and ask first.**

1. Name each fork and what it became — renamed, deleted-not-renamed, or moved to the
   runner. The mapping is [fork-migration.md](./fork-migration.md).
2. Say the consequences that are not guessable *before* asking. `qw-drift` has no
   replacement at all; removing `qw-*` without the runner placed leaves no QA half rather
   than a renamed one.
3. Ask. On no, leave every fork in place and carry it to the report as unresolved — a
   shadowing fork that the user chose to keep is a decision, not a failure.
4. On yes, remove only the files named in step 1.

A fork of something **deleted rather than renamed** is the one to slow down on: there is no
new name to type, and the replacement is `mattpocock/skills`, which is a separate install.
Removing it from a project that has not placed that set takes the capability away and
leaves nothing behind.

### 7. Report

Per `agent-report`, in the words from `.claude/rules/project-profile.md` → Reports — the
file this run just wrote, so resolve them from it rather than from memory.

**Checked** carries the sections written and the forks removed. **Not done** carries the
foreign sections deliberately left alone. A fork the user kept is **Unresolved**, named,
because it still shadows a placed unit.

**Next** is exactly one step, and it depends on what exploration found:

- runner placed, its sections absent → run `setup-agent-runner`
- forks kept → nothing here; the shadowing is now a known state
- otherwise → the units are ready; name the first one this project will actually use
