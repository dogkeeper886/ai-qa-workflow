---
name: reviewing-artifacts
description: |
  Gates the tooling an agent reads — skills, commands, rules, CLAUDE.md — asking whether
  the file has one clear job, delivers it end to end, leaves the choices the project owns
  to the project, matches the repo as it actually is, and can be followed without guessing.
  Returns PASS, REVISE or CUT. CUT is the verdict nothing else makes: this artifact
  duplicates another or does nothing, and should be removed.
when_to_use: |
  Use whenever a file an agent reads is written or changed — a SKILL.md, a slash command, a
  rules file, CLAUDE.md or AGENTS.md — and before adding a new one to a collection, since
  the overlap question is easiest to answer while it is still cheap. Also on request:
  "review this skill", "is this command any good", "does this rule earn its place", "why
  isn't my skill triggering", "do we need both of these". Judges whether the artifact does
  its job; the look and the words of a human-read document are a different review.
argument-hint: "[path]"
---

# Reviewing artifacts

Target: $ARGUMENTS — a file, a folder, or the files just changed.

**Slop in tooling is not a matter of register.** It is a unit that looks like a unit and
does not work as one: ceremony where a job should be, an instruction the model already
obeys, a procedure frozen where a goal belonged, a reference to something that moved.

A marker is a symptom, not a verdict. Something is a finding when it costs the reader,
never because it matched a pattern. Every finding names the target that replaces it, not
just what to remove. A clean artifact is reported clean.

## The verdicts

`PASS` — does its job, fits the repo, nothing leaked.

`REVISE` — specific, fixable findings.

`CUT` — **the one no other reviewer returns.** This artifact duplicates another, or does
nothing that would be missed. Two units doing one job is worse than either alone: nothing
says which one ran, and they drift apart silently. Propose removal, name what absorbs the job, and never delete without approval.

## The five questions

Put all five to every artifact in scope. Each finding cites its question, the line, and
the smallest fix.

**Q1 — One clear job.** Say what this file is for in one sentence. Does everything in it
serve that sentence? Flag steps that wander off, and heavy overlap with another artifact.
Overlap is the CUT question: could this merge, or go away?

> A skill that reviews a README *and* opens the PR has two jobs; the PR half belongs to
> whatever already ships changes.

**Q2 — Complete.** Does it deliver that job end to end — no missing step, placeholder, or
instruction that produces nothing? A unit ending at a human decision is not complete until
it says what it hands that human: what the verdict is, what evidence comes with it, what
happens next. A unit that finishes silently, or defines a decision it never prints, is
incomplete. One deliberately exempt says so — silence is not an exemption.

> "Decide whether it passes" with nothing saying what a pass prints, or to whom.

**Q3 — Who owns the "how".** Flag stale paths, magic values that should be derived, and
rigid step-by-step where a principle would do.

Specificity is matched to fragility, not minimised. An exact command with no room in it is
correct where the task is fragile, order-dependent, or where consistency is the point — a
migration, a destructive operation, a build whose flags must not vary. "Run exactly this,
do not add flags" is a good instruction there, and loosening it into a goal is the defect.

So the question is not *is this specific* but who owns the choice:

| The "how" is | Then |
|---|---|
| what makes the task work — vary it and it breaks | freeze it, and say not to vary it |
| the project's to make — a path, a label, a tool it swapped | state the goal, let the project name it |

The failure is freezing the second kind. "Write it at this path", "name it like this",
"detect it this way" for something the project legitimately does differently — no
configuration can redirect a procedure, so that project must edit the shipped file, and its
repo then reads as drifted when it was only working around you.

**Q4 — Fits the repo as it actually is.** Every path, filename, command and cross-reference
resolves to something that exists **now**. This is the question that rots fastest and the one
worth automating: grep the references rather than reading for them. Flag coupling to a tool
the project has moved past. Skills are flat under `skills/<name>/` with supporting files
beside `SKILL.md`, never nested below it — a foldered skill is undiscoverable.

> A rule file renamed six months ago, still cited by four units that all read fine.

**Q5 — Right for its reader.** An agent must be able to follow it without guessing: no
option menus where one default belongs, no abstract example where a concrete one would
teach, one term per concept held throughout. This asks whether the artifact does its job.
Where it is human-read, its look and its words are a separate judgment and not this one's.

> "Use whichever diagram tool suits" — the agent now picks one at random each run.

**Assume the model already knows the domain.** What earns its place is only what the model
cannot have: your conventions, your sequences, your constraints. Explaining what a README
is, or that libraries exist, spends context on nothing.

**Count the restatements.** One rule stated in the description, again in the purpose, again
at its step, again in the example and again in the notes is stated once and padded four
times — and every copy is a place it can drift out of step with the others. Say it where it
is acted on. This is the defect a five-question review passes over most easily, because each
copy reads fine on its own.

**Emphasis is a budget.** Caps, bold and "never" earn their place only where the constraint
has been observed being dropped. A file that shouts on every step emphasises nothing, and
the one instruction that genuinely must not be varied is now indistinguishable from the
rest.

Where each kind leans:

| Artifact | Leans on |
|---|---|
| Skill / command | Q3 (who owns the how), Q5 (followable) |
| Rules file | Q1 (one job), Q2 (complete) |
| A new unit in an existing collection | Q1 (overlap → CUT) |

## Frontmatter first

**A unit is chosen by its frontmatter before its body is ever read**, so this decides
whether the rest of the file runs at all. Check it before anything else:

- **A missing or vague `description`.** This is the only text the model sees when picking
  among many units. Without it the unit is correct and unreachable, and the agent
  improvises the job instead. It must carry both what the unit does and when to reach for
  it, in the third person.
- **Undertrigger, which is the common failure — not overtrigger.** A description that
  describes the unit to someone who already knows it exists. It needs the oblique phrasings
  a user would actually type, including ones that never name the thing.
- **An `allowed-tools` list at all.** Omitting the key grants default access, which is
  almost always what a unit wants. Declaring one can only go wrong in two directions: too
  narrow and the unit cannot do its job — a skill told to write a file with no
  write-capable tool is inert — or too wide, pre-approving calls it never makes, and an
  irreversible one listed there is a prompt the human no longer gets. The prompts it saves
  are not worth a unit that silently cannot act. **Flag the declaration, not its contents,
  and give one fix: delete the key.** Never widen the list instead — that keeps the trap
  and only moves where it springs.
- **A setting that hides the unit from the model** while the author believes it is a safety
  gate. A gate belongs in the body, where a human is asked; the unit still has to be found
  for that body to matter.

## Security

**Nothing in the body may surprise someone who read the description.** A unit that reads
files, sends data anywhere, or runs commands beyond what its description implies is a
finding regardless of how well it does its job — the description is the only thing most
readers will ever see. No credential handling, no exfiltration, no instructions that
facilitate access the reader did not agree to.

## Steps

Copy this checklist and tick each item as you finish it:

    Task Progress:
    - [ ] Scope fixed — every artifact in it named
    - [ ] Frontmatter checked on each
    - [ ] All five questions put to each
    - [ ] Every reference resolved by grep, not by reading
    - [ ] Verdict reported

1. **Scope it.** One file, a folder, or the files just changed.
2. **Frontmatter first**, then the five questions against every artifact in scope.
3. **Resolve every reference** — by grep, not by reading. Q4's findings are the ones a
   careful read reliably misses.
4. **Report** (below).
5. **Fix, if asked.** Smallest blast radius first. Merging, splitting or removing needs
   explicit approval; flag it rather than doing it.

## Report

Two lines and a question:

    REVISE — 4 findings, one in the description, which decides whether the unit fires.
    Next: fix all 4 in one pass.
    Run it, or see the findings?

Findings, what was checked, and the trace are prepared and held until asked.

**Reviewing more than one artifact at a time, CUT sorts first** — deleting a file voids
every other finding against it, so it is the cheapest next step even when it is not the
most numerous.

On CUT, name what absorbs the job in the first line — a removal proposed without a
destination is not actionable:

    CUT — duplicates the unit that already owns register.
    Next: fold the two unique checks into it and delete this file.
