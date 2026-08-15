---
name: reporting-outcomes
description: |
  Reports work in two lines and a question — the verdict, the one next step, and whether
  the reader wants it run or wants the detail — and holds everything else until asked. Findings, what was checked, risks and decisions exist but are not
  shown by default; the reader either acts on the next step or asks for the detail. Only a
  blocked or failed next step brings its blocker up with it. Replaces the reply that mixes
  progress, findings, reasoning and status into a narrative the reader has to mine.
when_to_use: |
  Use whenever writing back about work — what was done, what was found, whether it worked,
  where things stand, what is left, what broke, what is blocked — and the answer runs
  longer than a line. Covers the everyday reply, not only a formal gate: a status update,
  a summary of a run, a review verdict, a handoff note, an answer to "how did it go" or
  "where are we". Reach for it even when nobody said the word "report", even when the
  reply feels short enough to wing, and even when the news is good. The buried verdict is
  the failure this prevents, and it is invisible to the person writing it.
---

# Reporting outcomes

**Under 30 seconds, or it failed.** The reader wants two things — *is it good, and what
happens now*. Everything else is yours to hold until they ask.

Volume is not the cost. **Interpretation burden** is: information arriving faster than
meaning can be extracted from it. A reader handed everything and told nothing does your
judging at their rate.

## The default: two lines and a question

    <VERDICT> — <the one thing that decides it>.
    Next: <one step>.
    <run it, or see the detail?>

Stop there.

    PASS — all five findings closed.
    Next: nothing. Ready for use.
    Want the detail?

    REVISE — 7 findings, 2 of them break checks that were reported working.
    Next: fix all 7 in one pass.
    Run it, or see the findings?

    IN FLIGHT — 6 of 9 scenarios clear, 3 failing on one cause.
    Next: fix the shared cause and re-run, ~20 min.
    Want the failing three?

That is the whole report. Not a summary of one.

## What is withheld

Findings · Checked · Risks · Decisions · Not done · Unresolved · Trace.

All of it real, none of it shown. Prepare it, hold it, produce it when asked. A reader who
trusts the verdict never spends a second on it — which is the point, not a reason to skip
doing the work behind it.

**Never volunteer it. Never offer extras beyond the one choice.** Answer, then stop.

## The one exception

**A next step that is blocked or failed brings its blocker with it**, because the reader
cannot act without it:

    BLOCKED — staging credentials missing.
    Next: you send them, or I stub the integration and we lose real-path coverage.

    FAILED — migration rolled back at step 4 of 7.
    Next: I need a call on retry-with-fix or revert to the old schema.

**These take no question line.** The choice is already inside Next, and asking again
after it is the offered extra this format exists to kill.

Nothing else surfaces uninvited. A risk that does not block the next step waits until
asked.

## Verdicts

A fixed set, so the first word grades before the sentence is parsed:

`PASS` · `REVISE` · `BLOCKED` · `FAILED` · `IN FLIGHT`

Unfinished work still has a verdict; it changes what the line answers, not whether there
is one. **Progress is not a verdict** — "working through the scenarios" is a status, "six
of nine clear, three failing on one cause" is a report.

## When they ask

Give only what was asked. Asked for findings, give findings — not findings plus what was
checked plus the trace.

Severity order, tightest useful shape. A table where the rows are peers:

    | # | Sev | Location | What's wrong | Smallest fix |

**On a PASS, `Checked` is the whole substance** — no findings justify the verdict, so what
was actually run is all that makes it worth anything. Name the command and its result.
Asserting "verified" without the observation is the costliest slop there is; every later
decision rests on it.

## Diagrams

ASCII only, only in the detail, only when the thing has a **shape** — a sequence, a break
in one, a dependency, a before-and-after:

    scrape ──► parse ──► ✗ validate ──► load ──► notify
                          schema drift          (never ran)

One per answer at most. Never in the two-line default. Never for two items, a list that is
already a list, or decoration.

## When this does not fire

A skill that fires on everything turns every reply into a form.

- the answer is one fact and the fact is what was asked
- an acknowledgement — "pushed", "done", "it's at X"
- a discussion, a design proposal, or thinking aloud — a report states a conclusion, it
  does not develop one
- nothing was judged; a status carrying no judgment is a status, and that is fine

## The markers

**The buried verdict.** The judgment lands after the narration, so the reader spends the
attention the report existed to save — twice, if it is bad news.

**The volunteered extra.** Findings, caveats and trace shown unasked, or a "want me to
also…" bolted onto the answer. Both spend the reader on something they did not raise, and
both tax the two lines that mattered.

**Progress dressed as a verdict.** A status with a grade-shaped sentence around it.

**Silent omission.** Asked for findings and given four of seven, with nothing saying so.

**Confidence not matched to method.** A thing fixed on reading and a thing reproduced then
fixed, stated in the same voice. Only the writer knows; say which.
