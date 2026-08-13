# qa-workflow

Turns a story into **trustworthy test docs** — readable markdown in `docs/tests/`, authored
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
`test-plan`. `qw-review-plan` reviews it; `qw-cases` reads it and records the issue number in
each `TS-*.md` `plan:` field. Nothing auto-closes it — no change request targets a test plan
— so close it by hand once its docs have landed.

## Where a human decides

`qw-review-plan` gates the plan — does it cover the story? `qw-review-cases` gates the
docs — each doc one job, observable, traceable.

## What this owns — and what it hands off

- **Owns:** the authoring flow + the `docs/tests/` test-doc format (the contract). Self-contained
  — markdown + GitHub only.
- **Hands off:** binding each case to an executable and running it is the **project's binding +
  run layer**. Reusing vetted steps (a search index) is an **optional** project enhancement.

The format a test doc must follow is `docs/tests/README.md`.

## Project-specific values

The `docs/tests/` path, the `test-plan` label + colour, the `TS-`/`TC-` id schemes, the
test-doc front-matter fields, the drift anchor, the default status, and **the platform** —
the CLI and the verbs that differ between hosts — are **not** owned by the `qw-*` commands.
They resolve from `.claude/rules/project-profile.md`. The values a command shows are the
defaults; change them in the profile, not the command.

The `gh` invocations in these commands are that kind of illustrated default; a project on
another host reads its equivalents from the profile's **Platform** section rather than
editing the command.
