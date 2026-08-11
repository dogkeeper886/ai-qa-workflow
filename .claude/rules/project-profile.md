# project-profile

**The values this project declares.** Every unit resolves its project-specific values from
here rather than hardcoding them, so a workflow is customized by editing this file and not
the units. Change a line here and every unit follows.

This file is reached by name: a unit cites `.claude/rules/project-profile.md`, and a
project that has not written one leaves that reference unresolved rather than quietly
borrowing another project's values.

How that resolution works — the two wiring styles, what belongs here rather than in a
project skill, and what happens when a value cannot be resolved — is
the plugin's `rules/profile-doctrine.md`, which ships with the units. That file is the
same in every project; this one is not.

## Paths

- stories dir: `docs/stories/`
- tests dir: `docs/tests/`
- diagrams dir: `docs/diagrams/` (SVG source) + `docs/diagrams/png/` (rendered)
- story format contract: `docs/stories/README.md`
- test format contract: `docs/tests/README.md`

## ID schemes

- story id: `STORY-XXX` (zero-padded sequential, e.g. `STORY-001`)
- scenario id: `TS-NN`
- case id: `TC-NN`
- title prefixes: `[STORY-XXX] Test Plan`

## Labels

Names the workflow uses; colours where the workflow pins one (`#hex`), otherwise the
project's choice.

- test plan: `test-plan` (`#006b75`)
- status (pipeline position): `status:in-progress` · `status:needs-review`
- triage state (readiness): `ready-for-agent`

Which unit sets or clears which is the ship tail's business, not this file's — see the
plugin's `rules/ship-tail.md`.

## Linking & branch

- story back-reference (in titles/bodies): `[STORY-XXX]`
- issue closure (PR → issue): `Fixes #N` / `Closes #N`
- feature branch name: `issue-<N>-<slug>`

## Platform

The code host and issue tracker. **Worked out, not written down** — a unit derives the
host from `git remote get-url origin`. No hostname, owner, or repository path belongs in
this file or in any unit; an address a person has to keep correct is one that goes stale
silently.

- CLI: `gh` (GitHub) · `glab` (GitLab) — both read the current repository from the git
  remote, so neither takes a `-R` / `--repo` argument while inside the repo
- change-request noun: `PR` (GitLab: `MR`) — wording, which is the one thing derivation
  cannot supply
- where the verbs differ: change requests `gh pr <verb>` / `glab mr <verb>` · comment on
  an issue `gh issue comment` / `glab issue note` · comment on a change request
  `gh pr comment` / `glab mr note` · label an issue
  `gh issue edit --add-label` / `glab issue update --label`. The rest — `issue view`,
  `issue list`, `issue create`, `label create` — read the same on both.

## Git

- default branch: *derive it* (`git symbolic-ref --quiet refs/remotes/origin/HEAD`, minus
  the `refs/remotes/origin/` prefix), don't assume `main` — no network call and no
  platform CLI, so it reads the same on every host
- merge strategy: `--merge` (preserve history; switch to `--squash` only if the project requires)

## Front-matter & format contract (test docs)

- test-doc filename: `TS-NN-<slug>.md` in the tests dir
- front-matter fields: `id, title, namespace, story, story_hash, plan, issue, status` — the
  anchor field tracks the drift anchor below; drop it when that is `none`
- drift anchor: `story_hash` — the `sha256` of the story file (`sha256sum`), recorded so a
  later gate can tell the story has moved. A project that detects drift another way (a
  derived link check, say) names that here instead, or `none`. The `qw-*` commands record
  whatever this declares; they do not assume hashing.
- default status: `green`

## Docs & diagrams

- README output: `README.md`
- diagram policy: SVG source committed + rendered to PNG (no Mermaid / inline diagram blocks)
- diagrams dir: `docs/diagrams/` (SVG source) + `docs/diagrams/png/` (rendered) — also under Paths

## Reports

The words a gate report uses. The contract itself — the questions a report answers and
why — is the plugin's `rules/agent-report.md`; a unit resolves the wording from here.

- verdict vocabulary: `PASS` · `REVISE` · `HAND BACK`
- extra verdict (artifact review only): `CUT` — the artifact duplicates another or does
  nothing useful; propose removal
- section names: `Verdict` · `Findings` · `Checked` · `Not done` · `Unresolved` ·
  `Trace` · `Next`
- empty-section marker: `none` (a section with nothing to report says so; it is not dropped)
- finding columns: `# · severity · location · what's wrong · smallest fix`
- formats by medium: chat session → plain text, tables, ASCII diagrams · document or
  issue → whatever renders there. For a *published* human-read doc the diagram policy
  under Docs & diagrams applies instead.

## Review semantics

- canonical format (source of truth): `markdown`
- live integrations: `GitHub` — tools the project genuinely uses; coupling to one
  listed here is correct, not drift. (A downstream adds its own, e.g. Jira, Confluence,
  TestLink.)
- deliverable (triggers a paired review): a unit that *produces or changes* an output —
  by name (`create-`/`sync-`/`publish-`/`draft-`/`init-`) or as a producing gerund skill
  (`planning-…`, `drafting-…`)
- audience (human-read docs): engineers and newcomers
