<!--
TITLE: name the act and its target.
  good — Rotate the staging TLS certificate before it expires on 2026-09-01
  bad  — Certificate work              (a topic)
  bad  — Fix expiring cert             (which cert, where, by when)

REQUIRED — an operation with these five can be run by someone who was not here:
  What · Access · Pre-checks · Procedure · Verification

ALSO REQUIRED when an agent files this:
  Context

OPTIONAL:
  Why · Rollback · Window · Out of scope

ENDS IN EVIDENCE, NOT A DIFF. There is no change request to close this: the issue closes by
hand, with the commands run, their output, and the before-and-after state attached. That
evidence is the only record the act happened, so the slots for it are in the template rather
than left to whoever writes the closing comment.

If nothing here is written down, the act is unrepeatable and its outcome unauditable. Both
matter more here than in code work, where the diff is its own record.
-->

## What

<the act, and what is true afterwards that is not true now>

## Why

<what breaks, expires, or stays blocked without it>

## Access

<what is needed to run this, and who has it>

- Credentials, roles, or keys:
- Hosts, consoles, or networks that must be reachable:
- Anything that must be requested in advance:

An operation blocked halfway for want of access is worse than one not started, because the
system is now in neither state.

## Pre-checks

<what must be true before the first step — verified, not assumed>

- [ ] <condition, and the command that shows it>
- [ ] <condition, and the command that shows it>

These are what stop a correct procedure running against the wrong target. Most operational
damage is a right command in a wrong place.

## Procedure

<the exact steps, in order>

1. `<command>` → expect: `<what it prints>`
2. `<command>` → expect: `<what it prints>`

Where a step is destructive or order-dependent, say so and say not to vary it. Specificity
is matched to fragility here, not minimised.

## Verification

<how you know it worked, checked from outside the change>

- [ ] <observable, from a different vantage point than the command that made it>

Checking the change with the tool that made it proves the tool ran, not that the world
changed. Verify from somewhere else.

## Rollback

<how to undo it, or why it cannot be undone>

- The command or procedure:
- How long it takes:
- What cannot be undone: <name it plainly>

"Cannot be rolled back" is a legitimate answer and a useful one. An unstated inability is
discovered at the worst moment.

## Window

<when this may run, and what must be quiet while it does>

## Evidence to capture

<what gets attached to the issue when this closes>

- [ ] Commands run, as run
- [ ] Their output, verbatim
- [ ] Before-and-after state
- [ ] Who ran it, and when

## Context

Session: `.sessions/<session-uuid>.jsonl`
<the part worth reading, by heading or line range>

## Out of scope

<what this deliberately does not cover, so a later gap reads as a decision>
