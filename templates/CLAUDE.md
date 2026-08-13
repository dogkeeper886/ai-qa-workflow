# CLAUDE.md

Behavioral guidelines to reduce common LLM coding mistakes. Merge with project-specific instructions as needed.

**Tradeoff:** These guidelines bias toward caution over speed. For trivial tasks, use judgment.

## 1. Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

Before implementing:
- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them - don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

## 2. Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

Ask yourself: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

## 3. Surgical Changes

**Touch only what you must. Clean up only your own mess.**

When editing existing code:
- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it - don't delete it.

When your changes create orphans:
- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

The test: Every changed line should trace directly to the user's request.

## 4. Goal-Driven Execution

**Define success criteria. Loop until verified.**

Transform tasks into verifiable goals:
- "Add validation" → "Write tests for invalid inputs, then make them pass"
- "Fix the bug" → "Write a test that reproduces it, then make it pass"
- "Refactor X" → "Ensure tests pass before and after"

For multi-step tasks, state a brief plan:
```
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

Strong success criteria let you loop independently. Weak criteria ("make it work") require constant clarification.

## 5. Workflow discipline

Substantial work flows through a pipeline; each step is a gate that stops for a
human decision (nothing auto-runs the next):

```
/grill-with-docs → /to-spec → /to-tickets → /implement → /code-review-2axis
                → reviewing-finish → ship-create-pr → [human review] → ship-merge
```

**Idea through commit** is [`mattpocock/skills`](https://github.com/mattpocock/skills) —
install it alongside this plugin; nothing here duplicates it.

**Commit through merge** is this plugin — the **ship tail** (`ship-create-pr` → `ship-merge`),
which pushes, opens the change request linked to its issue, merges, clears the issue's
labels, and deletes the branch. Plus `reviewing-finish`: the pass that runs this project's
tooling and clears the leftovers and orphans a diff-reading review cannot see. Run it
*after* `/code-review-2axis`, not instead of it. The full flow lives in the
plugin's `rules/ship-tail.md`.

**qa-workflow** turns a story into trustworthy test docs, same gated discipline:

```
qw-plan → qw-review-plan → qw-cases → qw-review-cases
```

The full flow lives in the plugin's `rules/qa-workflow.md`.

**doc-workflow** turns a codebase into its README — same gated discipline:

```
doc-gen-readme → doc-review-readme → [human reviews] → PR
```

The full flow lives in the plugin's `rules/doc-workflow.md`.

**Right-size it.** A typo or a one-line doc change does not need the full chain —
use judgment; branch + PR + merge is enough. The review passes overlap:
`/code-review-2axis` reads the diff against the standards and the spec,
`reviewing-finish` runs the tooling and sweeps the leftovers. Running both on a
trivial diff is ritual, not rigor.

## 5a. How to report

Every reply reporting on work — progress, a verdict, a finding, a status — keeps its
parts distinct: what was done, what is suspected, what was skipped on purpose, what is
still uncertain, and what is next. Blending those into one paragraph is the failure this
guards against. The contract is the plugin's `rules/agent-report.md`; the words it uses
are `.claude/rules/project-profile.md` → Reports.

This binds the session rather than waiting for a skill to invoke itself. An agent
producing a muddled report is the least likely thing to notice it is producing one.

## 6. Artifact & doc review discipline

Match the reviewer to **who reads** the file you changed:

- **Human-read docs** (README, `docs/` prose): run `reviewing-phrasing` (the words)
  + `reviewing-typography` (the look) — the human-read doc review.
- **Agent-read tooling** (commands, skills, CLAUDE.md, rules): run
  `reviewing-artifacts` (does it do its job — one job, complete, goal-not-spec,
  fits the project, right for its reader).

These are skills the plugin ships. Like every gate in this toolkit, they stop for a human
and never auto-run — invoke them by hand.

**Right-size it.** A typo or a one-line tweak does not need a review pass — use
judgment. Reach for these when a change is substantial enough that the look, the
wording, or the artifact's fitness actually matters.

---

**These guidelines are working if:** fewer unnecessary changes in diffs, fewer rewrites due to overcomplication, and clarifying questions come before implementation rather than after mistakes.
