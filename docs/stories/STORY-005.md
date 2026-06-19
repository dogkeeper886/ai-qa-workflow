# STORY-005: A customization seam so downstream consumers don't edit the template

## User Story

As a downstream consumer of this template repo (e.g. r1-test-cases),
I want a dedicated, project-owned place to declare my specifics — paths, IDs, labels,
   "live" integrations, what counts as a deliverable, format, audience,
So that I can customize the workflow without editing the shipped commands and skills,
   and upstream improvements reach me without merge conflicts.

## The Need

This repo ships a workflow as a template. A downstream project copies the `.claude/`
commands and skills and adapts them to its own conventions. But there is no seam for
that adaptation: every project-specific value is **hardcoded inside the general unit**,
so customizing means editing the shipped file.

That has a cost we have now seen first-hand. Downstream `r1-test-cases` needed its
reviews to know about Confluence/TestLink, so it rewrote `reviewing-typography` and
`reviewing-phrasing` directly — welding project plumbing into skills meant to be
general. The result: the skills stopped being general, the work duplicated skills that
already existed (`confluence-review`, `testlink-review`), and pulling any upstream
improvement back down now means a manual merge.

A survey of every command and skill shows the same hardcoded surface everywhere — not a
one-off. Each value below is something a different project would plausibly set
differently, and today each forces an edit to the unit:

| Unit | Project-specific values it hardcodes |
|------|--------------------------------------|
| **dev-workflow** | |
| `dw-story` | `docs/stories/` path; `STORY-XXX` id scheme |
| `dw-plan` | `plan` label + colour `#5319e7`; `priority:*` labels; `[STORY-XXX] Plan` title; story path |
| `dw-tasks` | type labels (`feature`/`enhancement`/`bug`/`docs`); `priority:*`; `status:*`; `[STORY-XXX]` title; `Part of #<plan>` linking; story path |
| `dw-implement` | `status:*` labels; branch name `issue-<N>-<slug>`; story path |
| `dw-review-implement` | `[STORY-XXX]`; story path; default-branch assumption |
| `dw-review-story` | `docs/stories/`; `docs/stories/README.md` |
| `dw-review-tasks` | `plan` label; `[STORY-XXX]`; story path |
| `dw-create-pr` | `status:*` labels; story path; default branch |
| `dw-merge` | `status:*` labels; story path; merge strategy (`--merge` vs `--squash`) |
| **qa-workflow** | |
| `qw-plan` | `docs/stories/` + `docs/tests/` paths; `test-plan` label + colour `006b75`; `[STORY-XXX] Test Plan` title; `TS-`/`TC-` id schemes |
| `qw-cases` | `docs/tests/TS-*.md` path + naming; front-matter field set; `sha256` hashing; default `status: green`; format contract `docs/tests/README.md` |
| `qw-review-plan` | `test-plan` label; `[STORY-XXX] Test Plan` title; review comment text |
| `qw-review-cases` | `docs/tests/TS-*.md`; front-matter fields; format-contract location |
| **doc-workflow** | |
| `doc-gen-readme` | diagram policy (SVG source → PNG, no Mermaid); `docs/images/` dir; `README.md` output |
| `doc-review-readme` | same diagram policy; `docs/images/`; `README.md`; `docs/` |
| **skills** | |
| `reviewing-artifacts` | which integrations are "live" vs drift; what counts as a "deliverable"; canonical format (markdown) |
| `reviewing-phrasing` | canonical format/medium; the reader/audience; in-scope doc locations |
| `reviewing-typography` | canonical format/medium (markdown vs Confluence/HTML); audience; in-scope locations |

The values cluster into a handful of kinds — **paths**, **id schemes**, **labels &
colours**, **linking & branch patterns**, **git conventions**, **front-matter/format
contract**, and **review semantics** (live integrations, deliverable definition,
canonical format, audience). That clustering is the opportunity: one place a project
fills in once, that every unit reads from.

There are two kinds of customization, and only one belongs in a shared "list":
- **Declarative** (a value or a list) — paths, ids, labels, integrations, deliverables,
  audience. These belong in the seam; the general unit reads them.
- **Procedural** (a whole workflow) — e.g. how to publish to Confluence and review the
  render. These belong in their **own project-owned skill** (r1 already has
  `confluence-review` / `testlink-review`), not inside a general unit.

The rules files already gesture at this with their "**what this owns vs what it hands
off to the project's own layer**" framing — the seam makes that boundary concrete and
machine-readable instead of prose.

## Success Looks Like

- A downstream can change any value in the table above — paths, id schemes, label
  names/colours, front-matter fields, canonical format, the "live integrations" list,
  the "deliverable" definition, the audience — **without editing any shipped command or
  skill**.
- The shipped commands and skills carry **no project-specific values**; they read them
  from the seam.
- Upstream ships the seam as a **template stub with defaults equal to today's
  behaviour** — a project that changes nothing behaves exactly as now.
- Pulling a newer upstream command/skill into a downstream produces **no merge
  conflict** on that project's customizations.
- `reviewing-artifacts` Q4 consults the seam's "live integrations" list instead of
  naming tools; the phrasing/typography skills read format + audience from the seam.
- **Every unit in the table is accounted for** — it either reads the seam or is
  documented as having nothing to customize.
- The declarative-vs-procedural boundary is written down: lists → the seam; procedures
  → a project-owned skill.

## Open Questions

- Seam mechanism — one `.claude/rules/project-profile.md`? a block in
  `.claude/settings.json`? per-skill `references/` overrides? (decided in `dw-plan`)
- Is the boundary strictly commands + skills (as scoped here), or should `rules/*.md`
  and `CLAUDE.md` also read from / define the seam?
- How does an **agent-read** command reference the seam without hardcoding the seam's
  own path (the chicken-and-egg)?
- Exact defaults that reproduce current behaviour, so adoption is a no-op until a
  project opts in.
- Does PR #85 (the `reviewing-artifacts` backport) become the first concrete instance
  of the seam, or stay independent?

## Status

- Created: 2026-06-19
