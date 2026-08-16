<!--
TITLE: state the observable symptom, not the guess and not the fix.
  good — Import silently drops cases with unicode titles
  bad  — Encoding bug in parser        (a guess; the parser may be innocent)
  bad  — Fix unicode handling          (the fix, before anyone agreed the cause)

REQUIRED — a bug with these four is actionable, and a person filing by hand may stop here:
  What · Reproduce · Environment · Done when

ALSO REQUIRED when an agent files this, because it has the session in front of it
(Context only where a session log actually exists — the issue stands without it):
  Root cause · Proposed fix · Context

OPTIONAL:
  Why it matters · Attachments · Out of scope

Eight required sections is more than the usual five-or-six guidance, deliberately. That
guidance protects a drive-by reporter, and the four above are what it protects. An agent
that has just watched the failure has no such excuse.

Severity and priority are labels, not sections. They are two different things — severity
is how badly it breaks, priority is how soon it must be fixed — and one field collapsing
both is how a critical-but-not-urgent bug gets lost.
-->

## What

<the report, quoted in the words it was made in>

## Why it matters

<what breaks, or what it costs, if this is not fixed — the consequence, not a restatement>

## Reproduce

<the smallest sequence that shows it>

1. <step>
2. <step>

Actual: <what happened, verbatim — error text, status code, log excerpt>
Expected: <what should have happened>
Frequency: <always | N of M attempts>

## Environment

<where it happens, at enough precision that someone else can match it>

- Version / build:
- OS / platform:
- Runtime, browser, or device:
- Configuration that matters:

A bug that passes on one version and fails on another is not flaky. It was
underspecified, and this section is what would have caught that.

## Root cause

<what actually produces the behaviour, traced to a file and a line where possible>

Where the cause is not yet known, say so plainly and say what was ruled out. "Not yet
diagnosed; reproduces on every run, so it is not a race" is a useful line. An empty
section, or a guess written as a finding, is not.

## Proposed fix

<the change, and why this one rather than the alternatives considered>

Name what this does NOT fix if the cause has more than one symptom.

## Done when

- [ ] <observable, checkable by someone who was not here>
- [ ] <the regression test that would have caught this>

## Attachments

<screenshot, recording, log file, capture — whatever shortens the reproduction>

## Context

Session: `.sessions/<session-uuid>.jsonl`
<the part worth reading, by heading or line range>

## Out of scope

<what this deliberately does not cover, so a later gap reads as a decision>
