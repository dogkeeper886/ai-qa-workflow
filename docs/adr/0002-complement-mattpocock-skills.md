# Complement `mattpocock/skills` rather than duplicate them

The `mattpocock/skills` set covers idea → ship — `/grill-with-docs`, `/to-spec`,
`/to-tickets`, `/implement`, `/code-review-2axis` — and covers it better than the `dw-*`
pipeline did, so the seven commands that competed with it are deleted. What stays is only
what his set does not reach: the **ship tail**, the **report contract**, the finish checks
a diff-reading review cannot perform, and the README authoring pair. The `qw-*` authoring
commands and the `docs/tests/` format move to `agent-workflows-runner`, which already owns
the binding, run, and drift half.

## Considered Options

- **Keep both pipelines.** Rejected: `/to-tickets` alone is better than `dw-tasks` +
  `dw-review-tasks` — it declares blocking edges and sequences wide refactors as
  expand–contract, neither of which `dw-tasks` does — and running two review passes over
  one diff is ritual, not rigor.
- **Stop the repo entirely.** Rejected: three things have no home in his set and no home in
  a test runner. `/implement` ends at "commit your work to the current branch", and
  `/triage`'s `ready-for-agent` label is never cleared by anything he ships — his label
  state machine has no exit. The report contract is the other gap, and the one that shows
  up most: his skills routinely blend what was done, what is suspected, a recommended fix,
  the next step, and a completion claim into a single paragraph.
- **Keep `qw-*` here and leave the runner as the execution half.** Rejected despite the
  seam being clean and documented — the runner already declares the markdown format
  "shared with upstream's `qa-workflow`" and splits intent (markdown) from execution
  (bound YAML). Once the runner ships its own plugin, authoring and execution have no
  reason to sit in different repos, and one repo is one thing to version.
- **Keep `dw-story` so `story_hash` keeps an anchor.** Rejected: `/to-spec` publishes to
  the issue tracker rather than to a file, so re-anchoring means a network call and an auth
  dependency inside a CI drift checker. The story-drift branch of the runner's `drift.ts`
  is deleted instead; front matter keeps an unhashed `spec: <issue#>` so a human can still
  trace a test to its intent.

## Landing this in two steps

The `qw-*` commands, `docs/tests/`, and the drift-anchor change do **not** move in the same
change as the deletions. They move when `agent-workflows-runner#76` lands, so the QA half is
never absent from both repos at once. Until then this repo still ships `qw-*`,
`rules/qa-workflow.md`, and the `story_hash` anchor the profile declares — the third and
fourth options above describe the decided end state, not today's tree.

**Both steps have landed.** `agent-workflows-runner#76` closed on 2026-08-11, and this repo
removed `qw-*`, `rules/qa-workflow.md`, the `docs/tests/` format contract and the profile's
test-doc values — the `story_hash` anchor among them — in #128. What the profile still
carries from the deleted `dw-*` pipeline is a separate cut, tracked in #129.

## Consequences

Two plugins now exist, and the runner's `qw-*` cite `agent-report.md` from this one. Claude
Code cannot express a dependency between plugins, so a missing install resolves to nothing
rather than stopping — the runner's README names `agent-workflows` as a prerequisite, which
is documentation, not enforcement. This is the one place ADR-0001's "the shipped thing is
self-contained" does not hold, and it is accepted deliberately: duplicating the rule would
let the two copies diverge silently, which is worse than a stated prerequisite.

Automated staleness detection between a story and its test docs is gone. Doc↔YAML binding
drift still runs, but nothing now notices when intent moves underneath a test.

`agent-report.md` is cited from the template `CLAUDE.md` rather than left to
`reporting-outcomes` to invoke itself. A skill that fires on its own judgement cannot
reliably catch a mess it is itself producing, so the contract has to bind the session.

Downstream repos (`ollama37`, `ruckus1-mcp`, `ldap`) still hold `.claude/` forks of the
deleted commands, migrated by hand and out of scope here. ADR-0001's shadowing problem
outlives this decision.
