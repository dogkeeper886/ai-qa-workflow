# STORY-009: Place the toolkit once, instead of copying it into every project

## User Story

As someone running these workflows across many projects,
I want the commands and skills placed once and updated once,
So that every project runs the version I actually maintain, instead of whichever copy it
   was given on the day it was set up.

## The Need

The toolkit is adopted by copying `.claude/` into a project. That copy is a snapshot, and
nothing ever refreshes it. Fourteen projects on this machine have one; not one of them
matches this repo.

Seven — `local-agent-lab`, `ruckus1-mcp`, `test-framework-template`, `ldap`, `ollama37`,
`testlink-mcp`, `ai-qa-step-graph` — are frozen on a single old version, byte-identical to
each other and 120 changed lines behind across the dev-workflow commands alone, before the
other two pipelines are counted. They are worse off than projects with nothing
installed: a correct, current copy already sits at user level, and each project's stale
copy takes precedence over it. The version that runs is the older one, and nothing in the
session says so.

Three more — `dory-bom-mcp`, `simtool-madACXAP`, `skill-eval-harness` — read as forks but
are not. Their entire divergence is swapping one platform's CLI for another's, plus a
hand-maintained address repeated twelve times in a single command file. That address is
already wrong: it names a port the project's git remote does not use. A value nobody can
keep correct is one the workflow should never have asked a person to hold.

Even the file built for per-project difference has drifted for the wrong reason. Every
copy of `project-profile.md` differs from this one, by 41 to 136 lines — but the largest
differences are not a project's paths or labels. They are the file's own explanation of
what a profile is, edited downstream. The file carries two things, only one of which
varies by project, and the invariant half is the half that has drifted furthest.

None of this is a mistake anyone made. A copy has no way to know it is stale, a hardcoded
address has no way to notice the remote moved, and a file that mixes the shared with the
specific gives no signal about which half to leave alone. The cost is paid every time a
project is set up, every time the toolkit improves, and every time a project is picked up
after months away and silently runs something other than what it says it runs.

## Success Looks Like

- Adopting the toolkit in a new project means stating what is specific to that project
  and nothing else, so a new project cannot start out already behind.
- An improvement to a command reaches every project at once, without visiting any of them.
- A project hosted on GitLab runs the same commands as one hosted on GitHub, with no
  edited files and no address for anyone to maintain.
- A project cannot quietly run another project's paths, labels, or ID scheme; a project
  that has not declared its own stops and says so.
- No project runs an older version than the one placed, because no project holds a copy
  that could be older.
- A project can still have commands and skills of its own, and they cannot be confused
  with the ones every project shares.
- Someone adopting this from the public repo does less work than the README asks of them
  today, not more.

## Open Questions

- The order the pieces land in. Working out a project's platform has to come before the
  commands are placed, because one placed command cannot serve two hosts while a host is
  written into it — the rest of the sequencing is a planning question.
- Whether deriving the platform from the git remote holds for every project, including a
  self-hosted instance reached over SSH on a non-default port.
- What happens to the ten projects already holding a copy, and whether `ai-qa-studio` —
  117 lines, with its own Confluence, Jira, and TestLink command sets — is one of them or
  a separate toolkit that should be left alone. Deliberately deferred until this lands.
- Whether the README can still honestly promise "no installer, no build step."
- How much the dogfooding loop actually costs in practice: this repo edits commands for a
  living, and a change to one will no longer be live in the session that made it.

## Status

- Created: 2026-08-11
- Plan: #114
- Issues: #115, #116, #117, #118, #119
