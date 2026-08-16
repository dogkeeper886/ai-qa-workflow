---
name: reviewing-typography
description: |
  Reviews how a human-read document looks — a README, prose and tables in docs/, an HTML
  page — and returns PASS or REVISE. Works the way a UI designer does: group the content,
  space the groups so the inner gap is smaller than the outer one, emphasize by dimming
  what is not the point rather than shouting what is, hold the level count low, and judge
  the page whole rather than section by section. Judges the look; the words are a separate
  review.
when_to_use: |
  Use whenever a document a person will read is written or restructured — a README, a
  guide, release notes, an HTML page — and before it reaches its reader. Also on request:
  "does this read okay", "make this scannable", "why does this look like a wall", "clean
  up the formatting", "too many headings". Reach for it on a doc that is factually right
  and still hard to get through, which is the case nobody thinks to ask about.
argument-hint: "[doc-path]"
---

# Reviewing typography

Target: $ARGUMENTS — a document path, or the one just written or edited.

**A document a person reads is a UI.** Strip its formatting and it is a bunch of text with
no point of focus. The levers differ from a screen — no fonts to set in markdown — but the
job is identical: let the eye find the point without reading everything first.

Markdown gives you four levers: **heading level** is size and weight, **blank lines** are
spacing, **bold and italic** are weight, and **paragraph and list length** decide whether
the page reads as structure or as soup. HTML adds colour, contrast and elevation.

A marker is a symptom, not a verdict. Something is a finding when it costs the reader,
never because it matched a pattern. A clean document is reported clean.

## The method

Run it in this order. Each step invalidates the ones after it, so fixing out of order
means doing the later work twice.

    1. GROUP      what belongs together, before touching any formatting
    2. SPACE      inner gap smaller than outer gap — always
    3. EMPHASIZE  by dimming the rest, not by shouting the point
    4. LEVEL      as few heading depths as the content truly has
    5. ZOOM OUT   judge the whole page, not the section you are in

### 1. Group

Read the content and mark what is one thing. A title and its subtitle are one group. A
list and its lead-in are one group. Two sections that happen to be adjacent are not.

Do this before looking at a single `#` or `**`. Formatting applied before grouping is
decoration, and decoration is what the rest of this skill exists to remove.

### 2. Space

**The gap inside a group must be smaller than the gap around it.** This is the one rule
here that is close to absolute — break it and grouping collapses, no matter how correct
everything else is.

    ✗ collapsed                      ✓ grouped
    ## Setup                         ## Setup
                                     Install it, then run it.
    Install it, then run it.
                                     - step one
    - step one                       - step two
                                     
    - step two                       ## Usage
    
    ## Usage

On the left every gap is one blank line, so the heading, the prose, the two steps and the
next section all read as five peers. On the right the list is tight, the section break is
loose, and the shape is visible before a word is read.

Markdown gives you three sizes of gap and no more: **none** (adjacent lines), **one blank
line**, and **a heading or `---`**. Spend them in that order — tightest inside, loosest
between.

In HTML the same rule has real numbers behind it. Pick one spacing unit and step it —
half a unit inside a group, one to two units between — rather than choosing a fresh value
each time. Padding is the outer gap for anything boxed: a card's own padding must exceed
the gaps between the things inside it, or the box stops reading as a container.

**Start loose and tighten.** Add the breaks generously, then remove the ones that separate
things which belong together. Extra whitespace costs a reader almost nothing; crowding
costs them the structure. Never start tight and add space where it seems needed — that
route ends at uniform spacing, which is the collapsed case above.

**Consistency beats correctness.** A document that spaces every group the same wrong way
still reads: the reader learns the convention and applies it. A document that mixes three
conventions cannot be learned at all. So prefer one rule applied everywhere to a better
rule applied unevenly, and when you find inconsistency, say which convention should win.

### 3. Emphasize

**You cannot raise the important line. You can only lower the rest.**

When every paragraph opens `**Label:**`, the bold is not emphasis, it is the body text.
The fix is never more bold on the thing that matters — it is removing bold from the twenty
things that do not.

Weight, size and position are the three levers, and they compound: a short line, set as a
heading, at the top of its group, needs no bold at all. Reach for bold last, on the few
things a reader should land on.

In HTML the same rule runs through contrast: the important text sits at high contrast and
everything else is dimmed toward the background. Headings do not go to maximum brightness —
that is harsh to read; the separation comes from lowering the surrounding text instead.

### 4. Level

**Almost no document needs a third heading depth.** A page of `##` with `###` where it
genuinely nests is the normal case. A nested heading over every two sentences is sprawl,
and it flattens the hierarchy it appears to create — five levels read the same as one.

Markdown fuses two things a UI keeps apart: the heading level is both the document
structure and the visual weight. You cannot mark something structurally minor and visually
prominent. So pick the level for how it should *look* to a reader scanning, and accept the
structure that follows — the reader sees the look, not the outline.

HTML separates them, and that separation is the point: `<h1>`–`<h6>` carry the outline for
a screen reader and a search engine, and CSS carries the weight. Code the level for the
document's real structure, then style it for the visual one. A heading skipped or
mis-levelled to get a size is a finding even when it looks right, because the outline is
what assistive technology navigates by.

### 5. Zoom out

Weight and size are relative. A `##` reads large in a short document and small in a long
one; a bold run stands out on a plain page and vanishes on a busy one. So judge the whole
document, not the paragraph in front of you.

**The strip test.** Remove every `#`, `**` and `-` in your head and read what is left. If
the document is still navigable, the formatting is doing its job — supporting a structure
the content already has. If it collapses into undifferentiated text, the formatting was
carrying structure the writing never had, and that is the finding: fix the writing, not
the markup.

## Markers

Fast checks. Each one is a candidate, not a verdict — the method above rules on it.

| Marker | What it usually means | Target |
|---|---|---|
| Every paragraph opens `**Label:**` | Emphasis spent as body text | Dim the rest; bold the few real anchors |
| Uniform blank lines everywhere | step 2 skipped — groups collapsed | Tight inside, loose between |
| Four or more heading depths | Structure invented, not found | Two, occasionally three |
| Prose chopped into bullets | A list because lists look organized | Lists for peers; prose for an argument |
| Every section the same length | Symmetry serving the doc, not the reader | The length each point needs |
| A long paragraph with no break | No entry point for the eye | A break at the natural boundary |
| Emoji headings, a rule between every section, a one-row table | Decoration | The plain shape the content asks for |

In HTML, four more:

| Marker | What it usually means | Target |
|---|---|---|
| Heading levels skipped, or chosen for size | Outline sacrificed to appearance | Level for structure, CSS for weight |
| Body text at maximum contrast | Nothing left to dim for emphasis | Body slightly muted, so headings separate without shouting |
| Many one-off spacing values | No system — every gap guessed | One unit, stepped |
| A card whose padding is tighter than its contents' gaps | The container stops containing | Padding exceeds the inner gaps |

## Steps

Copy this checklist and tick each item as you finish it:

    Task Progress:
    - [ ] Groups marked, before reading any formatting
    - [ ] Inner-vs-outer gap checked on every group
    - [ ] Emphasis counted — is bold the exception or the body?
    - [ ] Heading depths counted
    - [ ] Strip test run on the whole document
    - [ ] Verdict reported

1. **Scope it.** Which document. If unclear, ask.
2. **Run the five steps in order**, whole document, top to bottom.
3. **Report** (below).
4. **Fix, if asked.** Smallest change that lands the look — a break at a boundary, weight
   taken off labels that were never anchors. Leave what already reads well.

## Report

Two lines and a question:

    REVISE — every gap is one blank line, so the six groups read as one list.
    Next: tighten inside the groups and break between them.
    Run it, or see the findings?

- **PASS** — the eye finds the point; grouping and emphasis hold.
- **REVISE** — findings, each naming the step it failed and the smallest fix.

Findings, what was checked, and the trace are prepared and held until asked. Cite the step
each finding came from — a fix at step 2 changes what step 3 should be, so the order is
part of the finding.
