# Forked units: what each one became

A project that used this toolkit before it was a plugin holds copies of its units under
`.claude/commands/` or `.claude/skills/`. Those copies still work, still appear in the
menu, and are the reason a migration needs a document at all.

**The trap.** A fork is silently newer or older than what is placed, and nothing surfaces
the conflict. A local `dw-story.md` and the plugin's units coexist under different
namespaces, so both appear and neither announces the other. Nobody is told which one ran.

**Telling them apart while both exist.** Every unit this plugin ships is a skill, so it
answers to a namespaced name as well as a bare one. `/agent-workflows:ship-merge` always
reaches the placed unit; `/ship-merge` reaches a local fork of that name instead, when one
is there. Until the fork is gone, the namespaced form is the only one that says which copy
ran.

## The mapping

**Renamed** — the unit survived under a new name. The fork is redundant; delete it and
type the new name.

| Forked unit | Became |
|---|---|
| `dw-create-pr` | `ship-create-pr` (this plugin) |
| `dw-merge` | `ship-merge` (this plugin) |
| `qw-plan`, `qw-cases`, `qw-review-plan`, `qw-review-cases` | `qa-*` in **`agent-workflows-runner`** — a different plugin, placed separately |
| `auditing-artifacts`, `auditing-readme` | `reviewing-artifacts`, `reviewing-phrasing`, `reviewing-typography` (this plugin) |

**Deleted, not renamed** — this is the distinction easiest to get wrong. Nothing here has
a new name to type. The work moved to `mattpocock/skills`, which is a separate install.

| Forked unit | What replaces it |
|---|---|
| `dw-story` | `/to-spec` — publishes the agreed need as a spec issue |
| `dw-plan`, `dw-tasks` | `/to-tickets` — decomposes it, with blocking edges |
| `dw-implement` | `/implement` |
| `dw-review-story`, `dw-review-tasks`, `dw-review-implement` | `/code-review-2axis` |
| `dw-review-pr` | nothing — the two-axis review and `reviewing-finish` cover it |
| `dw-test-design` | the runner's `qa-*` half |
| `qw-drift` | **nothing.** See the consequence below. |

**Rules** — these ship from the plugins now. A local copy of any of them drifts from the
one the units actually read.

| Forked rule | Ships from |
|---|---|
| `rules/agent-report.md`, `rules/profile-doctrine.md`, `rules/anti-slop.md` | this plugin |
| `rules/ship-tail.md`, `rules/doc-workflow.md` | this plugin |
| `rules/dev-workflow.md` | deleted with the pipeline it described |
| `rules/qa-workflow.md` | `agent-workflows-runner` |

**Keep.** `.claude/rules/project-profile.md` stays in the project — it is the values half
and it is the one file adoption edits. What changed is that its **doctrine preamble** now
ships as `profile-doctrine.md`; a project holding the old combined file should keep its
values and let the preamble shrink to the pointer, or the two drift.

## Consequences a project cannot anticipate

Say these out loud before removing anything — they are the reason this is a conversation
and not a delete loop.

- **`qw-drift` has no replacement.** Removing it orphans the project's drift tooling and
  whatever front-matter anchor that tooling read. If the project depends on drift
  detection, it keeps the fork or rebuilds it as a project-owned unit; nothing in either
  plugin will do it.
- **A local `project-profile.md` may be missing keys the surviving units read**, and may
  still carry the old combined form where the doctrine preamble sat inline. Keep its
  values; let the preamble shrink to the pointer, or the shipped `profile-doctrine.md` and
  the inline copy drift apart with nothing saying which one a unit followed.
- **The runner's units are a separate placement.** Deleting `qw-*` without placing
  `agent-workflows-runner` leaves the project with no QA half at all, not a renamed one.

## Telling what is actually placed

A fork is only redundant if the plugin's copy is really there, and the obvious way to
check is misleading.

`~/.claude/plugins/installed_plugins.json` pins an `installPath` into a cache snapshot
that may be many commits stale — and on a **directory**-source marketplace that snapshot
is not what loads at all. Read `~/.claude/plugins/known_marketplaces.json` first:

- `"source": "directory"` — the working tree at that path is what loads. Read the units
  there; a restart picks up uncommitted edits.
- `"source": "github"` — a snapshot pinned to a commit. `claude plugin update
  <plugin>@<marketplace>` moves it, and the commit is the version; there is no number to
  compare.

Qualify the name with the marketplace when updating — the bare plugin name does not
resolve.
