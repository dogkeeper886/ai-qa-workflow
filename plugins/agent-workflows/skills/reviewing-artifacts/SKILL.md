---
name: reviewing-artifacts
description: |
  Hunts agent slop in the tooling itself — the commands, skills, rules, CLAUDE.md and
  stories an agent reads — against five goal questions: one clear job, complete, a goal
  not a frozen spec, fits the project, right for its reader. Use when such a file is
  written or changed. The look and words of a human-read doc go to reviewing-typography
  and reviewing-phrasing instead.
---

# reviewing-artifacts

**Kill the slop.** In tooling it is not a matter of register: it is a unit that looks like
a unit and does not work as one — ceremony standing where a job should be, an instruction
the model already obeys, a rule restated from the doctrine it could have cited, a
procedure frozen where a goal belonged. The five questions below are this unit's markers,
and how that gets caught.

The mission, how a marker becomes a finding, and which reviewer owns what:
`${CLAUDE_PLUGIN_ROOT}/rules/anti-slop.md`.

Review whatever artifact you are handed, *by kind* — commands, skills, READMEs, stories,
CLAUDE.md, and anything like them. Find where they live in *this* repo; new ones appear
and old ones change, so a fixed inventory of the current units goes stale.

## The questions

1. **One clear job.** Can you say what this file is for in a sentence? Does everything in
   it serve that one job? Flag sprawl (steps that wander off) and heavy overlap with
   another artifact (could it merge, or go away?).
2. **Complete.** Does it deliver that job end to end — no missing steps, placeholder text,
   or dead instructions that produce nothing? A reader/agent should be able to act.
   **Says what it reports?** A unit that ends at a human gate is not complete until it says
   what it hands that human. Flag one that finishes silently, one that defines a decision
   it never prints, one that restates the sections of `agent-report.md` inline instead of
   resolving to it, and one that invents verdict words outside `project-profile.md` →
   Reports. A unit deliberately exempt (its output is not a gate) says so — silence is not
   an exemption.
3. **Goal, not frozen spec — and no hardcoding.** Does it state intent and leave room where
   room belongs, instead of freezing a "how" that will drift? Flag stale paths or
   filenames, magic values that should be derived, rigid step-by-step where a principle
   would do, and references to tools or layouts that have moved.
   **Bakes in a mechanism?** Hardest bite of this question. A value `project-profile.md`
   owns may appear inline as a default (see `profile-doctrine.md` → "Two wiring styles"),
   but a *procedure* — how drift is detected, how files are laid out — cannot be overridden
   by any value, so a project that does it differently must edit the shipped unit. Flag
   every "compute X this way" or "write it at this path" that the profile cannot redirect;
   the fix is to state the goal and let the profile or the project's layer name the
   mechanism.
4. **Fits the project.** Does it match the conventions `project-profile.md` declares — the
   **canonical format** and the **live integrations** — rather than a stack the project has
   moved past? Flag coupling to a tool the profile does not list as live (one genuinely
   retired or relocated); an integration it does list, or a deliberate adapter, is not a
   violation. Cross-references resolve to files that exist. Skills are flat under
   `skills/<name>/` — a foldered skill is undiscoverable, and a unit that needs folders to
   group is a command.
5. **Right for its reader.** Agent-read (commands, skills): instructions the agent can
   follow without guessing. Human-read (README, story): reads like a person wrote it for a
   person. This asks whether the doc does its job; its look and its words go to
   `reviewing-typography` and `reviewing-phrasing`.

Where each type leans:

| Artifact | Leans on |
|----------|----------|
| Command / skill | Q3 (no hardcoding), Q5 (agent can follow it) |
| README / user doc | Q5 (reads for a human), Q1 (one clear job) |
| Story / spec | Q3 (goal, not spec) — the need, not a frozen design |
| CLAUDE.md | Q2/Q4 (matches the repo as it actually is — no orphaned references) |

## Steps

1. **Scope.** A single file, a folder, or "the files I just changed."
2. **Put every question to every artifact in scope** — all five, each file accounted for.
3. **Frontmatter hygiene (commands/skills).** Flag and recommend removing:
   - `disable-model-invocation: true` — a unit's user-only nature comes from living in a
     `commands/` directory, not a flag. On a skill the flag just makes it dormant (Claude
     can't auto-invoke it); a genuinely user-only entry point belongs in `commands/`.
   - a `tools:` / `allowed-tools:` allow-list — legacy baggage that pins the unit to
     specific tools/servers. Drop it so the unit inherits the session's tools.
4. **Report** (below).
5. **Fix (if asked).** Smallest blast radius first: remove leaked hardcoding, fill gaps,
   tighten wording. Structural changes — merging, splitting, or removing an artifact — need
   explicit confirmation; flag one for removal rather than deleting it.

## Report

Per `${CLAUDE_PLUGIN_ROOT}/rules/agent-report.md`, in the words from
`.claude/rules/project-profile.md` → Reports, which also declares **CUT** as this review's
own. The verdict is the whole grade — here they mean:

- **PASS** — does its job, fits the project, nothing leaked.
- **REVISE** — specific, fixable findings (gaps, hardcoding, drift, readability).
- **CUT** — duplicates another artifact or does nothing useful; propose removal (with approval).

Every finding names the question it came from (`[Q#]`), the line, and the smallest fix.
Trace carries the path(s) reviewed.
