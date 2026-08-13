---
name: reviewing-typography
description: |
  Hunts agent slop in how a human-read document looks — the README, the prose, tables and
  lists in docs/: bold-label inflation, heading sprawl, everything-a-bullet, walls of text.
  Use when such a doc is written or restructured. The look half of the human-read doc
  review — reviewing-phrasing judges the words, reviewing-artifacts judges agent-read
  tooling.
---

# reviewing-typography

**Kill the slop.** A human-read doc should look like a person shaped it for a reader, not
like a generator filled a template. This reviewer judges the **look**; its partner
`reviewing-phrasing` judges the **words**. Together they are the human-read doc review.

Scope is text aimed at a **person** — the README, the prose, tables and lists in `docs/`.
Agent-read tooling — commands, skills, rules, CLAUDE.md, stories — goes to
`reviewing-artifacts`.

The principles are medium-agnostic; each format works them through its own levers. In the
project's canonical format (`.claude/rules/project-profile.md` → Review semantics —
markdown by default) there are no fonts to set, but the levers are the ones UI typography
uses: **heading levels** are size and weight, **blank lines and grouping** are spacing,
**bold and italic** are weight, and **paragraph and list length** decide whether the page
reads as structure or as soup.

## Slop, and what it should be

Each marker with the target that replaces it. Hunt all of them, and anything else that
reads as generated — the list is a floor, not a ceiling.

| Marker | Target |
|---|---|
| **Bold-label inflation** — every paragraph opening `**Label:**` | Emphasis spent as a budget: weight on the few things the reader should land on, the rest toned down so those few can anchor |
| **Heading sprawl** — a nested heading over every two sentences | Heading depth that matches the doc's real hierarchy, and stops there |
| **Everything a bullet** — prose chopped into a list because a list looks organized | Lists for peer items; prose for an argument the reader has to follow |
| **Uniform rhythm** — every section the same length, every list the same three items | The length each point actually needs |
| **Wall of text** — a long undifferentiated paragraph, or a stretch with no heading break | A break at the natural boundary; a `**Label:**` over a long list promoted to a real heading |
| **Fused layers** — metadata running into prose, intro into first section | The loosest separation where ideas cross layers, so the eye can see the seam |
| **Decoration** — emoji headings, a rule between every section, a table holding one row | The plain structure the content's own shape asks for |

## What decides a finding

A marker is a symptom; the finding is whether the eye finds the point. These three lenses
are what that judgment weighs — together, not in order.

- **Hierarchy.** Read the headings and bold runs alone, with the body ignored. That
  skeleton should give the doc's shape and its point of focus on its own; where it goes
  flat, or reads the same at every level, is the finding.
- **Proximity.** Spacing groups or separates. Related lines sit together, and a real break
  — a blank line, a heading, a rule — sits between things that are not one group.
- **Use.** Structure serves what the reader came to do, not the doc's own symmetry. A shape
  that is technically correct and still unusable is a finding.

## Steps

1. **Scope.** Which doc(s). If unclear, ask.
2. **Scan it twice** — the heading and emphasis skeleton first, for whether the shape
   reads on its own; then the whole doc, as a reader who wants one thing from it.
3. **Pass the whole doc against every marker and every lens** — every section accounted
   for, top to bottom.
4. **Report** (below).
5. **Fix (if asked).** The smallest change that lands the look — a heading break, a blank
   line, weight taken off the labels that were never anchors. Leave what already reads
   well. A doc that comes back clean is reported clean — findings earn their place by
   being real, and a table padded to look thorough spends the credit the real ones need.

## Report

Per `${CLAUDE_PLUGIN_ROOT}/rules/agent-report.md`, in the words from
`.claude/rules/project-profile.md` → Reports. The verdict is the whole grade — here it
means:

- **PASS** — the eye finds the point; hierarchy and grouping hold.
- **REVISE** — findings, each naming a marker or a lens and the smallest fix.

Every finding names where the look breaks. Trace carries the doc(s) reviewed.
