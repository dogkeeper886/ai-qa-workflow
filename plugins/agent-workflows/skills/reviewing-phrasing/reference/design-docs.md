# Design Docs, RFCs, and ADRs

## Contents

- Purpose and when to write one
- Standard structure
- Writing the problem statement
- Alternatives considered
- Sizing and status
- Architecture Decision Records
- Review checklist

## Purpose and when to write one

A design doc exists to get a decision made before code is written. Its success metric is reviewer throughput: how quickly a qualified reader can understand the problem, judge the proposal, and either approve it or name a blocking objection.

Write one when the work is hard to reverse, spans more than one component or team, or has more than one plausible approach. Skip it when the implementation is obvious and cheap to undo — a pull request description suffices.

## Standard structure

```
# Title: <what is being built or changed>

Status: Draft | In review | Accepted | Superseded by <link>
Author: <name>
Reviewers: <names>

## Summary
## Problem
## Goals / Non-goals
## Proposed design
## Alternatives considered
## Risks and open questions
## Rollout and validation
## Appendix
```

**Summary** — three to five sentences. What problem, what solution, what the reviewer is being asked to approve. Written last, read first.

**Problem** — the current situation and its concrete cost. Evidence, not assertion: failure rates, hours spent, incidents, support volume.

**Goals / Non-goals** — the non-goals section prevents the most common review derailment, where a reviewer objects that the design fails to solve an adjacent problem it never intended to solve. Name those explicitly.

**Proposed design** — the substance. Component boundaries, data flow, interfaces, data model changes, failure behavior. A diagram here usually earns its place. State what changes and what deliberately stays the same.

**Alternatives considered** — see below.

**Risks and open questions** — what could go wrong, what remains undecided. Open questions belong in the document, not omitted to look confident; an unnamed unknown surfaces during implementation instead of during review, at far higher cost.

**Rollout and validation** — migration path, backward compatibility, how correctness will be demonstrated, how the change can be rolled back.

## Writing the problem statement

The most common failure is a problem statement that presupposes the solution. "We need a validation layer between the agent and TestLink" is a proposal wearing a problem's clothes. The problem is the observed damage: agents write malformed test cases directly to TestLink, corrupted fields are discovered only after test runs fail, and cleanup requires manual database edits.

State the problem so that an alternative solution could plausibly answer it. If only one solution fits the statement, the statement is too narrow.

## Alternatives considered

This section is the primary evidence of design rigor, and it is where reviewers look first for weakness.

For each alternative give: what it is, why it is plausible, and the specific reason it loses. "Too complex" is not a reason. "Requires a schema migration on every TestLink upgrade, which is out of our control" is.

Include the null option — do nothing — when the status quo is survivable. Include any approach a reviewer is likely to raise, because addressing it preemptively saves a review round trip.

Straw men damage credibility. If an alternative is genuinely close, say so and explain what would change the decision.

Tabular form works when the axes are shared:

| Approach | Preserves test IDs | Works offline | Effort |
|---|---|---|---|
| Direct write | No | Yes | Low |
| Validating proxy | Yes | Yes | Medium |
| Vendor plugin | Yes | No | High |

## Sizing and status

Keep the body under roughly 1500 words. Long designs get skimmed, and skimmed designs get approved without scrutiny — the worst outcome. Push schemas, full API surfaces, benchmark data, and transcripts into an appendix.

Carry the status field from the first draft. A design doc without a status is indistinguishable from a decision, and readers will cite it as one.

When a design is superseded, do not delete it. Change the status, link forward, and leave it.

## Architecture Decision Records

An ADR is a design doc compressed to one decision and one page. Use them for choices worth remembering but too small for full review.

```
# ADR-014: Use deterministic literal matching for field validation

Status: Accepted
Date: <date>

## Context
<the forces at play — constraints, requirements, what pushed this to a decision>

## Decision
<what was decided, stated as a fact in active voice>

## Consequences
<what becomes easier, what becomes harder, what is now foreclosed>
```

The consequences section must include the negative ones. An ADR that lists only benefits records advocacy, not a decision, and provides nothing to the future reader trying to understand why the system is shaped this way.

Number ADRs sequentially and never renumber them. Supersede rather than edit.

## Review checklist

```
- [ ] Summary is readable alone and states the ask
- [ ] Problem is evidenced, and does not presuppose the solution
- [ ] Non-goals name the adjacent problems reviewers will raise
- [ ] At least two real alternatives, each with a specific losing reason
- [ ] Failure behavior described, not just the happy path
- [ ] Backward compatibility and rollback addressed
- [ ] Open questions listed rather than hidden
- [ ] Status field present and current
- [ ] Body under ~1500 words; detail pushed to appendix
```
