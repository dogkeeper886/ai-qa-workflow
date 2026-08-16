<!--
TITLE: name the reader's problem, not the artifact.
  good — Newcomers cannot find how to run the test suite
  bad  — Update README                  (which part, and why)
  bad  — Documentation                  (a topic, not a task)

REQUIRED — a doc task with these four can be started by someone who was not here:
  What · Who reads it · Done when · Where it lands

ALSO REQUIRED when an agent files this, because it has the session in front of it:
  Context

OPTIONAL:
  Why · What is wrong today · Out of scope

Ends in a diff, so it closes by merging like any code change. Both reviews below are
required before it does: a doc can read beautifully and be wrong, and it can be correct
and unreadable. Neither reviewer catches the other's failure.
-->

## What

<the ask, quoted in the words it was made in>

## Who reads it

<the specific reader, and what they already know>

Not "users" or "developers". A teammate needs no background section; someone arriving from
a search engine needs one. Write for the least informed reader who must act on it, and say
which reader that is, because every structural decision after this follows from it.

## What is wrong today

<the gap: missing, wrong, stale, or unfindable — they need different fixes>

Unfindable is the one most often misdiagnosed as missing. Check before writing a second
copy of something that already exists.

## Where it lands

<the file, and whether it is new or an edit>

If this is a new page, say what links to it. A page nothing points at is unfindable by
construction, which is the failure above.

## Done when

- [ ] <observable, checkable by someone who was not here>
- [ ] Every command, path and flag in it was executed as written, not recalled
- [ ] Technical review: it is true
- [ ] Editorial review: it reads and looks right

The last two are separate people, or at least separate passes. A technically correct page
that nobody can follow has failed, and so has a beautiful page that lies.

## Context

Session: `.sessions/<session-uuid>.jsonl`
<the part worth reading, by heading or line range>

## Out of scope

<what this deliberately does not cover, so a later gap reads as a decision>
