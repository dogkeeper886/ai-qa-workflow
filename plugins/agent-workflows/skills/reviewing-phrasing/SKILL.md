---
name: reviewing-phrasing
description: |
  Reviews the words of a document a person will read, and returns PASS or REVISE. Starts
  by establishing what the file actually is and who reads it, because a markdown file
  carries no contract the way a source file does, and the same wording is correct in a
  talk track and wrong in a test case. Then runs check-prose.sh to locate the mechanical
  tells by grep rather than by impression, and judges what a pattern cannot reach.
when_to_use: |
  Use whenever prose a person will read is written or edited: a README, a design doc or
  RFC, a test plan, a QA report, a bug report, API or CLI reference, release notes, slide
  content, a demo script. Also on request: "does this read okay", "make this clearer",
  "tighten this up", "write this up", "too wordy". Reach for it on a document that is
  factually correct and still hard to read, and on any document an agent generated, which
  is the case that most needs it and least asks for it.
argument-hint: "[doc-path]"
---

# Reviewing phrasing

**An agent knows what a `.py` file is and does not know what a `.md` file is.** A source
file declares its contract: imports, signatures, types. A text file declares nothing. A
README, a test case, a talk track and a page of notes are the same bytes to a reader that
has not asked what it is holding.

That matters because the markers invert. Contractions are right in something spoken and
sloppy in a test case. "Verify that" is unremarkable in a README and a finding in a test
step. A reviewer that skips step 1 applies half its rules with the sign flipped.

## 1. Identify the document

Three questions, answered before reading for style. Ask if the file does not say.

1. **Who reads this, and what do they already know?** A teammate needs no background
   section; an external contributor does. Write for the least informed reader who must act
   on it.
2. **What decision or action does it enable?** Approving a design, running a build, filing
   a bug, executing a test, calling an endpoint. A document that enables nothing should not
   exist, and that is a finding on its own.
3. **How is it read?** Start to finish, jumped into by search, or listened to. A skimmed
   document needs headings that predict their content; a spoken one needs none at all.

| Kind | Reader is | Register that is correct here |
|---|---|---|
| README | a newcomer scanning | leads with the point; second person; imperative |
| Design doc / RFC / ADR | a peer deciding | prose earns its length; the argument must follow |
| Test plan / test case | a tester executing | imperative, precise; quality adjectives are findings |
| QA report | someone making a release call | verdict first with its condition; counts, not adjectives |
| Bug report | whoever reproduces it | the reproducer is the document; verbatim error text |
| API / CLI reference | someone looking one thing up | consistency beats flow; every example runs |
| Release notes | someone asking "does this affect me" | changes first, terse |
| Slide content | read in three seconds while someone talks | fragments right, sentences wrong |
| Talk track / demo script | **listened to** | contractions right, long clauses wrong, punctuation invisible |

Four kinds have their own criteria, including per-kind review checklists. Read the matching
file before judging:

| Reviewing | Read |
|---|---|
| Design doc, RFC, ADR, proposal | [reference/design-docs.md](reference/design-docs.md) |
| README, contributing guide, project docs | [reference/readmes.md](reference/readmes.md) |
| Test plan, test case, QA report, bug report | [reference/test-plans.md](reference/test-plans.md) |
| API reference, CLI docs, tool docs, schema docs | [reference/api-reference.md](reference/api-reference.md) |

## 2. Run the script

`check-prose.sh` ships beside this file. Run it from wherever it is placed, not from the
working directory:

    "$CLAUDE_PLUGIN_ROOT"/skills/reviewing-phrasing/check-prose.sh <file>

If that variable is not set — the skill placed outside a plugin — the script is in the same
directory as this `SKILL.md`, and that path works instead.

It locates the mechanical tells: the symbol set (em dash, en dash, spaced hyphen, curly
quotes, ellipsis, arrows, emoji), the em-dash rate per thousand words, and the term tables
for inflated vocabulary, filler, openers, contrast frames, hedges, unobservable quality
words and relative time.

**A hit is a located candidate, not a finding.** The script does the searching, which a
model does unreliably on its own writing, and leaves the ruling to step 3. It exits 0 with
hits for exactly that reason. Hedging where a fact is genuinely uncertain is the word doing
its job.

**Run it, do not reimplement it.** Judging your own register is the one thing a generator
is worst at, because fluent-and-empty is its own baseline.

### What the script cannot reach

Named so a clean run is never read as a clean document:

- **The full contrast frame.** It catches `not just` and `not only`; the shape
  "it isn't A, it's B" has open slots and needs a reader.
- **Rule of three.** Matched triads carrying one idea have no fixed words.
- **Restatement.** The next sentence saying the last one again.
- **Vagueness.** A claim with no number, name or path in it, that no pattern marks.
- **Uniform sentence length**, and prose chopped into bullets.
- **Whether a hedge is earned**, which is the whole judgment.

## 3. Judge

**Lead with the highest level.** Structural problems make sentence edits wasted work, so
settle them first:

1. **Does it serve its purpose?** Wrong reader, missing decision, a document that should
   not exist.
2. **Is the structure right?** Missing sections, wrong order, buried conclusion.
3. **Is it accurate?** Broken examples, stale versions, unsupported claims.
4. **Is the prose clean?** Voice, terminology, hedging.

**Front-load.** Readers stop early. The conclusion, the recommendation, or the working
command belongs on the first screen. This applies fractally: the first sentence of every
section states its point.

**The sentence rules**, each a finding when broken:

- Present tense, active voice. "The validator rejects the field", not "the field will be
  rejected".
- Imperative for instructions. "Run the migration", not "you should run the migration".
- One term per concept, forever. Choosing `test case` means never writing `test`, `case` or
  `TC` for it. Synonym variation is a virtue in prose and a defect in technical writing:
  the reader has to decide whether a new word means a new thing.
- Quantify. "Slow" becomes "roughly 4s per 1000 records"; "large" becomes "over 50 MB".
- No dangling pronouns. "This causes failures" — this what? Name the referent.
- Split a sentence carrying more than one clause of new information. Three commas is
  usually three sentences.
- Second person for the reader's actions, not first person plural.
- No relative time. "Currently", "recently", "the new API" rot on their own. Write the
  condition: "in v2.3 and later".

**Cut 20%.** Not rhetorical. First drafts run reliably long, and the cut almost always
improves them.

**Give the reasoning with the correction.** "Moved the recommendation up, because a
reviewer approving this will not read past the first screen" teaches; a silent reordering
does not.

## Steps

Copy this checklist and tick each item as you finish it:

    Task Progress:
    - [ ] Kind, reader and register established
    - [ ] Matching reference/ file read, if one applies
    - [ ] check-prose.sh run, output kept
    - [ ] Each hit ruled on — cost the reader, or not
    - [ ] The shapes the script cannot reach, judged by reading
    - [ ] Verdict reported

1. **Identify** (step 1). If the kind is genuinely unclear, ask rather than guess.
2. **Run the script** (step 2).
3. **Judge** (step 3), highest level first, whole document.
4. **Report** (below).
5. **Fix, if asked.** The smallest change that lands the words, in the author's voice.
   Leave what already works.

## Report

Two lines and a question:

    REVISE — reads as a design doc but the recommendation is on screen three.
    Next: move the recommendation up, then re-run the script.
    Run it, or see the findings?

- **PASS** — fits its reader, leads with the point, says the true thing.
- **REVISE** — findings, each quoting the words at fault and naming the smallest fix.

Findings, the script output, and the trace are prepared and held until asked. When findings
are given, quote the text rather than describing it, and say which came from the script and
which from reading: a count is reproducible and a judgment is not, and the reader is
entitled to know which they are being handed.
