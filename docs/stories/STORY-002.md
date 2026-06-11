# STORY-002: Rename repo to `agent-workflows`

## User Story

As a maintainer of the agent-workflows family,
I want this repo renamed from `ai-qa-workflow` to `agent-workflows`,
So that the name reflects the generalized two-workflow toolkit and aligns with the
`agent-*` family.

## The Need

The repo began as a private command collection, was generalized to open source, and was
then decoupled from private software and TestLink. What remains is a brand-neutral
toolkit of two AI-agent workflows — **dev-workflow** (an ordered action lifecycle, not
just for dev) and **qa-workflow** (test docs split from scripts, mapped to stories). The
current name "AI QA Workflow":

- Undersells the general dev half — it reads as QA-only.
- Collides with the planned flagship product, `agent-studio`.
- Still carries the smell of its private, QA-specific origin.

A consistent `agent-*` family name (`agent-workflows`, `agent-workflows-runner`,
`agent-studio`) fixes all three.

## Success Looks Like

- The repo is named `agent-workflows`.
- README and CLAUDE.md read as a two-workflow agent toolkit, not a QA-only tool.
- No stale `ai-qa-workflow` self-references remain.
- The `agent-*` family naming is documented.

## Open Questions

- README rewrite depth — full reframe around the two-workflow / ordered-discipline story,
  or a lighter cleanup?
- How to handle the old repo URL / redirect and any hardcoded
  `dogkeeper886/ai-qa-workflow` references.
- Coordination with the sibling-repo renames (`test-framework-template` →
  `agent-workflows-runner`, `ai-qa-studio` → `agent-studio`), which are their own stories
  in their own repos.

## Status

- Created: 2026-06-11
- Completed: 2026-06-11
- Plan: #71
- Issues: #72, #73, #74 (all merged/closed)
- Follow-ups: #77 (stale template content), #78 (runner reference sweep)
