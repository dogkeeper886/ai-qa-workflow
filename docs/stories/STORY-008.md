# STORY-008: Close the plan issue when its story is done

## User Story

As someone running the dev-workflow,
I want a story's plan issue to close when the work it planned is finished,
So that my open-issue list shows what is actually outstanding, rather than a growing
   pile of plans for work that shipped weeks ago.

## The Need

The plan issue is the parent of a story's task issues and the checkpoint a fresh session
resumes from. It is the one issue in the pipeline that nothing ever closes.

Task issues close themselves — a PR says `Closes #N` and GitHub does the rest. The plan
is nobody's `Closes` target, because no PR delivers the plan; PRs deliver its tasks. So
`dw-merge` merges the last task, marks the story Completed, and leaves the plan open
behind it.

This is not a slip anyone made. Both plan issues this repo has ever created ended up
orphaned: STORY-005's sat open for six weeks after the story was marked Completed, and
STORY-007's was open within the hour of its last task closing. A gap that catches every
instance is in the pipeline, not in the person driving it.

The cost is small per instance and compounds: an open-issue list that has to be read
with a caveat is one nobody trusts at a glance, and the plan issue is exactly the thing
someone scans for when asking "what is still in flight here?".

## Success Looks Like

- Finishing a story's last task leaves no open plan issue behind — without anyone
  remembering to close it.
- The open-issue list answers "what is still in flight?" honestly, with no mental
  filtering for plans that have already shipped.
- A plan whose story still has open tasks stays open — the close happens when the work
  is done, not when any task merges.
- A plan someone already closed by hand, or a story that never had one, causes no error
  and no noise.
- Every story that finishes gets the same treatment — the two plans orphaned here were
  the symptom that surfaced this, not the scope of the fix.

## Open Questions

- What exactly triggers the close — the last task issue closing, or the story being
  marked Completed? They coincide today; if they ever diverge, one has to be the trigger.
- A story can end without every task merging: some are closed as won't-do, some
  abandoned. Does "all tasks closed" cover that, or does it need to mean something
  narrower?
- The qa-workflow has the same shape — `qw-plan` creates a `[STORY-XXX] Test Plan`
  issue, and nothing closes that either. Is this one fix covering both pipelines, or
  does the qa side need its own?
- Which unit owns the close? `dw-merge` is where the last task lands, but a story can
  also be finished by hand, and then nothing runs.

## Status

- **Completed: 2026-08-03** — `dw-merge` now closes a story's `plan` and `test-plan` issues on the condition it already computes for the story file, all tasks closed; both rules state who closes a plan (PR #111).
- Created: 2026-08-03
- Issues: ✅ #110 (PR #111)
