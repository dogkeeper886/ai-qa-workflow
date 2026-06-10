# STORY-001: Slim ai-qa-workflow to two workflow products

## User Story

As a maintainer of ai-qa-workflow,
I want the repo reduced to just **dev-workflow** and **qa-workflow** (mirroring the sibling
`ai-qa-step-graph`),
So that each integration's commands live with the MCP server that owns them, and the repo
stops being a kitchen-sink that's costly to keep coherent.

## The Need

The repo has grown into eight command groups and eleven skills that mix three different
concerns: universal workflow commands, integration-specific MCP bindings (TestLink, Jira,
Confluence, GitHub), and cross-repo tooling. That breadth is hard to maintain and duplicates
responsibilities that belong elsewhere. A separately-generalized `qa-workflow` now supersedes
the private QA source the integration groups served, and GitHub operations are already folded
into `dev-workflow`. The repo should present two coherent products instead of a pile of
loosely related groups.

## Success Looks Like

- Someone opening the repo sees only two workflow products — `dev-workflow` and `qa-workflow`
  — plus governance/review skills, and nothing integration-specific.
- The work that no longer belongs here is gone or rehomed: the superseded integration groups
  are removed, TestLink lives with its own MCP server, and the remaining groups each end up in
  their right place.
- A newcomer following the install/README ends up with a working setup that matches the actual
  repo layout — no instructions pointing at things that have moved.

## Open Questions

- Where do the remaining groups land — TestLink with `testlink-mcp` (decided), and
  `test-workflow`, `project`, `utility` each resolved in their own issue (home vs another repo
  vs folded into qa-workflow).
- Coordination/timing with the separate `qa-workflow` generalization, so retiring the old QA
  groups doesn't outpace the replacement landing.
- Whether the typography/review skills stay here as governance or move with their integration.

## Status

- Created: 2026-06-09
- Plan: #57
- Issues: ✅ #58 (merged, PR #64), ✅ #59 (merged, PR #65), ✅ #61 (merged, PR #67), ✅ #62 (merged, PR #67), #63 — #60 folded into #58
