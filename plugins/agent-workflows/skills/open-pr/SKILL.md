---
name: open-pr
description: |
  Pushes a committed branch and opens the change request that carries it to a human, linked
  to its issue so the issue closes on merge rather than by hand. Moves the commits onto a
  branch first when they landed on the default one, gets the closure keyword right, and
  stops for review. It does not merge, and it does not judge whether the work is good;
  something before it did that.
when_to_use: |
  Use when reviewed work is ready for a human to look at — "open a PR", "raise the merge
  request", "push this up", "ship it", "put it up for review", "my commits are on main, get
  them onto a branch". Reach for it after the work has been judged done, and when someone
  says ship it meaning make it reviewable. Not for work that ends in evidence rather than a
  diff, which closes on its issue and never reaches a change request. Not for merging.
argument-hint: "[issue-number]"
---

# Open the change request

Target: $ARGUMENTS — the issue this change closes, if there is one.

**This makes work reviewable. It does not decide whether the work is good.** That judgment
happened already; re-litigating it here means two passes disagreeing with nobody to settle
it. What this checks is mechanical: is the work committed, is it on a branch that is not the
default, does the body link the issue correctly.

**Evidence work never arrives here.** An act performed leaves no diff to review, and its
issue was closed where the act happened. If there is no branch, this is the wrong unit.

## 0. Which platform

Derive it from `git remote get-url origin`.

| | GitHub — `gh` | GitLab — `glab` |
|---|---|---|
| create | `gh pr create --title "…" --body "…"` | `glab mr create --title "…" --description "…"` |
| target branch | `-B/--base` | `--target-branch` |
| draft | `-d/--draft` | `--draft` |
| body template | `.github/PULL_REQUEST_TEMPLATE.md` | `.gitlab/merge_request_templates/`, via `--template` |
| read it back | `gh pr view <N> --json body,url` | `glab mr view <N>` |

**`-d` means different things.** It is `--draft` on `gh` and `--description` on `glab`.
A command copied between them changes meaning without erroring, which is the worst kind of
difference. Write the long flags.

## 1. Is there anything to push

Four checks, and each has a distinct answer when it fails:

- **Committed?** Uncommitted changes mean the work is not finished being recorded. Stop.
- **On a branch that is not the default?** If the commits are on the default branch, go to
  step 1a before anything else.
- **Anything to push at all?** `git log --oneline origin/<default>..HEAD` empty means there
  is nothing here. Stop and say so.
- **A change request already open for this branch?** Then this is a push, not an open. Push
  and say the existing one was updated.

Derive the default branch rather than assuming `main`.

## 1a. When the commits are on the default branch

This happens, and it is repairable. Repair it, but never silently.

**Show exactly what would move**, and move nothing else:

    git fetch origin
    git log --oneline origin/<default>..HEAD

**If anything in that list does not belong to this change, stop.** Carrying somebody else's
commits onto this branch is not a call this unit makes.

**Ask before touching history.** On a no, hand back and do not continue to the push, because
pushing from the default branch is the thing this step exists to prevent. On a yes:

    git switch -c <branch-name>
    git branch -f <default> origin/<default>

The first carries the commits onto the new branch. The second rewinds the local default to
what the remote already has. Nothing is discarded and the working tree is never touched,
which is why no hard reset appears here.

**The branch name needs the issue number.** With no issue there is nothing to name it from,
so this is the one case where a missing issue stops the run rather than degrading it.

## 2. Write the body

The issue line depends on what this change request does to its issue:

| This change request | Write | Why |
|---|---|---|
| finishes the issue | the closure keyword and the number | the issue closes on merge, not by hand |
| is one of several for it | `Part of #N` | the issue outlives this change, so a keyword would close it early |
| has no issue | nothing | and the report says this closes nothing |

**A closure keyword fires from anywhere in the body.** The parser reads the keyword and the
number and nothing around them, so a sentence explaining that this change must *not* close
#N will close it. On the middle case, write `Part of #N` and do not mention keywords at all.

Keep the body to what a reviewer needs: what changed, and what they should test. Where the
project ships a change request template, fill that instead of inventing a shape.

## 3. Open it, then read it back

**Push with tracking.** A branch cut locally has no upstream, so the first push sets one:

    git push -u origin <branch>

Without `-u` the push succeeds and later commands that ask "where does this branch go" have
no answer.

**Then create it**, body from a file rather than inline so the closure line survives quoting:

    gh   pr create --title "<title>" --body-file <file>
    glab mr create --title "<title>" --description "$(cat <file>)"

**Then read back what it actually linked**:

    gh   pr view <N> --json body,url
    glab mr view <N>

The link is the part that silently goes wrong, and the cost lands later — an issue that
closes early, or one that never closes at all.

Set whatever label marks *under review* in this project, on the issue rather than the change
request. Where the project declares no such label, say so instead of inventing one.

## 4. Stop

A human reviews and tests. This unit does not merge, does not approve, and does not wait.
Say what is open and what the reviewer should exercise, then stop.

## Steps

Copy this checklist and tick each item as you finish it:

    Task Progress:
    - [ ] Platform derived from the git remote, not assumed
    - [ ] Committed, on a non-default branch, with something to push
    - [ ] Commits moved off the default branch if they were on it, after asking
    - [ ] Body written; issue line matches what this change does to the issue
    - [ ] Pushed and opened
    - [ ] Link read back and confirmed
    - [ ] Issue label moved, or its absence stated
    - [ ] Stopped for a human

## Report

Two lines and a question:

    OPEN — PR #30 for #27, closes it on merge. Reviewer should exercise the upgrade path.
    Next: a human reviews and tests.
    Want the body?

When the commits had to be moved first, that belongs in the first line rather than the
detail, because it is the part a reviewer would not otherwise know happened:

    OPEN — PR #30 for #27, after moving three commits off main onto issue-27-parser.
    Main is back to origin; nothing was discarded.
    Next: a human reviews and tests.

An update to something already open is not a new opening:

    UPDATED — PR #30 already existed for this branch; pushed two more commits to it.
    Next: a human reviews and tests.

Refusing is a verdict too:

    NOT OPENED — the tree has uncommitted changes, so this is not finished being recorded.
    Next: commit them, then run this again.

The body, the commit list and the trace are prepared and held until asked.
