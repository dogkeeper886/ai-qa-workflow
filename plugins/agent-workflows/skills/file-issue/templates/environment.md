<!--
TITLE: name the end state, not the activity.
  good — Staging runs Postgres 16 with the same extensions as production
  bad  — Upgrade the database          (from what, to what, where)
  bad  — Postgres work                 (a topic)

REQUIRED — a change with these five can be judged by someone who was not here:
  What · Blast radius · Plan · Rollback · Done when

ALSO REQUIRED when an agent files this:
  Context

OPTIONAL:
  Why · Window · Approval · Out of scope

WHICH TERMINAL: this kind goes both ways, and the answer decides how it closes.
  Infrastructure as code → a diff. Closes by merging, like any code change.
  Done by hand           → evidence. Closes on the issue, with output attached.
The sections are the same either way. do-task decides which, and says so.

Rollback is the section that separates this from code work. A commit reverts; a migrated
database does not. Confirm a known-good state exists and that the rollback has actually
been run somewhere, rather than asserting it would work.
-->

## What

<the change, stated as the end state: what is true afterwards that is not true now>

## Why

<what breaks, costs, or stays blocked without it>

## Blast radius

<everything this can reach, named — not "the cluster">

- Services, endpoints, queues, tables touched:
- Environments affected, and which are not:
- Stateful? <data that cannot simply be recreated>
- Identity, network or permission changes? <these widen the radius further than they look>
- Is anything here in a recent incident? <a fragile area raises the risk of an ordinary change>

An unstated blast radius is the most common reason a routine change becomes an outage.
Naming it is also what lets someone else judge whether the plan below is proportionate.

## Plan

<the steps, in order, each one a thing someone could execute>

1. <step> → verify: <how you know it worked>
2. <step> → verify: <how you know it worked>

## Rollback

<how to get back, specifically>

- Known-good state to return to:
- The command or procedure:
- Has this rollback actually been run anywhere? <where, and when — or say it has not>
- How long it takes:
- What cannot be rolled back: <name it, or say nothing>

"We can revert" is not a rollback plan. A plan nobody has run is a hypothesis.

## Window

<when this may happen, and whether anything must be quiet while it does>

Omit if it can happen any time. Saying so is useful.

## Approval

<who has to agree before this runs, if anyone — and whether they have>

## Done when

- [ ] <observable, checkable by someone who was not here>
- [ ] The end state verified from outside the change itself
- [ ] Rollback still available, or explicitly no longer needed

## Context

Session: `.sessions/<session-uuid>.jsonl`
<the part worth reading, by heading or line range>

## Out of scope

<what this deliberately does not cover, so a later gap reads as a decision>
