# STORY-004: Behavior-led docs + README diagram overhaul

> **Retrospective story.** The work below shipped inside PR #81 (alongside STORY-003)
> without a story of its own. This record closes that process gap — the `dw-review-implement`
> gate flagged the scope creep after the fact.

## User Story

As a maintainer of agent-workflows,
I want `CLAUDE.md` and the `README` reshaped into a behavior-led, diagram-driven form, and
the stale install/architecture docs retired,
So that the agent-read guidance and the human-read entry doc each fit their reader instead
of carrying a stale install manual.

## The Need

During STORY-003 (the skill swap), the work expanded well past it. `CLAUDE.md` +
`templates/CLAUDE.md` were rewritten into the behavior-led structure (matching
`ai-qa-step-graph`); the `README` was fully rewritten with six embedded diagrams; the old
install/architecture manual, two-tier model, and agent-driven-install language were dropped
in favour of a plain `cp` install; `docs/{design,integrations,references}/` and the
deprecated root `Makefile` were retired; and the qa-workflow format contract
(`docs/tests/README.md`) was restored after an over-eager deletion. None of that traced to
STORY-003's goal — it should have been its own story and branch.

## Success Looks Like

- `CLAUDE.md` + `templates/CLAUDE.md` are behavior-led (principles + dev/qa workflow
  discipline + review discipline), with no install/architecture manual.
- The `README` leads with the two-workflow story, carries six diagrams, installs via copy,
  and describes the `agent-*` family accurately (runner shipped, studio planning).
- Stale docs are retired and no references dangle; the install model is manual copy
  (agent-driven install + two-tier removed).

## Open Questions

- None — shipped and human-ratified in PR #81. Lesson recorded: split a doc overhaul from a
  scoped skill change next time, so each gets its own gate.

## Status

- Created: 2026-06-12 (retrospective)
- Completed: 2026-06-12 — shipped in PR #81 (commits `d1c072e`, `f6d9805`, `664bf46`).
- Issues: none (bundled into STORY-003's PR #81 — the gap this story records)
