---
name: review-work
description: |
  Judges what state finished work is actually in, and routes it there. Checks the
  acceptance line against the work rather than against the claim about it, sweeps what the
  change left behind, and sends the result onward, back for more, back to the issue, or up
  for splitting. Only one of its five outcomes reaches a change request, which is the point
  of having it.
when_to_use: |
  Use after work has been done and before anything ships it, every time, whatever kind it
  is. Triggers: "review this", "check my work", "is this done", "did that work", "have a
  look", "ready to ship?", and the end of any do-task run. Reach for it on evidence work
  too, where there is no diff to read and the question is whether the act is proven. Not
  for judging prose or a document's look, and not for opening a change request.
argument-hint: "[issue-number]"
---

# Review the work

Target: $ARGUMENTS — the issue whose work is being judged.

**The author already said what state it is in. This decides whether that is true.** An
author grading their own work grades it done, not from dishonesty but because the gap
between what was intended and what exists is invisible from inside. That gap is the only
thing this unit looks for.

**Four of its five outcomes do not advance.** A reviewer that always passes work along is a
formality, and the four other states are the ones that go unrecorded today: work quietly
half-finished, work stuck with nobody told, two tasks wearing one number, work never
started because a precondition was false.

## 0. Which platform

Derive it from `git remote get-url origin`. Only the verbs this unit needs:

| | GitHub — `gh` | GitLab — `glab` |
|---|---|---|
| comment | `gh issue comment <N> --body "…"` | `glab issue note <N> -m "…"` |
| unassign | `gh issue edit <N> --remove-assignee @me` | `glab issue update <N> --unassign` |
| move state | `gh issue edit <N> --add-label <a> --remove-label <b>` | `glab issue update <N> --label <a> --unlabel <b>` |

## 1. Read both sides

**What was asked**: the issue, its acceptance line, its `Out of scope`, and any comments
added since it was claimed.

**What exists**: the diff against the branch point, or for evidence work, the commands and
output recorded on the issue.

Read them in that order. Reading the work first anchors you to what was built, and the
question is whether what was built is what was asked for.

## 2. Does the acceptance line hold

Take each box in `Done when` and answer it from the work, not from the report about the
work. A claim is satisfied when it was observed.

**Run what the project runs.** Not because the author would not have, but because "the
suite passed" and "the suite passed on what is committed" are different sentences, and only
one of them is checkable now.

Find it in what the repo actually declares: a package manifest's scripts, a `Makefile`, a CI
workflow, a task runner's config, the commands the project's own instructions name. Run the
full set here rather than the one file that was being iterated on.

**Where nothing runnable exists** — a docs repo, a markdown toolkit — say so plainly and
move on. That is a fact about how far this verdict can reach, not a failure, and "there is
no test suite" tells a reader more than an unqualified *verified*.

**For evidence work, the question is different**: does the record prove the act happened?
Commands as run, output verbatim, before and after state. A tidy summary of an operation is
not evidence of it, and neither is the absence of an error.

**Scope, both directions.** Work that widened past `Out of scope` is a finding even when
every added line is good. Work that quietly narrowed is the more common one, and it looks
like done.

## 3. What did it leave behind

The part no diff reader does, because the evidence is repo-wide rather than in the diff:

- **Debris this change added.** Debug output, commented-out blocks, a skipped test, a
  hardcoded stub, a flag flipped and forgotten. Only what this change added; pre-existing
  mess gets mentioned, not swept.
- **Orphans this change made.** An import, a file, a fixture whose last user went with the
  change. Verify by search before removing anything, and removing a whole file needs
  approval rather than judgement.
- **Facts this change updated in one place and not another.** A count in prose, a version in
  a diagram, a name in a generated artifact. These are the ones that survive every review,
  because each copy reads correctly on its own.

**Report what you find; do not quietly fix it.** A reviewer that edits on its own initiative
hands back work nobody has seen, and the author cannot tell a finding from a change. Fix on
request, smallest blast radius first, and re-run the tooling afterwards — a cleanup that
breaks the build is worse than the debris it removed. **Removing a whole file needs explicit
approval**, whatever the search says.

## 4. Route it

Five states, and the destination is part of the judgment:

| State | Where it goes | What has to be true |
|---|---|---|
| **done** | onward — a change request, or the evidence close | Every acceptance box observed, scope held, nothing left behind |
| **half done** | back for more work | Real progress, and the remainder is clear enough to name |
| **stuck** | back to the issue, unassigned | Blocked on something the doer cannot resolve |
| **more than one task** | up, for splitting | Two or more deliverables wearing one number |
| **not started** | back to the issue | A precondition was false before anything was touched |

**Disagreeing with the author is the job.** If the work reports done and an acceptance box
is not observable, the state is half done and saying so is the entire value of this pass.
Agreement reached by not looking is worth nothing.

**"Done" is the expensive one.** Everything downstream trusts it; the other four cost a
message.

## 5. Record the route

The judgment belongs on the issue, not only in the reply. Someone picking this up next week
reads the issue.

- **done** — say so and what was checked. Nothing else moves; the change request or the
  evidence close handles the rest.
- **half done** — comment with what remains. Leave it assigned; it is still being worked.
- **stuck** — comment with what blocked it and who could unblock it, then unassign and move
  the state label back. An issue left assigned to someone who has stopped is invisible.
- **more than one task** — comment with where the seam is, so the split does not start from
  scratch.
- **not started** — comment with which precondition was false. That is usually a finding
  about the issue rather than the work.

## Steps

Copy this checklist and tick each item as you finish it:

    Task Progress:
    - [ ] Platform derived from the git remote, not assumed
    - [ ] Read what was asked, then what exists, in that order
    - [ ] Every acceptance box answered from the work, not the report
    - [ ] Project tooling run, or its absence stated plainly
    - [ ] Scope checked both ways — widened and narrowed
    - [ ] Debris, orphans and half-updated facts found and reported
    - [ ] State decided, and disagreement with the author stated if any
    - [ ] Route recorded on the issue

## Report

Two lines and a question:

    HALF DONE — reported done, but the second acceptance box has no test covering it.
    Next: add the test, then this passes.
    Run it, or see the findings?

Passing reads the same, and says what made it a pass:

    DONE — both acceptance boxes observed, suite green on the committed tree, nothing left
    behind.
    Next: open the change request.

A route away from the work is still a verdict:

    STUCK — the migration needs a maintenance window nobody has scheduled.
    Next: #52 unassigned and commented; someone books the window.

The two that are easiest to leave unsaid, because neither feels like a result:

    MORE THAN ONE TASK — the schema change is done; the UI half has not started and
    ships separately.
    Next: split #47, then this half is ready.

    NOT STARTED — the precondition is false: staging is already on 16.
    Next: someone confirms whether #52 is stale before anything runs.

The findings, the tooling output, the sweep and the trace are prepared and held until asked.
