---
paths:
  - ".claude/commands/**/*.md"
  - ".claude/skills/**/*.md"
---

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

**Two wiring styles, and when each applies.** A **skill** points at the profile at each
point of use — it is read on its own, with no rule loaded beside it. A **command** may
show a value inline as an illustrated default; its group rule (`.claude/rules/*.md`)
carries the "these resolve from the profile" statement for the whole group, so the pointer
is not repeated line by line. Both are correct. Which one applies is decided by whether
the unit is read together with its rule — not by preference.

**No profile, no defaults.** A project that has not declared its values does not fall back
to another project's — a unit that needs a value it cannot resolve stops and says so. A
silent fallback would run one project's paths, labels, and ID scheme inside another, with
nothing in the session to reveal it.

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

## Where a project's own units live

A project may have commands and skills of its own — ones no other project wants. They stay
in the project, and they take a `<repo-name>-` prefix, so a project's unit can never be
mistaken for, or collide with, one every project shares.

Project-specific **rules** take no prefix. A rule is reached by path from the unit citing
it, so it has no namespace to collide in, and `paths:` front-matter already scopes it to
the files it governs. `workflow-patterns.md` scoped to `.github/workflows/**` is correctly
named; `myrepo-workflow-patterns.md` would only be noise.
