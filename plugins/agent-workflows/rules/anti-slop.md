# anti-slop

**What the review units are for.** An agent producing a document writes text that is
fluent, shaped like the real thing, and carrying less than it appears to. These units
exist to catch that before a reader meets it.

Slop is not bad writing. Bad writing is confused about what it means; slop is confident
about nothing in particular. That is what makes it hard to see — each sentence passes on
its own, and only the whole reads wrong.

## The shape of the judgment

What gives slop away depends on what is under review: the words carry it one way, the look
another, agent-read tooling a third. So each unit names its own **markers**. What they
share is how a marker becomes a finding.

- **A marker is a symptom, not a verdict.** Something is a finding when it costs the
  reader, never because it matched a pattern. Prose that hedges where the fact is
  genuinely uncertain is doing its job.
- **The markers are a floor.** Anything else that reads as generated is a finding too.
- **The fix is a target, not a ban.** Each marker names what should stand in its place, and
  the finding carries that. Naming only what to remove leaves the author where they started
  — and a review written as prohibitions teaches the banned move by repeating it.
- **A clean doc is reported clean.** Findings earn their place by being real. A table
  padded to look thorough spends the credit the real ones need.

## Which unit reviews what

| What is under review | Goes to |
|---|---|
| The **words** of a human-read doc — the README, the prose in `docs/` | `reviewing-phrasing` |
| The **look** of a human-read doc — hierarchy, grouping, emphasis, density | `reviewing-typography` |
| **Agent-read tooling** — commands, skills, rules, CLAUDE.md, stories | `reviewing-artifacts` |

The first two are halves of one pass. A doc read for its words and not its look has had
half a review, so they run together.
