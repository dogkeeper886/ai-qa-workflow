---
name: reporting-outcomes
description: |
  Shapes the ordinary reply that reports back on work — the chat turn carrying
  progress, a verdict, reasons, a summary and a status all at once. Use whenever
  answering with what was done, what was found, whether it worked, where things
  stand, or what is left, and the answer runs longer than a line. Not for
  command or gate output, which already resolves the contract itself. Holds the
  trigger and the mapping; the questions live in `agent-report.md` and the words
  in `project-profile.md` → Reports.
---

# reporting-outcomes

## The shape this catches

An agent finishes a piece of work and writes back. The reply contains, in
whatever order they occurred to it:

> some of what happened · whether it worked · why it was done that way · what is
> still running · what broke · what it means · what is next

Every one of those is worth saying. Together, unsorted, they are a narrative the
reader has to mine. They open the message wanting one thing — *is this good, and
what do I do now* — and get a story they must read to the end twice.

This is the most common shape in an agentic session and the only one with no
contract on it. Gate output has `agent-report.md` wired into the commands that
produce it. A conversational report-back has nothing.

## Where the format lives — do not restate it

| You need | Read |
|---|---|
| The questions a report answers, and why | `${CLAUDE_PLUGIN_ROOT}/rules/agent-report.md` |
| Verdict words, section names, finding columns, empty marker | `.claude/rules/project-profile.md` → **Reports** |

Resolve both from there each time. A copy here would go stale silently: nothing
breaks when a duplicated verdict word drifts from the profile's, so nothing
announces it — the skill simply starts teaching a shape the rest of the toolkit
no longer uses. `agent-report.md` makes the same argument for itself under *Why
this is a rule, not a template*.

## Where each piece goes

The pieces a chat reply mixes map onto the contract; they are not extra
sections. The right-hand column names the contract's **questions** — the wording
of any heading you actually type is the profile's.

| What you are about to write | Where it belongs |
|---|---|
| whether it worked, is ready, is safe | the **verdict** — first, alone, before any narration |
| what broke, what was found, what needs acting on | **findings** |
| what you actually looked at or ran | **checked** — this is what scopes the verdict |
| what you skipped on purpose | **not done** — a choice |
| what you could not settle, or fixed without proving | **unresolved** — a risk |
| files, commits, paths, IDs | **trace** |
| the one thing to do now | **next** |
| *why* you did it that way | inline with the finding it explains, or nowhere |

Reasoning is the piece most often given its own paragraph and it rarely earns
one. Attach it to the thing it justifies. If it justifies nothing the reader must
act on, cut it.

## Mid-flight is not a verdict

A chat report-back is often not finished, and that changes the first line rather
than removing it. What the reader decides is still the question — it is just a
different question.

| State | The first line answers |
|---|---|
| finished | did it pass |
| still running | what is running, and what you will do when it lands |
| blocked | what you need, and from whom |
| partial | what is settled, and what is not |

**Progress is not a verdict, and must not be dressed as one.** "Working through
the scenarios" is a status. "Six of nine clear, three failing on the same
cause" is a report.

## When this does not fire

Load-bearing, because a skill that fires on everything makes every reply a form.
The rule says it plainly: a one-line reply, a confirmation, or a single fact
asked for directly *is* the answer, and seven sections around it are ritual.

Leave it alone when:

- the answer is one fact and the fact is what was asked
- it is an acknowledgement — "pushed", "done", "it is at X"
- the work itself is the deliverable and this is just the covering note
- it is a discussion, a design proposal, or thinking aloud — a report states a
  conclusion, it does not develop one
- nothing was judged. A status carrying no judgment is a status, and fine

**The sections are a ceiling.** A small result answers the same questions in
three lines and no headings. Reaching for the full shape on a small result is
the failure mode, not the safe default.

## What it prevents

Four ways a report-back fails while still reading like a complete one.

**The buried verdict.** The judgment lands after two paragraphs of how it was
reached, so the reader spends the attention the report existed to save — and on
a failure, spends it twice.

**Choice collapsed into risk.** Something skipped deliberately and something
still unknown read identically once they share a list. One needs nothing; the
other is the reason to keep reading.

**Silent omission.** An absent section cannot be told from a question never
asked. "No issues found" and "did not look" are the same text when the text is
missing.

**Confidence not matched to method.** A thing fixed on reading and a thing
reproduced then fixed are stated in the same voice. Only the writer knows the
difference, so only the writer can record it.

## Why a skill

A command runs when a person types `/name`. This has to fire when nobody thought
to ask — the reply is already being written, and the writer is the one who
cannot see it needs the shape. That is what a model-invoked skill is for.
