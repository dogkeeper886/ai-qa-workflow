# `docs/tests/` — the test-doc format

Each test is a **readable markdown document** that lives here, close to the story it verifies.
The markdown is the *canonical* artifact — humans read and review it, and it is the source of
truth for **why** a test exists and **what** it checks. `qw-cases` writes these; `qw-review-cases`
reviews them.

Binding a doc to an executable and running it is the **project's binding + run layer** — out of
scope for this format. This doc defines only the readable artifact.

## One file = one scenario (TS), many cases (TC)

A **scenario** groups related **cases**, each case a sequence of **steps**.

```
docs/tests/
  TS-01-<slug>.md     # a scenario: TC-01, TC-02, … each with a Steps table
  TS-02-….md
```

- **TS** (scenario) — the file. Holds the front-matter and a `## Why this scenario exists`.
- **TC** (case) — a `### TC-NN:` section. Has an objective, an optional **`Script:`** line (the
  binding the project's run layer fills in), and a **Steps** table.
- **Step** — one row of a case's Steps table: an **Action** and its **Expected Result**.

## Front-matter (scenario level)

```yaml
---
id: TS-01                       # scenario id, unique within the namespace
title: Login succeeds with valid credentials
namespace: agent-workflows      # which repo/tenant this test belongs to
story: STORY-003                # the need this scenario verifies (→ docs/stories/STORY-003.md)
story_hash: 7474d8b6…           # sha256 of the linked story file at last sync (drift anchor)
plan: 28                        # the [STORY-XXX] Test Plan issue it was authored from (qw-cases sets it)
status: green                   # green | stale | unbound  (maintained by the project's drift gate)
---
```

- `story` + `story_hash` are the drift anchor: when the story changes, its hash no longer matches.
- `plan` traces the scenario back to the `[STORY-XXX] Test Plan` issue. Optional — absent when a
  test was written without a plan.
- `Script:` is **per-TC, not in front-matter** — and is filled by the project's binding layer.

## Case (TC) structure

```markdown
### TC-01: Valid login

- **Objective:** a known-good user can sign in.
- **Script:** <filled by the project's binding layer>
- **Preconditions:** the app is running.

| # | Action | Expected Result |
|---|--------|-----------------|
| 1 | Enter valid username + password | the form accepts them |
| 2 | Submit | redirected to the dashboard |
```

The Steps table is **machine-extractable** on purpose: one row = one `Action → Expected Result`.

## Traceability

- **story → tests:** `grep -l 'story: STORY-XXX' docs/tests/`
- **test → story:** the front-matter `story:` line.
- **test → plan:** the front-matter `plan:` line (the Test Plan issue number).

No hand-maintained index — the links live in the files and resolve by `grep`/path.

## Beyond authoring (the project's layer)

`status` values (`green` | `stale` | `unbound`), the `Script:` binding, drift detection, and any
step-reuse index are the **project's** concern, not this format's. This repo authors the readable
docs; a consuming project binds + runs + maintains them.
