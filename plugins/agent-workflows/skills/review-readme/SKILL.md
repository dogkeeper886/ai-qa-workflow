---
name: review-readme
description: |
  Gates a README before a person reads it, on three counts: it delivers for a newcomer,
  it is true to the code, and it reads and looks right. Derives the key points from the
  code and checks the README leads with them and ships a diagram for each, verifies every
  command, path, env var and link against the source, and re-renders each diagram to catch
  one that has drifted from what it is drawn from. Gates what gen-readme wrote, and any
  README edited by hand.
when_to_use: |
  Use whenever a README has just been created or edited, by this toolkit or by hand —
  including an edit made without gen-readme, and an edit to a single section rather than
  the whole file. Also on request: "review the README", "check the README is accurate",
  "does the README still match the code", "gate this README before I open a PR". A README
  changed and not gated reaches its reader unverified, so treat any write to one as the
  trigger rather than waiting to be asked.
argument-hint: "[readme-path]"
---

# Review a README

## VALUES

Three values belong to the project, not to this skill. Use the default unless the project
declares otherwise; where it declares, that wins:

| Value | Used by | Default |
|---|---|---|
| README path | Target, below | `README.md` |
| audience | Step 2 | engineers and newcomers |
| diagram policy | Step 3 | SVG source committed, PNG rendered, no Mermaid |

Target: $ARGUMENTS — a README path, or the one just written or edited.

## PURPOSE

The gate on `/gen-readme`, and on any README changed by hand. A README is read by a
person AND it makes claims a person will run, so this reviews both: does it deliver and
is it true.

    gen-readme → review-readme → [human reviews] → PR

## WORKFLOW

**Reviewed in the producer's order, not in reverse.** Findings cascade downhill: rule the
structure wrong and the prose is rewritten, so a words-first pass spends itself on prose
that no longer exists. Cheapest invalidating check first.

Copy this checklist and tick each item as you finish it:

    Task Progress:
    - [ ] Step 1: Structure checked against current convention
    - [ ] Step 2: Key points derived FROM THE CODE; README leads with #1
    - [ ] Step 3: One diagram per key point — count verified, each re-rendered
    - [ ] Step 4: Every claim and link verified against the code
    - [ ] Step 5: Words + look reviewed
    - [ ] Step 6: Decision reported

    /review-readme
        │
        ├─► Step 1: The structure, against current convention
        │   - The producer's research step records its sources. Read them and check the
        │     section order against what they actually say — not against your memory of
        │     README convention, which is the thing least worth trusting here.
        │   - No sources recorded (a hand-edited README): search for current convention
        │     yourself. Say which you did; an unresearched pass is a weaker verdict.
        │
        ├─► Step 2: The key points — derived from the CODE, not read off the README
        │   - Derive them the way the producer did: entry points, build and package
        │     files, config, the top-level layout, how the parts compose. Number them.
        │   - Deriving them from the README instead makes every later check circular — a
        │     key point the README dropped is one you would then never look for, and the
        │     count in Step 3 could only ever catch the harmless direction.
        │   - [ ] The README leads with #1, the organizing idea — for a multi-part repo,
        │         how the parts compose, not a bare list. Deep reference is linked.
        │   - [ ] Every key point on your list appears in the README. One missing is the
        │         finding this step exists to catch.
        │   - [ ] It lands for the project's audience: what this is, why it's
        │         distinctive, and how to run it, without first opening docs/.
        │   - Where the code and the README disagree about the organizing idea, the code
        │     wins — that is a finding, not a rewording.
        │
        ├─► Step 3: The diagrams — one per key point
        │   - Applies only where the project's diagram policy asks for diagrams. A repo
        │     that declares none, or a hand-written README in a project that never
        │     adopted the policy, records this step NOT APPLICABLE rather than failing it.
        │     The count belongs to the producer's rules, not to every README in the world.
        │   - [ ] Count check: one diagram per key point from Step 2. A key point with no
        │         diagram is a finding; so is a diagram for something that is not one.
        │   - [ ] Each is a committed PNG with its SVG source beside it — NOT Mermaid or
        │         any inline diagram block, so it renders on GitHub with no build step.
        │   - [ ] Re-render and compare. Run the project's own render script; where none
        │         exists the producer's default is
        │             rsvg-convert -z 2 <name>.svg -o png/<name>.png
        │         Match the scale the committed PNGs were made at — read it from the
        │         script, or from a PNG's pixel size against its SVG viewBox. Re-render at
        │         the wrong scale and EVERY diagram reports stale, which is a false alarm
        │         that costs more than the check saves. A PNG that genuinely does not
        │         reproduce contradicts the prose silently.
        │
        ├─► Step 4: True to the code
        │   - [ ] Every command, endpoint, env var, tool name and path verified against
        │         the code and build files — no invented flags. Grep the source. Verify
        │         against the code, NOT against sibling docs, which may be stale.
        │   - [ ] Every link resolves to a file that exists.
        │   - [ ] Every count, version and name the prose states still matches what it
        │         describes — these rot silently when the thing they count changes.
        │
        ├─► Step 5: Words and look
        │   - Judge the prose that now ships, on both halves: the words (register,
        │     hedging, restatement, throat-clearing) and the look (heading sprawl,
        │     everything-a-bullet, emphasis spent past its budget).
        │   - Do not name a sibling skill to do it. Whatever this session has for judging
        │     a human-read document reaches for itself on its own description; naming one
        │     here couples this file to that file's name and breaks on the next rename.
        │   - Runs last on purpose: by here the structure and claims are settled, so the
        │     prose being judged is the prose that ships.
        │
        └─► Step 6: Decision
            - PASS: delivers, true, reads and looks right → ready for a human + PR.
            - REVISE: name each finding with file:line and the smallest fix; apply them,
              then re-check.

## OUTPUT

In this order:

- **Verdict** — first, alone on a line.
- **Findings** — a table: each with file:line and its smallest fix.
- **Checked** — what was examined, including whether the producer's sources were read,
  whether Step 3 applied, and whether the PNGs were actually re-rendered.
- **Not done** — skipped on purpose.
- **Unresolved** — still uncertain.
- **Trace** — the README and the diagrams reviewed.
- **Next** — one step.

A section with nothing to report says so rather than being dropped; an absent section
cannot be told from a question never asked. Where the project declares its own verdict
words and section names, use those.

## NOTES

- Adds what a README needs beyond an ordinary prose review: the key points derived from
  the code, the diagram count, the re-render, and the accuracy pass.
- Enforces what the producer promises — one diagram per key point, SVG→PNG, leads with #1.
  If `gen-readme`'s rules change, this pass changes with them; the count check is the
  coupling most likely to drift.
- Reads the README + the code; on REVISE, edits the README in place. No PR.
