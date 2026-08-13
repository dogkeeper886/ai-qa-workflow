# doc-workflow

Turns a **codebase into its README** — a newcomer-facing document grounded in current
best practice, leading with the few ideas worth a diagram, and true to the code.

## The flow

```
   a repo  ──or──  "write the README for X"   (on request)
        │
        ▼
   doc-gen-readme ───► doc-review-readme ───► [human reviews] ───► PR
        │                    │
        │                    └─ reuses reviewing-phrasing + reviewing-typography,
        │                       then verifies every claim against the code
        ▼
   README.md (+ the project's diagrams dir when diagrams help)
```

`doc-gen-readme` opens with a mandatory **WebSearch** step so the structure tracks current
convention rather than a frozen template. Diagrams are optional: when used, the SVG is the
source of truth and the embedded PNG is rendered reproducibly.

## Where a human decides

`doc-review-readme` gates what `doc-gen-readme` wrote — reads and looks right, true to the
code, delivers for a newcomer. It stops there: a person reads the result before it lands.

## What this owns — and what it reuses

- **Owns:** the README authoring flow + the accuracy gate (claims verified against the code,
  links resolve, diagrams match reality). Self-contained — markdown + the repo.
- **Reuses:** the human-read doc review — `reviewing-phrasing` (the words) and
  `reviewing-typography` (the look). `doc-review-readme` calls them rather than re-judging
  prose itself.

## Project-specific values

The diagrams dir, the diagram policy (SVG source → PNG), and the README output path are
**not** owned by the `doc-*` commands — they resolve from
`.claude/rules/project-profile.md`. The values a command shows are the defaults; change
them in the profile, not the command.
