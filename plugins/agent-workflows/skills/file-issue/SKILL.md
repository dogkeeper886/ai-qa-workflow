---
name: file-issue
description: |
  Turns something said in a session into a tracked issue that a cold agent can act on, and
  saves the raw session beside it wherever one can be had — always attempted, never a
  reason to withhold the issue. Decides
  first whether the thing needs tracking at all, searches for an existing issue before
  creating a second one, quotes the request in the words it was made in rather than
  paraphrasing it, and states an acceptance test someone else can check. Creates the
  portal every later step resolves back to.
when_to_use: |
  Use whenever work is identified but not started — "this is broken", "we should track
  this", "file an issue", "raise a bug", "that's a separate problem", "let's do that
  later", "add it to the backlog", "someone should fix that". Reach for it when a session
  surfaces a second problem while working on a first, which is the case that most often
  goes unrecorded. Do not reach for it for a question, a thing already being done, or a
  fix smaller than the issue describing it.
argument-hint: "[what to file]"
---

# File an issue

Target: $ARGUMENTS — what to file, or the thing just discussed.

**The issue is a portal, not a record.** Everything after it resolves backwards through
it: a branch takes its name, a commit cites it, a PR closes it, and an agent picking up
cold reads it first. What it cannot do is carry the reasoning that produced it — an issue
body is a summary by nature, and summarising is where the intent shifts.

So the split is: **the issue states the decision and the test; the session log holds the
reasoning.** The issue links to the log rather than absorbing it.

**The point is to make the platform pay off.** Every act below is a `gh` or `glab` call a
person could make themselves. The value is not having to remember which, not having to
notice the two CLIs disagree, and not having to write a body that a stranger can act on
from a standing start. Where this skill would add a step the platform does not need, it is
wrong — process invented on top of a tracker is a cost the tracker was supposed to remove.

## 0. Which platform

**Derive it, never assume it.** `git remote get-url origin` names the host. No address
belongs in this file: one a person has to keep correct goes stale silently.

| | GitHub — `gh` | GitLab — `glab` |
|---|---|---|
| create | `gh issue create --body-file <f>` | `glab issue create -d "$(cat <f>)"` — there is no `--body-file` |
| search | `gh issue list --search "…" --state all` | `glab issue list --search "…" --in title,description --all` |
| comment | `gh issue comment` | `glab issue note` |
| label | `gh issue edit --add-label` | `glab issue update --label` |
| change request | `pr` | `mr` |
| templates live in | `.github/ISSUE_TEMPLATE/` | `.gitlab/issue_templates/`, reachable as `--template <name>` |

Both read the repository from the git remote, so neither takes a `--repo` argument from
inside the clone.

**Linking differs, and it is the one place to stop and say so.** GitHub carries dependencies
natively. GitLab's blocking relationships are a paid tier; on a free instance the reachable
verb is `--linked-issues` with `--link-type relates_to`, which records a relation but does
not gate anything. Say which you got — a relation reported as a dependency is a promise the
platform will not keep.

## 1. Should this be an issue at all

The judgment the whole workflow rests on. File too eagerly and the tracker fills with
things nobody closes; too reluctantly and the work happens with no record.

**Do not file:**

- A question the reply answers.
- A fix smaller than the issue describing it. A typo takes ten seconds; the issue takes
  two minutes and a close.
- Thinking aloud, exploring an idea, weighing an approach. A decision is not yet made.
- Something already being done in this session and about to be committed.

**Do file:**

- A second problem surfaced while working on a first. **This is the case that goes
  unrecorded most often** — the session ends and the observation dies with it.
- Anything that will be picked up by someone, or something, other than this session.
- A decision made here that later work must not silently reverse.

**Uncertain? Ask.** A user who says "we should probably…" has not decided. One question is
cheaper than an issue nobody wanted.

## 2. Search before creating

    gh   issue list --search "<key terms>" --state all --limit 20
    glab issue list --search "<key terms>" --in title,description --all --per-page 20

`glab` lists open issues by default, so `--all` is what reaches closed ones too. There is
no `--state` flag on it. The pair above asks both platforms the same question: open and
closed, capped at twenty.

A second issue for the same thing splits its history, and nothing says which one is live.
On a hit, comment on the existing issue instead and say that is what you did.

## 3. Save the session, where it can be had

**Always attempt it. Never block on it.** The log is worth real effort — it is the only
place the reasoning behind a compressed body survives — and it is never a reason to hold
back an issue. The issue has to stand on its own: a reader should never *need* the log to
act, and should almost always *have* it. Where a raw session can be obtained, write it to
`.sessions/<YYYY-MM-DD>-<slug>.md`, commit it, and link it from Context. Where it cannot,
file the issue anyway and leave Context out. An issue withheld for a missing record is
worse than an issue without one.

What the log buys when it exists: the reasoning the body had to compress. A body states
the decision; the log is where the alternatives, the dead ends and the phrasing that
produced the decision survive.

**Raw. Whole. Unedited.** No summary, no "key decisions" section, no extraction. The
moment anyone decides what mattered, the thing that mattered and was not obvious is gone.
That is the drift this whole design exists to remove, and it is undone by one helpful edit.

Put a generated heading index above the transcript so a later reader can find a section
without reading to it:

    grep -n '^#' <log> | sed 's/^/  /'

Headings and line numbers, nothing else. Generating an index is not summarising: it adds no
judgment and removes nothing. Write it by that command rather than by hand, because a
hand-written index is a summary wearing an index's clothes.

## 4. Pick the template and fill it

The body skeleton is not in this file. It ships as a template, so that a person filing
through the web interface gets the same sections an agent does:

| The thing is | Template | The sections it exists for |
|---|---|---|
| something broken | [templates/bug.md](templates/bug.md) | **Root cause** and **Proposed fix** — a bug without either is a report, not an issue |
| something to build or change | [templates/task.md](templates/task.md) | **Plan**, **Expected outcome**, **What's next** |

Both carry What · Why · Done when · Context · Out of scope. **The list is a floor.** A
kind that needs a section neither template has gets it, and the template gains it
afterwards.

**The project's copy wins.** Look in `.github/ISSUE_TEMPLATE/` or
`.gitlab/issue_templates/` first and fill what is there. The templates beside this skill
are the starting point, not the authority — a project that has edited its own has made a
decision, and overwriting it with the shipped version reverses that decision silently.

Where the project has none, place these there rather than filling them from here, so the
CLI and the web form agree from then on. On GitLab the flag reads that directory directly:
`glab issue create --template bug`.

Where the project's copy is missing a section this skill requires — root cause, proposed
fix, the session link — add the section to the body and say you did. Do not edit their
template as a side effect of filing one issue.

### The four rules the template cannot enforce

**Quote, do not paraphrase.** "The report reads as a wall when it lands in Slack" is what
was said. "Improve report formatting" is what an agent does with it, and the two are not
the same instruction. Paraphrase is the first place intent shifts, and it happens before
anyone can notice.

**"Done when" is the whole issue.** An acceptance line a third party can check is what
makes this pickable cold. *"No open Sev-1 defects and 95% of planned cases executed"* is
checkable; *"quality is acceptable"* is not. If you cannot write one, the thing is not
ready to be an issue, and the honest move is to say so rather than file it anyway.

**"Out of scope" is load-bearing.** It records a decision, so a later gap reads as a known
tradeoff rather than an oversight, and it is what stops the next agent widening the work.

**Link, never inline.** Pasting the session into the body is the summarising failure by
another route: it makes the issue unreadable and the log redundant at once.

## 5. Create it, and say where it went

    gh   issue create --title "<states the problem, not the fix>" --body-file <f>
    glab issue create --title "<states the problem, not the fix>" -d "$(cat <f>)"

Then set whatever label marks *ready to be picked up* in this project. Where the project
declares none, say so rather than inventing one.

Blocked by something? Record it as a real edge where the platform has them, and report
what you actually got — see step 0.

## Steps

Copy this checklist and tick each item as you finish it:

    Task Progress:
    - [ ] Platform derived from the git remote, not assumed
    - [ ] Decided it needs tracking — and said why, if it was close
    - [ ] Searched for an existing issue
    - [ ] Session saved and linked, or its absence accepted and Context omitted
    - [ ] Template picked (bug or task) and every section filled
    - [ ] Issue created, labelled; linking reported as what the platform gave
    - [ ] Verdict reported

## Report

Two lines and a question:

    FILED — #42, blocked by #38, session at .sessions/2026-08-16-report-wall.md
    Next: nothing. It is pickable when #38 closes.
    Want the body?

When it was decided *not* to file, that is still a verdict and still needs saying:

    NOT FILED — a typo fix, already done in this session.
    Next: nothing.

And when it should be filed but was not — the body is written and creation was deferred,
usually because someone asked for it that way:

    DRAFTED — body written to <path>, not on the platform.
    Next: create it, or say what to change first.

**Say which of the three it was.** A draft reported as filed is the worst of them: the work
looks tracked and nothing is.

The body, the search results and the session path are prepared and held until asked.
