---
name: gen-readme
description: |
  Writes a project's README from the code: researches current README convention on the
  web, studies the repo from its ground truth rather than its existing docs, finds the key
  points a newcomer needs first, draws every one of them as an SVG rendered to PNG, and
  writes the file. Produces the README only — it does not open a PR, and review-readme
  gates what it wrote.
when_to_use: |
  Use whenever a README is about to be created or edited — before writing one from
  scratch, and before changing an existing one. Covers "write the README", "generate a
  README for this project", "our README is stale, redo it", "update the README", "document
  this repo for newcomers", "write a README for ../other-repo" — and applies even when the
  request is to touch one section rather than the whole file.
argument-hint: "[repo-path]"
---

# Generate a README

## Values

Four values belong to the project, not to this skill. Use the default unless the project
declares otherwise; where it declares, that wins:

| Value | Used by | Default |
|---|---|---|
| README output path | Step 5 | `README.md` |
| diagrams dir | Step 4 | `docs/diagrams/` (SVG) + `docs/diagrams/png/` |
| diagram policy | Step 4 | SVG source committed, PNG rendered, no Mermaid |
| report vocabulary | Step 6 | the words in OUTPUT below |

Research best practices, study the project, and write its README — diagrams and all.

Target: $ARGUMENTS  (a repo path, or empty for the current repo)

## PURPOSE

Turns a codebase into a README a newcomer gets in a minute. It grounds the structure in
a fresh web search (so it tracks current convention, not a frozen template), studies the
project for the key points worth leading with, draws every one of them, and
writes the file. Its output is gated by `/review-readme`, which checks the claims
against the code before a person reads them:

    gen-readme → review-readme → [human reviews] → PR

This writes the README only. It does NOT open a PR.

---

## WORKFLOW

Copy this checklist into your reply and tick each item as you finish it. Steps 1 and 4 are
the two that get skipped under time pressure, and both are unrecoverable later — an
unresearched structure and an undrawn key point both reach the reader as gaps.

    Task Progress:
    - [ ] Step 1: Researched current README convention (WebSearch actually run)
    - [ ] Step 2: Studied ground truth; key points NUMBERED and ranked
    - [ ] Step 3: Structure drafted around those key points
    - [ ] Step 4: One SVG per key point authored AND rendered to PNG
    - [ ] Step 4 count check: diagrams == entries on Step 2's numbered list
    - [ ] Step 5: README written; every claim and link verified against the code
    - [ ] Step 6: Handed off to /review-readme — no PR opened

    /gen-readme
        │
        ├─► Step 1: Research current best practices (WebSearch — do not skip)
        │   - Search for README best practices for THIS YEAR: section order, badges,
        │     where visuals go, what to cut. Note the sources.
        │   - This step keeps the generator current instead of freezing today's taste.
        │   - Scope: research informs section order and where visuals sit — NOT the
        │     diagram file format. That is fixed by Step 4 (SVG source → rendered PNG);
        │     do not let a search result (e.g. "use Mermaid") override it.
        │
        ├─► Step 2: Study the project — from the ground truth — to find its key points
        │   - Study from ground truth FIRST, not the existing docs. Read what the project
        │     actually is from its real artifacts — entry points, build/compose/package
        │     files, scripts, config, the top-level layout — and trace how its parts
        │     connect and flow. Where ground truth lives varies by project; those are
        │     examples, not a checklist.
        │   - Treat any existing README/docs/notes as CLAIMS to verify against the code,
        │     not as truth. They may be stale or aspirational — derive the real model from
        │     the code, don't inherit theirs.
        │   - Key point #1 is the organizing idea, and you find it BEFORE listing
        │     features: what this is, why it exists, and how its parts form one whole.
        │     For a multi-part repo that is usually how the components compose and depend
        │     on each other; for a single tool, the core abstraction or main flow.
        │   - THEN add #2 onward — the ones a diagram explains better than prose — each
        │     grounded in #1. Rank them and keep the whole list focused (≈3 including #1);
        │     deep dives stay in docs/ and get linked.
        │   - End Step 2 with a NUMBERED LIST of key points. That list is what Step 4
        │     draws against and what its count check counts — #1 included, no separate
        │     category, nothing outside it. To end up with fewer diagrams, shorten this
        │     list; Step 4 has no discretion.
        │
        ├─► Step 3: Draft the structure
        │   - Adapt the researched structure to the project: title + one-liner + badges
        │     → what it is / problem → how it works (lead with #1 — for a multi-part
        │       repo, how the parts compose — then #2 onward in rank order) →
        │       features → quickstart → usage/config → reference → docs index → license.
        │   - Lead with the point; keep it scannable; link out rather than inline.
        │
        ├─► Step 4: Diagrams — one per key point, ALL of them
        │   - Author one SVG per entry on Step 2's numbered list (the editable source)
        │     and render each to PNG; embed the PNG. #1 gets one like the rest — it is
        │     the organizing idea, so it is the diagram the reader needs most.
        │   - Count check: diagrams authored == entries on Step 2's list. If it is fewer,
        │     either draw the rest or go back and shorten the list.
        │   - Render with an explicit, recorded command — never a hand export, which
        │     nobody can reproduce and nothing can re-run. Default:
        │       rsvg-convert -z 2 <name>.svg -o png/<name>.png
        │     `-z 2` renders at twice the viewBox so the PNG stays sharp on a HiDPI
        │     screen; keep one scale across every diagram in a project or they will not
        │     sit together on the page.
        │   - If rsvg-convert is absent, use the project's own renderer and record THAT
        │     command. Whichever is used, commit it as a script or make target in the
        │     project so a second person reproduces the same bytes — a diagram nobody can
        │     re-render is stale the first time the code moves.
        │   - Mirror any existing ASCII diagrams in docs/ so the picture matches reality.
        │
        ├─► Step 5: Write the README
        │   - If asked to rewrite, delete the old file and write fresh (don't patch prose).
        │   - VERIFY EVERY CLAIM against the code: commands, endpoints, env vars, tool
        │     names, file paths. A README is run by its reader — wrong is worse than terse.
        │   - Confirm every link resolves to a file that exists.
        │
        └─► Step 6: Hand off
            - Summarize what was written + the diagram set + the sources.
            - STOP. Gate it with /review-readme before a PR. Do NOT open a PR here.

---

## EXAMPLE

    /gen-readme

    1. WebSearch "README best practices <year> structure badges diagrams"
    2. Study repo → key points: <A>, <B>, <C>
    3. Draft structure around those three
    4. Author <A>.svg, <B>.svg, <C>.svg in the diagrams dir → render all three to PNG
       (a reproducible step) — three key points, three diagrams
    5. Write README.md; verify tool names / env vars / links against the code
    6. Hand off → /review-readme

---

## OUTPUT

The README, and one diagram per key point — SVG source plus rendered PNG for each.

Report in this order: the verdict first and alone on a line; then what was written; the
diagram set with its paths and the render command used; the sources from Step 1; anything
skipped on purpose; anything still uncertain; and one next step. A section with nothing to
report says so rather than being dropped — an absent section reads as a question never
asked. Where the project declares its own verdict words and section names, use those.

---

## API Notes

- Reads the repo + the web; writes README.md + the diagrams dir. No PR.
- The WebSearch step is mandatory — it is what keeps this skill from going stale.
- The render command is recorded, not improvised; the default is
  `rsvg-convert -z 2 <name>.svg -o png/<name>.png`.
- Every key point gets a diagram: SVG is the source of truth, the PNG is rendered and
  embedded. The count follows Step 2's numbered list — no entry ships undrawn.
- `/review-readme` gates what this writes, before a person reads it.
- Right-size by shortening Step 2's list, not by skipping diagrams. A tiny project has
  one key point and therefore one diagram.
