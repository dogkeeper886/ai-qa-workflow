---
name: land-pr
description: |
  Merges an approved change request and cleans up after it: the code lands in the default
  branch, the branch is gone, the issue closes, the labels clear. Asks a person outright
  whether the change was reviewed and tested at this exact head, records that answer, and
  pins the merge to that SHA so a head that moved cannot slip through. Refuses to merge
  without the answer.
when_to_use: |
  Use when an open change request should land — "merge it", "merge PR 30", "land it",
  "ship it", "close out #27", "the PR is approved", "merge and clean up". Being told to run
  this is a request to reach the human gate, never the answer to it. Not for opening a
  change request, and not for work that ends in evidence rather than a diff.
argument-hint: "[pr-number]"
---

# Land the change request

Target: $ARGUMENTS — the change request to merge.

**Merge means one thing: the code is in the default branch, and the branch is merged and
deleted.** Nothing else about it interests the person who asked. Approvals, protected branch
rules, CI that must go green, a merge train, environment promotion — all of that is the
repository's route to the outcome, and this unit walks whatever route this repo requires
without asking anyone to know which.

**If the outcome cannot be reached, that is a verdict.** A failure with what blocked it, or
a revise with what must change first. The one thing this must never do is report *merged*
when the code is not in the default branch.

## 0. Which platform

Derive it from `git remote get-url origin`.

| | GitHub — `gh` | GitLab — `glab` |
|---|---|---|
| state | `gh pr view <N> --json mergeStateStatus,headRefOid,headRefName` | `glab mr view <N>` |
| comment | `gh pr comment <N> --body "…"` | `glab mr note <N> -m "…"` |
| merge | `gh pr merge <N> --merge --delete-branch` | `glab mr merge <N> --remove-source-branch` |
| **pin to a SHA** | `--match-head-commit <SHA>` | `--sha <SHA>` |

**The SHA guard is not optional here.** Both platforms can refuse a merge whose head has
moved. A gate that asks about one commit and then merges another has not gated anything, so
pass the confirmed SHA to the merge itself rather than trusting that nothing changed.

## 1. Can it merge

Read the state: conflicts, required checks, required approvals. A change request that cannot
merge does not need a human gate yet — report the blocker and stop, because asking someone
to confirm work that cannot land wastes the one thing this unit spends.

Note the head SHA now. Everything after this is pinned to it.

## 2. The human gate

**Ask outright: has this change been reviewed and tested at `<head SHA>`?**

Three things that do not answer that question, and the reason each is tempting:

- **A green agent pass.** Whatever ran before this was an agent judging its own family of
  work. This gate is a person's judgment on the change as a whole.
- **Being told to run this.** "Merge PR 30" is a request to *reach* this question, never the
  answer to it. Ask, and wait.
- **A confirmation given for a different head.** A person confirmed the diff they were
  shown. If the head has moved since — or moves mid-run — that confirmation does not carry.
  Ask again against the new SHA.

**On no, or on no answer: do not merge.** Stop and report, with the missing confirmation as
the finding. A refused gate owes the reader the same report a merge does.

**On yes, record it before merging**, so the gate leaves a trace someone can find later:

    gh   pr comment <N> --body "Human review + test confirmed at <SHA>."
    glab mr note    <N> -m     "Human review + test confirmed at <SHA>."

## 3. Merge

Pass the SHA. Use whatever strategy the project uses, and delete the source branch as part
of the merge rather than afterwards:

    gh   pr merge <N> --merge --delete-branch --match-head-commit <SHA>
    glab mr merge <N> --remove-source-branch --sha <SHA>

**Where the repo requires more than a merge command** — an approval you can request, a check
you can re-run, an auto-merge that lands it when requirements are met — do that. The outcome
is the contract, not the command.

## 4. Establish that it landed

**A command that does not return is not a failure.** It may have succeeded and lost the
connection, timed out while the platform completed it, or genuinely failed. All three look
identical from here, and retrying blind risks acting on a merge that already happened.

**Check the remote, not your working copy:**

    git fetch origin
    git log --oneline origin/<default> -5

The local copy is deliberately stale at this point. Deleting the branch returns you to the
default branch *before* the merge commit has been fetched, so every file the change touched
reads as reverted until the fetch. That intervening state is expected and is not data loss.

**Say which you established.** "Merged, verified at `<sha>` on `origin/<default>`" and
"merge state could not be established" are different reports, and only one of them is a
completion.

## 5. Clean up

**The issue.** Read the body for a closure keyword before assuming it closed:

    gh   pr view <N> --json body,closingIssuesReferences
    glab mr view <N>

With a keyword, the merge closed it. Without one, close it by hand and say that is what
happened, because an issue nobody closed reads exactly like an issue nobody finished.

**The labels.** Clear both the pipeline state and any triage state the work carried:

    gh   issue edit <issue> --remove-label <in-progress> --remove-label <triage>
    glab issue update <issue> --unlabel <in-progress> --unlabel <triage>

The triage label is the one nothing upstream removes. Skip this and it strands on closed
work forever, which is how a board fills with things that look actionable and are not.

**The branch and the tree.** The remote branch went with the merge. Remove the local one and
resolve the state step 4 warned about:

    git switch <default>
    git pull
    git branch -d <branch>

`git branch -d` refuses to delete a branch it does not consider merged. That refusal is a
signal worth reading rather than forcing: it means the merge is not visible from here yet,
usually because the pull has not run.

## Steps

Copy this checklist and tick each item as you finish it:

    Task Progress:
    - [ ] Platform derived from the git remote, not assumed
    - [ ] Mergeable — conflicts, checks and approvals read
    - [ ] Head SHA noted; everything after pinned to it
    - [ ] Human asked outright, and answered — not inferred, not assumed
    - [ ] Confirmation recorded on the change request before merging
    - [ ] Merged with the SHA passed to the merge itself
    - [ ] Landing established against the remote default branch
    - [ ] Issue closed, labels cleared, branch gone, back on the default

## Report

Two lines and a question:

    MERGED — PR #30 at a1b2c3d, verified on origin/main. #27 closed, labels cleared,
    branch gone.
    Next: nothing. This has shipped.
    Want the trace?

A refused gate is a verdict and reads the same way:

    NOT MERGED — nobody has confirmed review and test at a1b2c3d.
    Next: someone reviews and tests it, then run this again.

So is an outcome that could not be reached:

    BLOCKED — two required checks are failing, so this cannot land as it stands.
    Next: fix the checks, then run this again.

    UNKNOWN — the merge command did not return and origin/main does not show the commit.
    Next: re-check origin before retrying; a blind retry may act on a merge that landed.

The trace, the checks and the confirmation are prepared and held until asked.
