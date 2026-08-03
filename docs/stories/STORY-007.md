# STORY-007: A standard report format for every agent gate

## User Story

As the human who gates every step of these workflows,
I want each command to report back in the same, scannable shape,
So that judging a step costs a glance instead of a re-read, and I can tell what was
checked, what was skipped, and what is still uncertain without reconstructing it myself.

## The Need

Every workflow this repo ships is a chain of human gates. Nine `dw-*` steps, four
`qw-*`, two `doc-*` — each one stops and asks a person to decide. The markdown and the
GitHub issues hold up well; they are versioned, greppable, and the story → plan → task
chain traces cleanly. The bottleneck is not the artifacts. It is **reading the agent's
report at the gate.**

Those reports have no agreed shape. Nothing in the commands defines one:

- Fourteen of the fifteen commands say nothing at all about what to print when they finish.
- The ones that do each name different things in different words — one asks for a
  verdict, findings, a path and a next step; another asks for findings with line
  numbers, a delivery verdict, and an issue link; a third defines a decision but never
  says to report it.
- Even the verdict vocabulary drifts between neighbouring commands.

With nothing specified, the shape is improvised fresh each run. The cost lands on the
reader in three ways:

**Categories collapse into one another.** A single block of prose carries the problem,
the concern, what was completed, what was already known, what was skipped, what was
worked around, the summary, and the status — all mixed together. The two that matter
most are the two that blur worst: something *deliberately skipped* and something
*genuinely unresolved* read identically, though one is a choice and the other is a risk.

**Silence is ambiguous.** When a report doesn't mention an area, there is no way to tell
whether it didn't apply or the agent never looked. A confident verdict can quietly cover
less than the reader assumes.

**The form fights the reader.** Findings that are a table arrive as paragraphs; a
sequence of gates arrives as prose describing arrows; a comparison arrives as
alternating blocks of text. The reader ends up rebuilding the structure in their head,
and that rebuilding *is* the review cost.

This compounds with how the workflows are actually used. Work runs in parallel sessions,
and returning to one means recalling what was already decided, what passed, and what is
still open. A report that has to be re-read from the top every time makes the human the
slowest part of a pipeline built entirely around their judgment.

There is also no check on any of this. A newly written command can ship without saying
what it reports, and nothing notices — the same shape of gap this repo is already
addressing elsewhere, where a value goes unspecified and only surfaces when someone
downstream trips over it.

## Success Looks Like

- Reports from two different commands are recognizably the same shape — a reader who
  has seen one knows where to look in the other.
- The decision a report is asking for is apparent without reading the report.
- What was deliberately left out and what is genuinely uncertain are never confusable,
  and an area with nothing to report says so rather than going silent.
- A reader can tell what a passing verdict actually covers.
- Reports lead with structure — the shape of the content is visible before the words
  are read — and prose appears only where an argument genuinely has to be followed.
- A report is legible in the place it lands: readable as plain text in a chat session,
  and free to use whatever renders when it lands in a document or a GitHub issue.
- A command that doesn't say what it reports is caught when it is written, not months
  later by a reader who noticed the reports feel inconsistent.
- A project adopting these workflows can put the reports into its own house style
  without editing anything this repo ships.

## Open Questions

- Does one report shape cover every unit, or do producers and reviews need different
  weight — a review leads with findings, a producer with what it made? (decided in
  `dw-plan`)
- Are the verdict wording and the section names fixed by this repo, or declared by the
  adopting project like its other specifics? The second is consistent with the
  customization seam, but it makes every report shape project-dependent.
- Is this the same body of work as the story that closed the customization seam? Both
  want a pass that checks "this unit declares what it owes its reader," and building
  that check twice would be waste.
- How is that check actually made — a question added to the artifact review, a line in
  the rules, or something runnable? (shared with the story above)
- The repo already has a stated position on diagrams in its published docs. Does a
  per-medium rule for reports sit alongside it or contradict it?
- A GitHub board was raised alongside this as a way to see which work is next. It
  answers a different question than a report does, and may not belong to this story at
  all — decide whether it is in scope or its own thread.
- Right-sizing: a full report on a trivial, one-line answer would be ritual rather than
  rigor. Where is the floor below which the shape doesn't apply?

## Status

- Created: 2026-08-03
- Plan: #104
- Issues: #105, #106, #107, #108
