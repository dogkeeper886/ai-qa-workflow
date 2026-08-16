---
name: take-issue
description: |
  Picks up a tracked issue and claims it: resolves which one, reads it whole along with the
  session it links, judges whether it can actually be started, and refuses it back when it
  cannot. Assigns it, sets the state label, cuts the branch, and stops before writing any
  code — so a misreading is catchable while it is still cheap. The read half of an issue;
  something else does the work.
when_to_use: |
  Use whenever work is about to start on something already tracked — "work on #42", "what's
  next", "pick something up", "grab the next one", "I'll take that", "what should I do now",
  "start on the parser bug". Reach for it before any code is written, including when the
  issue number is already known and the work looks obvious, because the point is to read
  the issue rather than to remember it. Not for filing something new, and not for doing the
  work once it is claimed.
argument-hint: "[issue-number]"
---

# Take an issue

Target: $ARGUMENTS — an issue number, or empty to take the next one available.

**This claims, it does not build.** It ends with an issue assigned, a branch cut, and a
statement of what was understood. Nothing in the working tree changes. That gap is
deliberate: it is the last cheap moment to catch a misreading, and reading an issue wrong
is the failure that survives every later review, because every later review checks the work
against the misreading.

**It is also the test of the issue.** An issue that cannot be started without asking a
question is thin, and here is the only place that is discoverable.

**The point is to make the platform pay off.** Every act below is a `gh` or `glab` call a
person could make themselves. The value is not having to remember which, not having to
notice the two CLIs disagree, and not having to assemble the issue, its comments and its
links by hand. Where this skill would add a step the platform does not need, it is wrong —
process invented on top of a tracker is a cost the tracker was supposed to remove.

## 0. Which platform

Derive it — `git remote get-url origin`. Only the verbs this skill needs:

| | GitHub — `gh` | GitLab — `glab` |
|---|---|---|
| read, with comments | `gh issue view <N> --comments` | `glab issue view <N> --comments` |
| frontier | `gh issue list --state open --label <ready> --search "no:assignee"` | `glab issue list --label <ready> --output json --jq '[.[] \| select(.assignees\|length==0)]'` |
| claim | `gh issue edit <N> --add-assignee @me` | `glab issue update <N> --assignee <username>` |
| move state | `gh issue edit <N> --add-label <in-progress> --remove-label <ready>` | `glab issue update <N> --label <in-progress> --unlabel <ready>` |

**Unassigned is not a flag on either.** `gh` reaches it through search syntax;
`glab` has no unassigned filter at all — `--not-assignee` takes a username, not a blank —
so it needs JSON and a filter expression. That asymmetry is why the frontier is worth
writing down once rather than improvising per run.

**Moving a state means removing the old label, not only adding the new one.** Both CLIs
can (`gh --remove-label`, `glab --unlabel`) and it is the easiest half to forget. An issue
carrying `ready` and `in-progress` at once keeps coming back in the frontier, so the next
run offers work somebody already took.

`@me` is documented on `gh issue edit --add-assignee` and on `glab issue list --assignee`.
`glab issue update` takes a username, so resolve it rather than assuming the shorthand
carries across.

## 1. Resolve the portal

**Given a number**, that is the portal. Take it even if something else looks more urgent —
choosing for the user is not this skill's job.

**Given nothing**, run the frontier: open, carrying the project's ready-to-pick-up label,
unassigned, and not blocked. First in that set wins.

**Blocked-ness is not equally knowable.** GitHub answers it natively. On a free GitLab the
blocking relation is a paid feature, so what is reachable is a link that records a relation
and gates nothing — read the linked issues and judge it yourself, and say that is what you
did. Reporting an unverified frontier as verified is worse than reporting a short one.

**Empty frontier is an answer.** Report it and stop. Do not widen the query until something
appears; a frontier that had to be relaxed to produce work is not a frontier.

## 2. Read it whole

Body, every comment, labels, linked issues. Comments are where an issue is amended, and an
issue read without them is read at the moment it was filed rather than as it stands.

**If the issue links a session log**, open it and read the part it points at. A body has
to compress; the log is where the reasoning behind it survives, so it is the cheap way to
recover intent the issue could not carry.

**A session log is an accuracy aid, not a requirement.** Most issues will not have one, and
none of them is unpickable for lacking it. Say it was absent and proceed on what the issue
says. Refusing work because a record is missing would make the record more important than
the work, which is backwards.

## 3. Is it pickable

Refuse, and name the gap, when any of these is true:

| The issue | Why it is not pickable |
|---|---|
| has no acceptance line | Nothing says when it is done, so nothing can say it was done wrong |
| has an acceptance line nobody else could check | "Quality is acceptable" hands the judgment back to whoever wrote it |
| is blocked, and the blocker is open | The work would be redone |
| is assigned to someone else | Two people on one issue is worse than nobody. Assigned to **you** is not a refusal — that is resuming, and it is the common case |
| describes a symptom with no reproduction, and is a bug | The first act would be inventing one |

**Refusing costs one message. Guessing costs the whole change.** A guess made here is
invisible afterwards: the branch, the commits and the review all inherit it, and every one
of them checks the work against the guess rather than against the need.

**Offer the fix, do not just name the gap.** A refusal that ends at "this has no
acceptance line" leaves the user with the same problem plus a delay. Propose the line, and
on a yes write it to the issue and take it in the same turn — the tracker gets better and
the work starts, which is the whole point of standing between a person and the platform.

Where it is close, ask rather than refusing. "Done when says the report is clearer —
clearer measured how?" is one question and it makes the issue permanently better.

## 4. Claim it

Three acts: a branch, an assignee, a state label. **Local first, so a failure costs
nothing that anyone else can see:**

    1. branch   issue-<N>-<slug>, cut from the default branch derived rather than assumed.
                Where the project declares its own pattern, that wins; this is the default.
                Branch already there? Check it out. Resuming is not an error.
    2. assign   to yourself
    3. label    move the state — new label on, old label off

If 2 or 3 fails, undo backwards: delete the local branch, unassign. A half-claim is worse
than none — a branch with no assignment reads as unclaimed work, and an assignment with no
branch reads as work in progress nobody can find. Say which of the three landed rather than
reporting the claim as whole.

## 5. Say what you understood

The output is a reading, offered for correction:

- what this issue is asking for, in your words rather than its
- what "done" means, quoted from the acceptance line
- what you will not touch, from Out of scope
- where a log exists and disagrees with the issue — **the log wins on reasoning, the issue
  wins on scope**. With no log, the issue is the whole of it and nothing is missing

Then stop. The next act is somebody's decision, not this skill's.

## Steps

Copy this checklist and tick each item as you finish it:

    Task Progress:
    - [ ] Platform derived from the git remote, not assumed
    - [ ] Portal resolved — number in hand, or frontier reported empty
    - [ ] Issue read whole, comments included
    - [ ] Session log read if the issue links one — absent is normal, not a blocker
    - [ ] Pickable — or refused, with the gap named
    - [ ] Branch, assignee, state label — all three, old label removed
    - [ ] Reading stated, and stopped

## Report

Two lines and a question:

    TAKEN — #42, on issue-42-report-wall. Done when: a report reads in under 30 seconds.
    Next: implement it.
    Run it, or see what I understood?

A refusal is a verdict and reads the same way:

    NOT PICKABLE — #51 has no acceptance line; nothing says when it is done.
    Next: add one to #51, then take it again.

The reading, the frontier query and the session excerpt are prepared and held until asked.
