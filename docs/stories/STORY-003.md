# STORY-003: Replace the auditing skills with judgment-based review skills

## User Story

As a maintainer of agent-workflows,
I want the two checklist-driven governance skills replaced by three judgment-first review
skills,
So that artifact and doc reviews lean on reviewer judgment instead of rigid scorecards,
and the human-doc review is cleanly split into "words" and "look".

## The Need

The repo's governance skills were `auditing-artifacts` and `auditing-readme` — both
heavy, checklist-driven, and scored (Pass/Partial/Fail). The sibling `ai-qa-step-graph`
repo evolved a lighter, judgment-first generation of the same idea:

- **reviewing-artifacts** — five goal questions for any workflow artifact, plus a
  producer→review pairing pass. Replaces `auditing-artifacts`.
- **reviewing-phrasing** — the *words* of a human-read doc.
- **reviewing-typography** — the *look* of a human-read doc.

Together the last two replace `auditing-readme`, splitting one combined README audit into
a words half and a look half. The new skills trust reviewer judgment ("floor, not
ceiling") and drop the numeric scoring that the old skills relied on.

Leaving both generations in place is redundant and confusing — the old and new cover the
same ground two different ways.

## Success Looks Like

- The two `auditing-*` skills are gone.
- The three `reviewing-*` skills live in `.claude/skills/` and match their source.
- No stale references to `auditing-artifacts` / `auditing-readme` remain anywhere in the
  repo (notably CLAUDE.md's Skills section and Directory Structure block).
- CLAUDE.md describes the three review skills as the project's governance/review set.

## Open Questions

- Should the three stay as skills (auto-invocable, flat naming) or be reworked into
  namespaced commands (folder grouping, explicit `/`-invocation, arguments)? Trade-off
  discussed; default is keep-as-skills unless folder categorization or explicit
  invocation is wanted.
- Exact CLAUDE.md wording for the Skills section now that review is judgment-based rather
  than a scored audit.
- Whether any other docs (README, rules/) reference the retired audit skills and need the
  same sweep.

## Status

- **Completed: 2026-06-12** — PR #81 merged; `auditing-*` replaced by `reviewing-artifacts` / `reviewing-phrasing` / `reviewing-typography`, all references swept.
- Created: 2026-06-11
- Plan: #79
- Issues: ✅ #80 (merged, PR #81)
