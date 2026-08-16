---
name: reporting-outcomes
description: |
  Reports work in two lines and a question — the verdict, the one next step, and whether
  the reader wants it run or wants the detail. Findings, what was checked, risks and
  decisions are prepared and held; the reader acts on the next step or asks. Only a
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

### The offer is the last line

**If the message contains an offer, nothing follows it.** Not a paragraph of context, not
the findings the offer was for, not one more useful thing. The question mark ends the
message.

This is stated as a rule about the *shape of the message* rather than about withholding,
because that is the version anyone can check. Look at the text: is there anything after the
offer? Withholding is invisible — a message where you held something back and one where you
forgot to are identical up to the question and only diverge after it, so "did I withhold"
cannot be answered by reading what you wrote.

**Asking and then answering is worse than not asking.** It presents a choice and takes it
away in the same breath, and it costs the reader the exact attention the two-line shape was
built to save. A report that just dumps everything is at least honest about what it is.

    ✗  DONE — the parser is fixed.                ✓  DONE — the parser is fixed.
       Next: open the change request.                Next: open the change request.
       Want the detail?                              Want the detail?
                                                  ─── end of message ───
       The fix was in the lookahead, which
       had been…  ← the offer is now a
                    decoration

## What is withheld

Findings · Checked · Risks · Decisions · Not done · Unresolved · Trace.

All of it real, and all of it done — a reader who trusts the verdict never spends a second
on it, which is the point rather than a reason to skip the work behind it.

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

## When the verdict covers more than one thing

**One subject, however many findings inside it, is one verdict and never a table.** An
issue fixed across five files with three findings on the way is one thing:

    PASS — #42 fixed, tests green.
    Next: open the PR.

Aggregate only when you judged N independent subjects that each deserve their own verdict —
ten skills, a folder of docs. The test: **could the reader act on one without the others?**
Ten skills, yes; one issue's five files, no.

When they are independent and there are only a few — up to about three — give **one
verdict line each and one Next**. Verdicts are cheap to scan; a count the reader has to
expand is not:

    PASS — reporting-outcomes: aggregation rule added.
    PASS — reviewing-artifacts: CUT-sorts-first added.
    Next: commit both.

Past a handful the list of verdicts becomes its own wall, so line one reports the set:

    REVISE — 3 of 10 need work; 1 is a CUT candidate.
    Next: fix the 3, starting with the CUT — deleting a file voids its other findings.
    See the per-item table?

The worst verdict sets the grade, and the line names **every** count — `REVISE` alone
hides the CUT, `3 of 10` alone hides what kind of trouble. When the table is asked for it
lists **every** item, clean ones included:

    | Item | Verdict | Findings |

A table of only the failures cannot be told from one that ran out of budget partway. And it
is still exactly one next step — ranking N items is the writer's job, not the reader's.

## Verdicts and states

**A verdict judges; a state describes.** Most work is graded, and some is better described —
*half done* and *more than one task* are real outcomes no grade carries. Either way the
first word must come from a **declared, fixed set**, never improvised per report, because
that is what lets it grade before the sentence is parsed.

Judging:

`PASS` · `REVISE` · `BLOCKED` · `FAILED` · `IN FLIGHT`

Describing: whatever set the unit declares, defined where it declares them.

Unfinished work still gets a first word; it changes what the line answers, not whether
there is one. **Progress is not a verdict** — "working through the scenarios" is a status,
"six of nine clear, three failing on one cause" is a report.

## When they ask

**Answer the question they asked, and only that one.** Each question has one home:

| They ask | Give | Not |
|---|---|---|
| "what's wrong" / "the findings" | the findings | plus checked, plus trace |
| "why" / "why that way" | the reasoning, attached to what it justifies | a standalone rationale section |
| "what did you check" / "how do you know" | the commands run and what they printed | a restated verdict |
| "is it risky" / "what could bite" | the risks, each with what would resolve it | risks without an ask |
| "where" / "which files" | the trace | a narrative of getting there |
| "show me everything" | all of it, in the order above | — |

**The 30-second cap applies to the detail too.** It is not the place the held-back report
finally lands — a second wall of text costs more than the first, because the reader paid a
question to get it. If the honest answer does not fit, say what it is and offer the rest:
*"12 findings, the 3 that block are below — the other 9 are cosmetic, want them?"*

Severity order, tightest useful shape. A table where the rows are peers:

    | # | Sev | Location | What's wrong | Smallest fix |

**On a PASS, `Checked` is the whole substance** — no findings justify the verdict, so what
was actually run is all that makes it worth anything. Name the command and its result.
Asserting "verified" without the observation is the costliest slop there is; every later
decision rests on it.

**Then stop.** Do not re-offer the remaining sections, do not summarise what was just
given, and do not close with a next step that was already stated. The answer ends when the
question is answered.

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
