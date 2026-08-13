---
name: reviewing-phrasing
description: |
  Hunts agent slop in the words of a human-read document — the README, the prose in docs/,
  anything written for a person: throat-clearing, hedging, restatement, inflated register.
  Use when such a doc is about to reach a reader. The words half of the human-read doc
  review — reviewing-typography judges the look, reviewing-artifacts judges agent-read
  tooling.
---

# reviewing-phrasing

**Kill the slop.** A human-read doc should read like a person who knows the subject wrote
it for a reader they respect. This reviewer judges the **words** against that; its partner
`reviewing-typography` judges the **look**, and the two run together as the human-read doc
review.

The mission, how a marker becomes a finding, and which reviewer owns what:
`${CLAUDE_PLUGIN_ROOT}/rules/anti-slop.md`.

## Slop in the words

Each marker with the target that replaces it.

| Marker | Target |
|---|---|
| **Throat-clearing** — setup, framing, a runway before the point | The point in the opening sentence; the detail behind it, for whoever wants it |
| **Hedging** — *generally*, *may help*, *it's worth noting*, *can often* | The claim, stated. Where it genuinely varies, name what it varies with |
| **Restatement** — the next sentence saying the last one again | One sentence, kept |
| **Inflated register** — *leverage*, *robust*, *seamlessly*, *delve*, *comprehensive* | The plain word a person would say out loud |
| **Symmetry padding** — matched triads, *not just X but Y*, parallel clauses carrying one idea | The idea, once |
| **Contentless framing** — an opener or a closer that adds no fact | The fact it was standing in for, or nothing |
| **Vagueness** — a claim the reader cannot act on | The specific: the number, the name, the path |

## What decides a finding

Here the question a marker is weighed against is whether the words serve **this reader**.
These four lenses are what that judgment weighs — together, not in order.

- **Reader.** Who reads this, and what they already know — default to the audience in
  `.claude/rules/project-profile.md` when the doc doesn't say. Jargon a newcomer can't
  parse and explanation a peer already has are the same failure.
- **Truth and completeness.** The right fact, whole, and only that. Brevity that costs the
  reader something they needed is a finding of its own.
- **Register.** A quickstart, a caveat, and a rationale each carry a different one.
- **Purpose.** The doc moves one outcome — someone set up, understood, or unblocked. Words
  that wander off it are a finding even when every sentence is clean.

## Steps

1. **Scope.** Which doc(s), and who reads them. Default the reader to the project audience;
   ask if that leaves it unclear.
2. **Read it once straight through** as that reader, for whether it lands.
3. **Pass the whole doc against every marker and every lens** — every section accounted
   for, top to bottom.
4. **Report** (below).
5. **Fix (if asked).** The smallest change that lands the words, in the author's voice.
   Leave what already works.

## Report

Per `${CLAUDE_PLUGIN_ROOT}/rules/agent-report.md`, in the words from
`.claude/rules/project-profile.md` → Reports. The verdict is the whole grade — here it
means:

- **PASS** — fits its reader, leads with the point, says the true thing.
- **REVISE** — findings, each naming a marker or a lens and the smallest fix.

Every finding quotes the words at fault. Trace carries the doc(s) reviewed.
