---
name: do-task
description: |
  Does the work a claimed issue describes — writes and commits the change, or performs the
  act and captures the evidence that it happened. Holds the scope the issue set, records
  why in the commit message rather than only what, and ends by stating what state the work
  is actually in rather than declaring it done. The write half of an issue; something else
  judges whether it finished.
when_to_use: |
  Use once an issue is claimed and the work should start, whatever kind it is — "implement
  it", "fix it", "make the change", "go ahead", "do it". Code: "write the parser fix".
  Docs: "update that README". Environment: "run the staging upgrade". Operations: "rotate
  the cert now", "run the migration", "restart it". Reach for it after take-issue has
  claimed something, and when the user says do it on work already understood. Not for
  choosing what to work on, not for opening a change request, and not for deciding whether
  the result is good enough — each of those is somebody else's job.
argument-hint: "[issue-number]"
---

# Do the task

Target: $ARGUMENTS — the claimed issue, or the one just picked up.

**This writes; it does not judge.** It ends with a commit or a captured act, and a plain
statement of what state the work is in. Deciding whether that state is *done* belongs to
the pass after this one — an author grading their own work grades it done, which is why the
grading is somebody else's.

**Two modes, and the issue already says which.** Work ending in a diff writes files and
commits them. Work ending in evidence performs an act and records that it happened. A
certificate rotation produces no patch; the record of the commands and their output is the
only proof it occurred.

## 0. Which platform

Derive it — `git remote get-url origin`. Only the verbs this skill needs:

| | GitHub — `gh` | GitLab — `glab` |
|---|---|---|
| comment | `gh issue comment <N> --body "…"` | `glab issue note <N> -m "…"` |
| close with evidence | `gh issue close <N> --comment "…"` | **two commands** — `glab issue note <N> -m "…"` then `glab issue close <N>` |

**`glab issue close` takes no comment.** Note first, close second. Reversed, a failed note
leaves a closed issue with no record of what was done — and a closed issue is the one nobody
looks at again.

## 1. Know what you are doing

Read the claim before touching anything: the issue, its comments, the reading `take-issue`
stated, and the branch — or the absence of one, which means this ends in evidence.

**No claim to read?** "Just fix it" is what people actually type, and it arrives with no
assignee, no stated reading, and often no issue. That is workable, not an error — say which
you have and carry on:

| What is missing | What to do |
|---|---|
| the branch | Decide the mode yourself: does this end in a diff or in evidence? |
| the stated reading | Read the issue and state your own before starting. It is the cheap moment |
| the issue itself | Do the work if it is small. If it is not, say so — untracked work of any size is invisible the moment this session ends |

Never invent a claim. Reporting an issue as claimed when nothing on the platform says so is
worse than working without one.

**Three sources, three authorities.** They disagree more often than anyone expects:

| Source | Binds on |
|---|---|
| the code | **reality** — what is true now, whatever anything says |
| the issue | **scope** — what this change may touch |
| the log | **nothing.** It informs |

A log that seems to forbid something is not a constraint; it is a previous person's
situation, recorded under conditions that may no longer hold. Where the issue and the code
disagree about what exists, the code is right and the issue needs a comment.

## 2. Hold the scope

**`Out of scope` is binding.** It is the one section written specifically to stop the next
person widening the work, and that next person is now you.

Finding something else worth doing is normal and is not permission. File it, or say it in
the report, and carry on with what was claimed. A change that quietly grew is a change
nobody agreed to, and it is the review that pays for it.

Where the issue's scope turns out to be wrong rather than merely narrow — the fix is
impossible inside it — stop and say so. That is a finding, not an obstacle to route around.

## 3. Do it

**Ending in a diff:** write the change. Run whatever the project runs — tests, typecheck,
build — and run it because a claim is verified when it was observed, not when it was
expected.

**Ending in evidence:** work the procedure the issue gives, in order. Where a step is
destructive or order-dependent, do not vary it. Capture as you go rather than
reconstructing afterwards:

- the commands, exactly as run
- their output, verbatim
- the state before and after
- when, and by whom

**Verify from outside the change.** Checking with the tool that made it proves the tool
ran, not that the world changed. A different vantage point is the whole value of the check.

**Stop on a surprise.** A precondition that is false, an output that does not match, a step
that fails halfway — these end the run and go into the report. An operation abandoned
mid-procedure leaves the system in neither state, and the report is what tells someone.

## 4. Record it

**A diff:** commit to the claimed branch, citing the issue.

The message carries **why**, not only what — the diff already shows what. Code says what it
does and tests say what it is for, but nothing except this message says why it was done this
way rather than the other way. When the code is deleted, its story goes with it and the
message is what survives.

**Evidence:** put it on the issue, then close it — note first, close second, per step 0. The
issue is the only place this act is recorded, so the comment carries the commands, the
output and the before-and-after state, not a summary of them.

**Do not close an issue that ends in a diff.** The change request closes it on merge, and
closing by hand strands the branch.

## 5. Say what state it is in

Not a verdict — a state, honestly named. The pass after this one routes on it, and it can
only route on the truth:

| State | What it means |
|---|---|
| **done** | The acceptance line is satisfied, and you checked rather than assumed |
| **half done** | Real progress, the rest is clear and doable |
| **stuck** | Blocked on something you cannot resolve — say what, and who can |
| **more than one task** | This is two or more pieces of work wearing one issue number |
| **not started** | A precondition failed before anything was touched |

**"Done" is the claim that costs most to get wrong**, because everything downstream trusts
it. Everything else is cheap to say and cheap to act on.

## Noticing other issues

While in here you will see issues that are already satisfied, stale, or done by something
else. **Say so; never close them.** An issue that looks done can be a false positive, and
closing one wrongly removes it from the board while the work stands undone.

One line in the report: *"#38 looks already satisfied by <evidence>; close it?"* That is a
board tidied by work already happening, rather than a sweep nobody reaches for.

## Steps

Copy this checklist and tick each item as you finish it:

    Task Progress:
    - [ ] Platform derived from the git remote, not assumed
    - [ ] Claim read — issue, comments, the stated reading, branch or no branch
    - [ ] Mode known: ends in a diff, or ends in evidence
    - [ ] Work done, and verified from outside itself
    - [ ] Recorded — committed with why, or evidence on the issue then closed
    - [ ] Scope held; anything found outside it reported, not absorbed
    - [ ] State named honestly, not graded
    - [ ] Other issues noticed along the way — offered, never closed

## Report

Two lines and a question:

    HALF DONE — parser fixed and tested; the error message rewrite is untouched.
    Next: finish the message rewrite, ~20 min.
    Run it, or see what changed?

An evidence run reports the same way, with what proves it:

    DONE — cert rotated on staging, expiry now 2027-02-14, verified from an external probe.
    Next: nothing. #51 closed with the commands and output attached.

A surprise is a state, and reads the same:

    STUCK — the migration needs a maintenance window nobody has scheduled.
    Next: someone books the window, then this resumes from step 3.

The two states easiest to leave unsaid, because neither feels like a result:

    MORE THAN ONE TASK — #47 is a schema change and a UI change; they ship separately.
    Next: split it, then take the schema half.

    NOT STARTED — the staging database is already on 16, so the precondition is false.
    Next: someone confirms whether #52 is stale before anything runs.

The diff, the commands, the output and the trace are prepared and held until asked.
