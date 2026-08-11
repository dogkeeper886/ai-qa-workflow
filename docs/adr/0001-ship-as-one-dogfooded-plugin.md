# Ship as one plugin, dogfooded from the plugin directory

The toolkit was placed by copying `.claude/` into each project, which left every
downstream repo on a different version — seven repos frozen on one old copy, three forked
only to swap `gh` for `glab`. We ship instead as a **single** Claude Code plugin named
`agent-workflows`, placed once at user level from this repo's own marketplace manifest,
and this repo consumes that plugin rather than its own `.claude/` — so the thing we test
is the thing we ship.

## Considered Options

- **Three plugins** (`dev-workflow`, `qa-workflow`, `doc-workflow`). Rejected: 11 of 14
  projects use at least two of them, and the pipelines are not independent — `qa-workflow`
  and `doc-workflow` each define themselves as siblings of `dev-workflow`, and all three
  share `agent-report.md` and one profile. Splitting would need a fourth "core" plugin or
  three copies of the shared rules. Splitting later is easy; merging later is not.
- **Keep `.claude/` as the source and build the plugin from it.** Rejected: reintroduces
  a build step, and lets the tested copy and the shipped copy diverge.
- **Keep both via symlink.** Rejected: breaks on any checkout that does not preserve
  symlinks.

## Consequences

Editing a unit no longer takes effect in the current session — the plugin has to
reinstall first. That is a real cost for the one repo whose job is editing units, and it
is accepted deliberately: fidelity between tested and shipped is worth more than the
inner loop.

Doctrine and values separate by citation syntax rather than by convention.
`${CLAUDE_PLUGIN_ROOT}/rules/…` means doctrine and resolves inside the plugin;
`.claude/rules/project-profile.md` means values and resolves in the project. A project
with no profile is a stop-and-tell-the-human gate — there is deliberately no fallback to
a global profile, because a silent one would run another project's labels and paths with
nothing in the session to say so.
