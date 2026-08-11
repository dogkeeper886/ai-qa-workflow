---
name: reviewing-finish
description: |
  The last pass over a change before it becomes a change request: runs the project's own
  tooling so "verified" means observed rather than read, sweeps the leftovers a change
  left behind (debug output, commented-out blocks, stray TODOs), removes the imports,
  variables and files that *this* change orphaned, and ends in a verdict that routes
  somewhere. Covers what a diff-reading review structurally cannot — it runs **after**
  such a review, never instead of one. Use when a change is committed and about to be
  pushed. Floor, not ceiling.
---

# reviewing-finish

The pass that runs the code instead of reading it.

**This is not a second opinion on the diff.** A diff-reading review — `/code-review-2axis`
and its kind — already judges the change against the project's standards and against what
the issue asked for. Running this skill in its place leaves the change unreviewed on both
axes. Running it *before* means sweeping debris out of code that may still be rewritten.

Run it **after** the diff review, once the findings are settled, and before
`/dw-create-pr`.

What it covers is what a reviewer reading a diff structurally cannot do:

| | Why the diff review can't |
|---|---|
| **Run the tooling** | It reads text. It never observes a build, a test, or a render. |
| **Sweep the leftovers** | Debug output and commented-out code are *plausible-looking added lines*. They read as intentional. |
| **Remove the orphans** | An import left dangling is in a file the diff may not touch. The evidence is repo-wide, not diff-local. |

Scope creep and speculative generality are **already** covered by the two-axis review —
its Spec axis and its Standards axis respectively. Don't re-flag them here.

## The three checks

### 1. Verify by running, not by reading

Find the project's own tooling and run it. Don't assume a stack — look for what this repo
actually declares: a package manifest's scripts, a `Makefile`, a CI workflow, a task
runner's config, the commands the project's `CLAUDE.md` names.

Run what applies: typecheck, lint, the test suite, the build, whatever renders a
generated artifact. Run the **full** suite here, not the one file you were iterating on.

**A claim is verified when it was observed.** Report the command and what it printed. If
nothing runnable exists — a docs-only repo, a markdown toolkit — say that plainly. That
is a finding about the change's verifiability, not a silent pass, and "there is no test
suite" is a far more useful sentence than an unqualified *verified*.

Never report a check as passing because it looked like it would.

### 2. Sweep the leftovers

Debris the change added and did not take back out:

- **Debug output** — print/log/console statements added to see what was happening, and
  temporary log-level changes.
- **Commented-out code** — a block kept "just in case." Version control already keeps it.
- **Stray markers** — `TODO`, `FIXME`, `XXX`, `HACK` this change introduced. Either the
  work belongs in this change, or it belongs in a tracked issue with a number in the
  comment. A marker pointing at neither is a note to nobody.
- **Scaffolding** — a temporary fixture, a hardcoded stub, a skipped or `.only` test, a
  commented-out assertion, a debug flag flipped and left.

**Only what this change added.** Pre-existing debris in a file you touched is not yours to
sweep — mention it, don't remove it. `git diff <base>...HEAD` is the boundary.

### 3. Remove the orphans

Cleanup is scoped to the mess **this change** made:

- Imports, variables, functions, types, and constants left unused *because* of this change.
- Files this change stopped anything from referencing — a module whose last caller went,
  a fixture whose only test went, a doc whose subject went.
- Dangling references pointing at something this change moved or deleted — a cited path, a
  link, a name in a doc.

Verify each one, don't guess. Search for remaining references before removing anything;
dynamic references and re-exports are easy to miss. A deletion you can't justify by a
search is a finding to raise, not an edit to make.

**Removing a whole file needs explicit approval.** Flag it; don't do it unasked.

## Steps

1. **Establish the boundary.** Find the base — the merge-base with the default branch,
   derived rather than assumed (see `.claude/rules/project-profile.md` → Git). Everything
   below is scoped to `git diff <base>...HEAD`.
2. **Confirm the diff review already ran.** If it hasn't, say so and recommend it first.
   Continue only if the human chooses to.
3. **Run the tooling** (check 1). Capture the actual output.
4. **Sweep and search** (checks 2 and 3) across the changed files, plus a repo-wide search
   for references to anything this change moved or removed.
5. **Report** (below).
6. **Fix (if asked).** Smallest blast radius first. File deletions and anything touching
   behaviour need explicit confirmation. Re-run the tooling after fixing — a cleanup that
   breaks the build is worse than the debris it removed.

## Report

Report per `${CLAUDE_PLUGIN_ROOT}/rules/agent-report.md` — the verdict first, findings as
a table, and a section with nothing to report saying so. The verdict vocabulary is
`.claude/rules/project-profile.md` → Reports. No numeric score. In this review they mean:

- **PASS** — the tooling ran and passed, and no leftovers or orphans remain.
- **REVISE** — specific, fixable findings. Sweep them and run again.
- **HAND BACK** — the tooling fails on something this change did, or the cleanup exposes a
  problem in the change itself. That belongs back with whoever wrote it, not with a broom.

**Checked** carries the commands actually run and their result — this is where "verified"
earns the word. **Trace** carries the base the diff was taken against.

**Every finding routes.** A verdict that ends in a report nobody acts on is the failure
this section exists to prevent. Say where each finding goes: swept here, needs approval,
belongs in a tracked issue, or hands back. A finding with no destination is not finished.
