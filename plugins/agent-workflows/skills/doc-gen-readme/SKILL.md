---
name: doc-gen-readme
description: |
  Write a project's README from the code: research current README convention on the web,
  study the repo from its ground truth rather than its existing docs, find the one
  organizing idea a newcomer needs first, optionally draw a diagram per key idea, and
  write the file. The producer half of the doc-workflow. It writes the README only — it
  does not open a PR, and doc-review-readme gates what it wrote.
when_to_use: |
  Whenever a repo needs its README written or rewritten — "write the README", "generate
  a README for this project", "our README is stale, redo it", "document this repo for
  newcomers", "write a README for ../other-repo".
argument-hint: "[repo-path]"
allowed-tools:
  - WebSearch
  - Read
  - Grep
  - Glob
---

# Generate a README

## Rules

Doctrine — the same in every project, and travels with these units:
@${CLAUDE_PLUGIN_ROOT}/rules/doc-workflow.md
@${CLAUDE_PLUGIN_ROOT}/rules/anti-slop.md
@${CLAUDE_PLUGIN_ROOT}/rules/agent-report.md
@${CLAUDE_PLUGIN_ROOT}/rules/profile-doctrine.md

Values — this project's:
@.claude/rules/project-profile.md

Research best practices, study the project, and write its README — diagrams and all.

Target: $ARGUMENTS  (a repo path, or empty for the current repo)

## PURPOSE

Turns a codebase into a README a newcomer gets in a minute. It grounds the structure in
a fresh web search (so it tracks current convention, not a frozen template), studies the
project for the few ideas worth leading with, optionally draws a diagram per idea, and
writes the file. The producer half of the doc-workflow; its output is gated by
`/doc-review-readme`. See `doc-workflow`.

Fits in the doc-workflow:

    doc-gen-readme → doc-review-readme → [human reviews] → PR

This writes the README only. It does NOT open a PR.

---

## WORKFLOW

    /doc-gen-readme
        │
        ├─► Step 1: Research current best practices (WebSearch — do not skip)
        │   - Search for README best practices for THIS YEAR: section order, badges,
        │     where visuals go, what to cut. Note the sources.
        │   - This step keeps the generator current instead of freezing today's taste.
        │   - Scope: research informs section order and where visuals sit — NOT the
        │     diagram file format. That is fixed by Step 4 (SVG source → rendered PNG);
        │     do not let a search result (e.g. "use Mermaid") override it.
        │
        ├─► Step 2: Study the project — from the ground truth — to find its key point
        │   - Study from ground truth FIRST, not the existing docs. Read what the project
        │     actually is from its real artifacts — entry points, build/compose/package
        │     files, scripts, config, the top-level layout — and trace how its parts
        │     connect and flow. Where ground truth lives varies by project; those are
        │     examples, not a checklist.
        │   - Treat any existing README/docs/notes as CLAIMS to verify against the code,
        │     not as truth. They may be stale or aspirational — derive the real model from
        │     the code, don't inherit theirs.
        │   - Find the key point BEFORE listing features: the one organizing idea a
        │     newcomer must grasp first — what this is, why it exists, and how its parts
        │     form one whole. For a multi-part repo that is usually how the components
        │     compose and depend on each other; for a single tool, the core abstraction or
        │     main flow.
        │   - THEN name the few distinctive ideas to lead with — the ones a diagram
        │     explains better than prose — grounded in that key point. Rank them; recommend
        │     a focused set (≈3), not every idea. Deep dives stay in docs/ and get linked.
        │
        ├─► Step 3: Draft the structure
        │   - Adapt the researched structure to the project: title + one-liner + badges
        │     → what it is / problem → how it works (lead with the key point — for a
        │       multi-part repo, how the parts compose — then the distinctive ideas) →
        │       features → quickstart → usage/config → reference → docs index → license.
        │   - Lead with the point; keep it scannable; link out rather than inline.
        │
        ├─► Step 4: Diagrams (optional — one per key idea)
        │   - If diagrams help, author one SVG per key idea (the editable source) and
        │     render each to PNG for reliable rendering; embed the PNG.
        │   - Make the render reproducible (a script / make target), not hand-exported.
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
            - STOP. Gate it with /doc-review-readme before a PR. Do NOT open a PR here.

---

## EXAMPLE

    /doc-gen-readme

    1. WebSearch "README best practices <year> structure badges diagrams"
    2. Study repo → key ideas: <A>, <B>, <C>
    3. Draft structure; recommend 3 diagrams
    4. Author <idea>.svg in the project's diagrams dir → render PNG (a reproducible step)
    5. Write README.md; verify tool names / env vars / links against the code
    6. Hand off → /doc-review-readme

---

## OUTPUT

The README, and any diagrams authored with it. Trace carries their paths. Reported per
`agent-report` — the verdict first, and a section with nothing to
report says so.

---

## API Notes

- Reads the repo + the web; writes README.md (+ the diagrams dir if diagrams). No PR.
- The WebSearch step is mandatory — it is what keeps this command from going stale.
- Diagrams are optional; when used, SVG is the source of truth and the PNG is rendered.
- `/doc-review-readme` gates what this writes, before a person reads it.
- Right-size: a tiny project may need no diagrams; don't manufacture them.
