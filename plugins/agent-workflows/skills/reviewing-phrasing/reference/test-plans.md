# Test Plans, QA Reports, and Bug Reports

## Contents

- Test plans: purpose and structure
- Writing scope and risk
- Test cases: the unit of precision
- QA reports: purpose and structure
- Reporting results honestly
- Bug reports
- Review checklists

## Test plans: purpose and structure

A test plan exists so that someone other than its author can judge whether the testing was adequate, and so that testing effort matches risk rather than habit.

```
# Test Plan: <feature or release>

Status: Draft | Approved
Owner: <name>

## Scope
## Risk assessment
## Test approach
## Environments and data
## Entry and exit criteria
## Schedule and ownership
## Out of scope
```

**Scope** — what is under test, at what level (unit, integration, system, acceptance), against which build or version.

**Risk assessment** — see below. This section justifies everything after it.

**Test approach** — what kinds of testing apply and why: functional, regression, performance, security, upgrade, interoperability. Say which are automated and which are manual, and why the manual ones resist automation.

**Environments and data** — hardware, topology, firmware or OS versions, and the data set. Specify how test data is produced and reset; irreproducible data is the most common cause of unreproducible results.

**Entry and exit criteria** — the conditions to begin, and the conditions to declare done. Exit criteria must be checkable by someone else: "no open Sev-1 or Sev-2 defects, and 95% of planned cases executed" is checkable; "quality is acceptable" is not.

**Out of scope** — as load-bearing as in a design doc. It records a decision, so that a later gap is understood as a known tradeoff rather than an oversight.

## Writing scope and risk

Rank areas by risk, defined as likelihood of failure times cost of failure, and allocate depth accordingly. State the reasoning:

| Area | Risk | Rationale | Depth |
|---|---|---|---|
| Firmware upgrade path | High | Field-irreversible; touched by every deployment | Full matrix across 3 prior versions |
| Config import | Medium | Reworked this cycle; recoverable by re-import | Functional + regression |
| UI theming | Low | Cosmetic, no data path | Smoke only |

This table is what makes a plan reviewable. Without it, a reviewer can only check whether tests exist, not whether the right ones exist.

## Test cases: the unit of precision

A test case is a claim that a specific input under specific conditions produces a specific observable result. Ambiguity anywhere in that chain makes the result unusable.

```
ID: TC-4412
Title: Rejects test case with out-of-range importance value
Preconditions: Validator running against TestLink 1.9.20; project TestLink-QA exists
Steps:
  1. Submit a case payload with importance = 4
  2. Read the validator response
Expected: Response status is `rejected`; error names field `importance`
          and lists accepted values 1, 2, 3. No write occurs to TestLink.
```

Rules that determine whether the case is worth anything:

- **One assertion per case.** A case testing three things reports one result and hides which of the three failed.
- **Expected results are observable and specific.** "Works correctly" and "no errors" are not results. Name the status code, the message, the state.
- **Assert the negative too.** "No write occurs" is often the point of the test, and is invisible unless stated.
- **Preconditions include versions.** A case that passes on one firmware and fails on another is not flaky; it was underspecified.
- **Steps are executable by someone unfamiliar with the feature.** If a step requires knowledge the reader lacks, it is a step missing its predecessor.
- **Title states the behavior asserted, not the action performed.** "Rejects out-of-range importance" beats "Test importance field".

## QA reports: purpose and structure

A report enables a release decision. Structure it so the decision is available immediately.

```
# QA Report: <release / cycle>

## Verdict
## Coverage summary
## Defects
## Known issues and risks
## Environment
## Appendix: full results
```

**Verdict** first, in one line, with the condition attached: *Recommend release, conditional on the fix for DEF-8871 landing.* A report that makes the reader assemble the verdict from tables has failed at its only job.

**Coverage summary** as counts, not adjectives: planned, executed, passed, failed, blocked, skipped — with reasons for anything not executed.

| | Planned | Executed | Passed | Failed | Blocked |
|---|---|---|---|---|---|
| Functional | 210 | 210 | 204 | 6 | 0 |
| Upgrade | 48 | 31 | 31 | 0 | 17 |
| Performance | 12 | 12 | 12 | 0 | 0 |

**Defects** grouped by severity, each with ID, one-line symptom, and status. Link out; do not reproduce full bug detail here.

**Known issues and risks** — what shipped untested, what was deferred, and what the exposure is. This section is where a QA report earns trust.

## Reporting results honestly

Report what was observed, not what the observation implies about anyone's work. Blocked cases are stated as blocked, with the blocker named — not silently folded into "not executed".

Do not round toward comfort. A 94% pass rate is not "essentially passing"; state 94% and let the reader apply the exit criteria.

Separate observation from inference explicitly. "Throughput dropped 40% after the upgrade" is an observation. "The new scheduler is the cause" is an inference and must be labeled as one unless it was isolated.

When testing was insufficient, say so plainly and quantify the gap. A report that conceals thin coverage transfers risk to the release decision without informing it, which is the one failure a QA function cannot recover from.

## Bug reports

Optimize for the reproducer. Everything else is secondary.

```
Title: <observable symptom, one line>
Environment: <build, firmware, OS, topology, browser — whatever varies>
Steps to reproduce:
  1. ...
Expected: <what should happen>
Actual: <what happened, verbatim — error text, status codes, log excerpt>
Frequency: <always | N of M attempts>
Severity: <with a one-line justification>
Attachments: <logs, config, capture, screenshot>
```

- Title the symptom, not the guess: "Import silently drops cases with unicode titles", not "Encoding bug in parser".
- Paste error text verbatim rather than paraphrasing it; the exact string is searchable and the paraphrase is not.
- State frequency. An intermittent bug reported as deterministic wastes a triage cycle.
- Include the last known good version if known — it converts a hunt into a bisect.
- Justify severity in one clause: "Sev-2: data loss, but only on a non-default configuration."

## Review checklists

**Test plan**

```
- [ ] Scope names build/version under test
- [ ] Risk table justifies where depth was spent
- [ ] Exit criteria checkable by a third party
- [ ] Environments specify versions and topology
- [ ] Test data generation and reset described
- [ ] Out of scope recorded as a decision
```

**QA report**

```
- [ ] Verdict in the first line, with conditions
- [ ] Coverage as counts, with reasons for gaps
- [ ] Blocked and skipped cases named, not absorbed
- [ ] Observation separated from inference
- [ ] Residual risk stated explicitly
```

**Bug report**

```
- [ ] Title states the symptom
- [ ] Steps reproduce from a clean state
- [ ] Actual result quoted verbatim
- [ ] Frequency stated
- [ ] Environment complete enough to reproduce
```
