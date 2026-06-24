---
paths:
  - ".claude/commands/qa-workflow/**/*.md"
---

# qa-workflow

A sibling to `dev-workflow`. Where dev-workflow turns a need into shipped code, qa-workflow
turns a story into **trustworthy test docs** — readable markdown in `docs/tests/`, authored
from a reviewed test plan. This repo owns the **authoring** half (markdown + GitHub); binding
those docs to a runner and running them is the project's own layer.

## The flow

```
   docs/stories/STORY-XXX.md   ──or──  "write a test for X"   (on request)
            │
            ▼
   qw-plan ───────► qw-review-plan      what to test — scenarios persisted as the
            │                            [STORY-XXX] Test Plan issue
            ▼
   qw-cases ──────► qw-review-cases     write docs/tests/TS-*.md (the format contract)
            │
            ▼
   → hand off to the project's binding + run layer
```

## The test-plan issue

`qw-plan`'s scenarios persist as a **GitHub issue**, titled `[STORY-XXX] Test Plan`, labelled
`test-plan` (distinct from dev's `[STORY-XXX] Plan`). `qw-review-plan` reviews it; `qw-cases`
reads it and records the issue number in each `TS-*.md` `plan:` field.

## Producer → review pairing

| Producer | Review | Covers |
|----------|--------|--------|
| `qw-plan`  | `qw-review-plan`  | does the plan cover the story? |
| `qw-cases` | `qw-review-cases` | each doc: one job, observable, traces back |

No producer ships without a review covering its output.

## What this owns — and what it hands off

- **Owns:** the authoring flow + the `docs/tests/` test-doc format (the contract). Self-contained
  — markdown + GitHub only.
- **Hands off:** binding each case to an executable and running it is the **project's binding +
  run layer**. Reusing vetted steps (a search index) is an **optional** project enhancement.

## Closing the loop — when a Test Plan is done

The authoring flow leaves the `[STORY-XXX] Test Plan` issue **open**; it is the live record of
outstanding coverage. It reaches its terminal state when the story is implemented and its
`docs/tests/TS-*.md` are **verified green** — run by hand until the binding + run layer exists:

- As you verify each TS doc, set its front-matter `status` (`green` pass / `red` fail) and
  `issue:` (the implementation issue it verified).
- When all of a story's TS docs are green, **close** the `[STORY-XXX] Test Plan` issue. This is
  wired through the dev side: the implementation PR that completes the story puts
  `Closes #<test-plan>` in its description (see `dw-create-pr`), so merging it closes the Test
  Plan. A `red` doc leaves the Test Plan open.

The format a test doc must follow is `docs/tests/README.md`.

## Project-specific values

The `docs/tests/` path, the `test-plan` label + colour, the `TS-`/`TC-` id schemes, the
test-doc front-matter fields, the hash algorithm, and the default status are **not** owned
by the `qw-*` commands — they resolve from `.claude/rules/project-profile.md`. The values
a command shows are the defaults; change them in the profile, not the command.
