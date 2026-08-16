# Remove list: `.claude/commands/` and `.claude/skills/`

A fork is a local copy of a unit this plugin ships or shipped. Both appear in the menu,
under different namespaces, and nothing announces which one ran.

`/agent-workflows:land-pr` always reaches the placed unit. `/land-pr` reaches the fork
when one exists. Until the fork is gone, the namespaced form is the only one that says
which copy ran.

## Renamed: delete the fork, type the new name

| Fork | Placed unit |
|---|---|
| `dw-create-pr`, `ship-create-pr` | `open-pr` |
| `dw-merge`, `ship-merge` | `land-pr` |
| `reviewing-finish` | `review-work` |
| `doc-gen-readme` | `gen-readme` |
| `doc-review-readme` | `review-readme` |
| `auditing-artifacts` | `reviewing-artifacts` |
| `auditing-readme` | `reviewing-phrasing`, `reviewing-typography` |
| `qw-plan`, `qw-cases`, `qw-review-plan`, `qw-review-cases` | `qa-*` in `agent-workflows-runner`, **placed separately** |

## Shadowing: delete the fork, the placed one is the same job

A local copy of any name this plugin ships now: `file-issue`, `take-issue`, `do-task`,
`review-work`, `open-pr`, `land-pr`, `plan-work`, `gen-readme`, `review-readme`,
`reviewing-artifacts`, `reviewing-phrasing`, `reviewing-typography`,
`reporting-outcomes`, `remove-stale-files`.

## Retired: nothing replaces these

Delete only after saying so. There is no new name to type.

| Fork | What it leaves behind |
|---|---|
| `dw-story`, `dw-plan`, `dw-tasks`, `dw-implement` | nothing here; the build half is out of scope |
| `dw-review-story`, `dw-review-tasks`, `dw-review-implement`, `dw-review-pr` | nothing; a diff review plus `review-work` cover it |
| `dw-test-design` | the runner's `qa-*` half, placed separately |
| `qw-drift` | **nothing at all.** The project's drift detection ends here |

## Not ours

Every other file in those two directories. Report it, leave it.
