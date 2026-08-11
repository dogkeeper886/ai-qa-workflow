# agent-workflows

The toolkit that makes an AI coding agent follow an exact, documented order — the
`dev-workflow`, `qa-workflow`, and `doc-workflow` pipelines, plus the rules and skills
they read. This glossary fixes the words used to talk about the toolkit *itself*, as
distinct from the stories, issues, and test docs it produces.

## Language

**Unit**:
A command or a skill — one file an agent loads and follows. The pieces that ship
identically to every project.
_Avoid_: file, artifact, component

**Rule**:
A markdown file a unit cites by path for something too long to inline — a pipeline's
shape, what a report owes its reader, a project's values.
_Avoid_: doc, guideline, config

**Profile doctrine**:
The half of `project-profile.md` that explains what a profile is and how a unit resolves
against it. Identical in every project, so it ships with the units.
_Avoid_: preamble, header

**Profile values**:
The half of `project-profile.md` that declares one project's specifics — paths, ID
schemes, labels, branch conventions, report vocabulary. Different in every project, so it
stays in the repo.
_Avoid_: config, settings, options

**Placement**:
Putting the units where an agent will load them. Happens once, for all projects.
_Avoid_: install (it means placement and adoption at once)

**Adoption**:
Declaring a project's profile values so the placed units describe *that* project. Happens
per project, and cannot be shared between them.
_Avoid_: install, configuration, setup

**Shadowing**:
A project-local copy of a unit taking precedence over the placed one. Harmful when the
local copy is the older of the two, because nothing in the session says which one ran.
_Avoid_: overriding, drift, stale copy
