---
name: plan-work
description: |
  Splits work too large for one issue into issues that can each be delivered on their own,
  and groups them with whatever the project already uses to group things — a milestone, a
  project board, an epic. Decides first whether splitting is warranted at all, since most
  work is not, and never invents a grouping the platform already provides.
when_to_use: |
  Use when one issue is holding more than one deliverable — "break this down", "what are
  the tasks", "this is too big", "split it", "that's really three things", "plan this
  out", "make tickets for this". Also when take-issue reports that an issue is more than
  one task, which is the case that arrives without anyone asking for a plan. Not for
  ordinary work that happens to have several steps, and not for filing a single issue.
argument-hint: "[issue-number]"
---

# Plan the work

Target: $ARGUMENTS — the issue to split, or the work just discussed.

**Most work should not be split.** An issue with five steps is one issue. Splitting is for
work that holds more than one *deliverable* — pieces that ship separately, get reviewed
separately, or could be done by different people at the same time. Splitting anything else
buys ceremony and pays in issues nobody closes.

**The platform already groups things.** Epics, milestones, iterations, project boards — they
exist, they have views the team already reads, and a hand-rolled parent issue with child
links drifts from whatever the board actually says. Use what is there.

## 0. What this platform can actually do

Derive the host — `git remote get-url origin` — then note that **neither CLI gives a
complete decomposition primitive.** Check before promising a structure:

| | GitHub — `gh` | GitLab — `glab` |
|---|---|---|
| create a grouping | `gh project create` · milestone via `gh api` | `glab milestone create` |
| attach an issue | `gh issue create -m <milestone> -p <project>` | `glab issue create --milestone <m> --epic <id>` |
| parent / child | sub-issues via `gh api` only — no first-class verb | epic only, and epics are a **paid tier** |
| sprint | a Project iteration field | `glab iteration` is **read-only** |
| weak fallback | — | `--linked-issues` — records a relation, gates nothing |

**Say what you got.** On a free GitLab there is no epic to attach to and no CLI to make one;
the reachable grouping is a milestone. Reporting a milestone as an epic, or a relation as a
dependency, promises structure the platform will not keep.

## 1. Should this be split at all

**Split when** the pieces are independently deliverable — each could be reviewed, merged, or
performed without the others, and each is worth doing even if the rest is dropped.

**Do not split when:**

- The steps are sequential parts of one deliverable. A migration with five steps ships once.
- One piece is real work and the rest is under an hour. File the small ones or fold them in.
- The split is by *layer* rather than by outcome — "the backend part" and "the frontend
  part" of one feature usually ship together and reviewing them apart helps nobody.
- Nobody will work on the pieces in parallel. Then the split is bookkeeping.

**The test:** could someone close one child and leave the others open, and would the board
still make sense? If not, it is one issue.

## 2. Find what the project already uses

Look before proposing. `gh project list` / `glab milestone list` show what exists, and the
issues already carry the answer — an open milestone with issues on it is the project's
grouping whatever anyone says.

**Where the project uses nothing**, ask rather than choosing. Introducing a board is a
decision about how a team works, and it is not this unit's to make. A flat set of issues
with no grouping is a legitimate answer and often the right one.

## 3. Write the children

**File each child rather than writing it here.** A child is a full issue and gets the same
treatment as any other: the kind decided, the matching template filled, the duplicate search
run, an acceptance line a stranger could check. Reimplementing that inside this unit
produces five thinner issues than the same work filed one at a time, which is the opposite
of what a split is for.

- **One deliverable each.** If a child needs its own children, the split was at the wrong
  level.
- **Its kind picks its template**, and the children need not share one. A feature may split
  into code, a doc, and an operation to run afterwards — three kinds, three templates,
  three different acceptance tests.
- **Ordering is a fact, not a wish.** Where one child genuinely cannot start until another
  finishes, record it with whatever the platform offers, and say what that actually
  enforces — see step 0.
- **Every child links the parent's session log**, where one exists. The reasoning behind
  the split is exactly what a body compresses away, and a child picked up next week starts
  cold without it. One link, not a copy.
- **The parent keeps the why.** Children carry their own scope and acceptance; the reasoning
  that led to this split stays in one place rather than being copied five times.

## 4. Attach and report

Create the grouping if the project has one and it does not exist yet, attach every child,
and leave the parent issue pointing at them.

**Do not leave a half-plan.** Five children created and two attached is worse than none —
the board shows a structure that is not there. If attachment fails partway, say which
landed.

## Steps

Copy this checklist and tick each item as you finish it:

    Task Progress:
    - [ ] Platform derived, and its actual grouping support checked
    - [ ] Splitting justified — pieces are independently deliverable
    - [ ] Existing grouping found, or asked for; none is a valid answer
    - [ ] Children written as full issues, each with one deliverable
    - [ ] Ordering recorded, and what it enforces stated honestly
    - [ ] Every child attached, or the partial state reported

## Report

Two lines and a question:

    SPLIT — #47 into #48, #49, #50 on milestone "parser rewrite". #49 waits on #48.
    Next: take #48 — the other two are blocked until it lands.
    Run it, or see the children?

Declining to split is the more common outcome and reads the same:

    NOT SPLIT — #47 is five steps of one migration; it ships once.
    Next: take #47 as it stands.

Where the platform could not carry the structure, that belongs in the first line:

    SPLIT — #47 into #48, #49, #50 on milestone "parser rewrite". No epic: this
    instance has none, and the ordering is a relation that gates nothing.
    Next: take #48, and do not rely on the platform to stop #49 starting early.

The children, the grouping, and the trace are prepared and held until asked.
