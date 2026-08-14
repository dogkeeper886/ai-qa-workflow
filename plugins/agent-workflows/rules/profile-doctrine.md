# profile-doctrine

Where the line falls between what every project shares and what belongs to one project.
This file is the same everywhere and is not edited downstream; the values it talks about
live in the project, at `.claude/rules/project-profile.md`.

## The profile

The shipped commands and skills state their *intent* and resolve any project-specific
value — a path, an ID scheme, a label, an integration, a format, an audience — **from the
project's profile**, instead of hardcoding it. Customize a workflow by editing that file,
not the units.

**How a unit uses it.** Where a command or skill would otherwise bake in a value, it
points at the matching section of the profile (e.g. "create the *plan* label — see
project-profile → Labels"). The values a project starts with are **defaults**: they
reproduce this toolkit's own behaviour, so a project that changes nothing behaves exactly
as the toolkit does. Adoption is opt-in — change a line in the profile and every unit
follows.

**Two wiring styles, and when each applies.** A **command** inlines the profile at the top
and may then show a value inline as an illustrated default — the whole file is already in
front of it, and its group rule carries the "these resolve from the profile" statement for
the group, so the pointer is not repeated line by line. A **skill** is read on its own,
with nothing inlined beside it, so it points at the profile at each point of use. Both are
correct. Which one applies is decided by whether the unit inlines the profile — not by
preference.

**No profile, no defaults.** A project that has not declared its values does not fall back
to another project's — a unit that needs a value it cannot resolve stops and says so. A
silent fallback would run one project's paths, labels, and ID scheme inside another, with
nothing in the session to reveal it.

**Where a stop is not available.** A unit sometimes needs a value only *after* something it
cannot undo — tidying up after a merge, say. Stopping there is not a stop; it is a report
in a stop's clothing. So a unit like that resolves the value at its **earliest** point
instead, raises whatever will not resolve at the human gate it already has, and then
proceeds and reports the gap. The promise above is unchanged in substance: the value still
never resolves silently, and nothing is ever guessed to fill the hole. What moves is only
*where* it is said — because refusing finished work over a missing key protects nobody, and
a gap named after the fact is news rather than a decision.

## Two halves, two citation forms

A unit reaches each half by a different path, so the two carry the distinction themselves
and there is no resolution order to remember.

| Cited as | Means | Lives |
|---|---|---|
| `${CLAUDE_PLUGIN_ROOT}/rules/…` | doctrine — identical everywhere | the plugin, travelling with the units |
| `.claude/rules/project-profile.md` | values — this project's | the project, one file per repo |

A command inlines both at the top with `@`; a skill reads them by path at the point of
use. In a project that has declared nothing, the values reference resolves to nothing and
the session shows it — the no-fallback rule above, enforced by mechanism rather than by
prose.

## What belongs in the profile, and what does not

The profile is for **declarative** customization — a value or a list. A whole
**procedure** (e.g. how to publish to Confluence and review the render) is *not* a value;
it belongs in its own project-owned skill, never crammed into a general unit. Lists → the
profile; procedures → a project skill. This is the rules files' "what this owns vs. what
it hands off" boundary, made concrete.

The same line binds the **units**. A value the profile can restate is safe for a unit to
show inline; a *procedure* never is — how drift is detected, how files are laid out. No
value can override a procedure, so a project that does it another way is forced to edit a
shipped unit, and its repo then reads as drifted when it was only working around us. State
the goal; let the profile or the project's own layer name the mechanism.

## More than one plugin writes this file

A project may place several plugins that all resolve against the same
`project-profile.md`. Each reads a different set of sections, so a **setup unit writes only
the sections its own plugin reads** — never the whole file.

That makes the write order irrelevant, which is the whole point. A project runs one
plugin's setup today and another's next month, and must end with both plugins' values
intact; neither setup can know which ran first, so neither may assume it is the only
author.

- **Own only what you read.** A section a plugin does not resolve against is not its
  business — not to write, not to reformat, not to remove. A section **no** plugin claims
  is the project's own, and is never touched.
- **Add or update in place; never truncate.** A setup unit that finds an existing profile
  edits the sections it owns and leaves the rest exactly as it found them. Writing the file
  out from a template is what loses another plugin's values, and it does it silently.
- **A value already there is a decision.** This file exists to be hand-edited, so a setup
  unit re-running over one does not overwrite what it finds. It shows what differs from its
  defaults and asks. Only a section that is *absent* gets written without asking.

The **doctrine half** — the preamble saying what a profile is — is written by whichever
setup unit first finds it missing. It is identical in every project, so the next one to run
finds it already correct and leaves it alone.

## Where a project's own units live

A project may have commands and skills of its own — ones no other project wants. They stay
in the project, and they take a `<repo-name>-` prefix, so a project's unit can never be
mistaken for, or collide with, one every project shares.

Project-specific **rules** take no prefix. A rule is reached by path from the unit citing
it, so it has no namespace to collide in, and `paths:` front-matter already scopes it to
the files it governs. `workflow-patterns.md` scoped to `.github/workflows/**` is correctly
named; `myrepo-workflow-patterns.md` would only be noise.
