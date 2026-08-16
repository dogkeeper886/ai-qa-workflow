<!--
TITLE: state the outcome, not the activity.
  good — Agents can pick up a cold issue without asking a question
  bad  — Improve issue templates       (activity, with no end state)
  bad  — Templates                     (a topic, not a task)

REQUIRED — a task with these four can be started by someone who was not here:
  What · Plan · Expected outcome · Done when

ALSO REQUIRED when an agent files this, because it has the session in front of it
(Context only where a session log actually exists — the issue stands without it):
  Context

OPTIONAL:
  Why · What's next · Out of scope

Estimate, milestone and assignee are platform fields, not sections. Putting them in the
body duplicates state the tracker already holds and answers better.

"Done when" is this task's acceptance criteria, and it is specific to this task. It is not
the project's definition of done — the standing bar every change clears, which belongs in
one project-level document rather than being restated in every issue.
-->

## What

<the ask, quoted in the words it was made in>

## Why

<the problem behind it — what is worse without this>

## Plan

<the steps, in order, each one a thing someone could start on Monday>

1. <step> → verify: <how you know it worked>
2. <step> → verify: <how you know it worked>

A plan is a goal with an order, not a design. Where the approach is genuinely open, say
which decision is unresolved and who makes it, rather than inventing a step to fill the gap.

## Expected outcome

<what is true afterwards that is not true now — the observable end state>

State it as the world after the change, not as the work: "an agent picking up a cold issue
can act without asking a question" rather than "write the template".

## Done when

- [ ] <observable, checkable by someone who was not here>

Pass or fail, with nothing to interpret. "95% of planned cases executed, no open Sev-1"
is checkable; "quality is acceptable" is not.

## What's next

<what this unblocks, and what should follow it>

Name the successor by issue number where one exists. Where the successor is a decision
rather than work, say what has to be decided and what it depends on.

## Context

Session: `.sessions/<date>-<slug>.md`
<the part worth reading, by heading or line range>

## Out of scope

<what this deliberately does not cover, so a later gap reads as a decision>
