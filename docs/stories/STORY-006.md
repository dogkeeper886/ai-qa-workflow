# STORY-006: Close the holes in the customization seam

## User Story

As a downstream consumer of this template repo (e.g. test-framework-template, android-wifi-mcp),
I want every project-specific value to actually resolve from `project-profile.md` — and to be
   told when one doesn't,
So that I never have to edit a shipped unit to get the behaviour I declared, and upstream
   improvements still reach me without a merge conflict over my own customizations.

## The Need

STORY-005 shipped the customization seam and it works. Nine `dw-*` commands are byte-identical
across two downstreams that have never coordinated; the runner absorbs all of its differences in
its profile without touching a single command. The rule — *edit the profile, not the units* — is
sound and is holding.

But the seam has holes. A few values never made it out of the command text, and where a unit
names its own value, the profile is inert: a project can set the value, nothing follows, and the
only way to get the behaviour it declared is to edit the shipped file. That edit then looks like
the downstream drifting when it is really working around us.

Two downstreams have now paid for this, independently:

| Value | Where it's still named inside a unit | Who tripped over it | What they had to do |
|---|---|---|---|
| images dir | `doc-gen-readme.md`, `rules/doc-workflow.md` | test-framework-template | rewrote the command to point at its own diagrams dir |
| drift anchor (`story_hash`) | `qw-cases.md`, `qw-review-cases.md` | android-wifi-mcp | replaced hash drift with a derived chain check, then edited both commands |

One of those values is also simply **wrong**. The profile declares an images dir this repo does
not have; the six diagrams it actually ships live somewhere else entirely, and the README links
them from there. So `doc-gen-readme` run here today writes into a directory the repo doesn't use.
That breaks the profile's own promise — that its defaults "reproduce this repo's current
behaviour" — and it is the promise the whole seam rests on, because it is what makes adoption a
no-op until a project opts in.

Underneath both is the same gap: **nothing checks that a unit doesn't name a value the profile
owns.** STORY-005 swept 18 units by hand and got most of them; there is no pass that would catch
the ones it missed, or the next one someone writes. So a leak stays invisible until a downstream
trips over it — which is the expensive place to find it, because by then the workaround is
already committed in someone else's repo and reads as their mistake.

## Success Looks Like

- A downstream changes the images dir or the drift anchor in its profile, and the commands
  follow — with no unit edited.
- No shipped command, skill, or rule names a value the profile owns.
- Every default the profile declares matches what this repo actually does, and that agreement is
  something anyone can check rather than take on trust.
- The workarounds in `test-framework-template` and `android-wifi-mcp` become unnecessary: those
  files can match upstream again without either project losing the behaviour it chose.
- A new leak is caught when it is introduced, not when a downstream trips over it months later.
- We know the known leaks are the whole list — not just the ones a downstream happened to hit.

## Open Questions

- How is "no unit names a profile-owned value" actually checked — a question added to
  `reviewing-artifacts`, a line in the rules, or something runnable in CI? (decided in `dw-plan`)
- The drift anchor is a *mechanism*, not just a field name — android-wifi-mcp swapped hashing for
  a derived link check. Does the profile declare the mechanism, or only the front-matter fields,
  with the mechanism left to the project's own layer?
- Do the three known leaks represent the whole problem, or does a re-audit of all 18 units from
  STORY-005 turn up more?
- For the images dir: does the corrected default become this repo's real diagrams layout, or does
  the declared default stay as-is with this repo setting its own value like any other project?
- Is the profile's "defaults reproduce this repo's behaviour" promise worth enforcing generally,
  or is the images dir a one-off to fix and move on?

## Status

- **Completed: 2026-08-03** — the false images-dir default corrected, the diagrams location and the drift anchor demoted from baked-in mechanisms to profile-declared choices, and the two wiring styles written down with `reviewing-artifacts` Q3 now biting on baked-in mechanisms (PR #102).
- Created: 2026-08-03
- Plan: #98
- Issues: ✅ #99, ✅ #100, ✅ #101 (PR #102)
