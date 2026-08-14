# The sections this plugin owns

Seed values for `.claude/rules/project-profile.md`. These are the **only** sections
`setup-agent-workflows` writes — see `profile-doctrine.md` → "More than one plugin writes
this file". Anything else in the file belongs to another plugin or to the project.

Every value below is a **default that reproduces this toolkit's own behaviour**, so a
project that accepts all of them behaves exactly as the toolkit does. Which unit reads
which section is the right-hand column; it is also the answer to "can I delete this one?"

| Section | Read by |
|---|---|
| Labels | `ship-create-pr`, `ship-merge` |
| Linking & branch | `ship-create-pr`, `ship-merge` |
| Platform | `ship-merge` |
| Git | `ship-create-pr`, `ship-merge`, `reviewing-finish` |
| Docs & diagrams | `doc-gen-readme`, `doc-review-readme` |
| Reports | every unit that ends at a gate |
| Review semantics | `reviewing-artifacts`, `reviewing-phrasing`, `reviewing-typography` |

A project that places only some of these units still gets every section: they are cheap,
and a missing one becomes a stop at the worst moment. Offer to drop a section only if the
user asks.

---

## The doctrine half

Written only when the file does not exist at all. It is identical in every project.

```markdown
# project-profile

**The values this project declares.** Every unit resolves its project-specific values from
here rather than hardcoding them, so a workflow is customized by editing this file and not
the units. Change a line here and every unit follows.

This file is reached by name: a unit cites `.claude/rules/project-profile.md`, and a
project that has not written one leaves that reference unresolved rather than quietly
borrowing another project's values.

How that resolution works — the two wiring styles, what belongs here rather than in a
project skill, and what happens when a value cannot be resolved — is
the plugin's `rules/profile-doctrine.md`, which ships with the units. That file is the
same in every project; this one is not.
```

---

## The value sections

### Labels

Ask only for the two names. The colour and description are creation values and follow the
status label; a project that has no opinion keeps them.

```markdown
## Labels

Names the workflow uses; colours where the workflow pins one (`#hex`), otherwise the
project's choice. A unit that **applies** a label creates it first, so that label — and
only that one — also declares the colour and description to create it with. See the
plugin's `rules/ship-tail.md`.

- status (pipeline position): `status:in-progress` · `status:needs-review`
  - `status:needs-review` is the one the ship tail applies, so it carries creation values:
    colour `#fbca04`, description "PR open, awaiting review"
- triage state (readiness): `ready-for-agent`

Which unit sets or clears which is the ship tail's business, not this file's — see the
plugin's `rules/ship-tail.md`.
```

**The triage state name is the one to actually ask about.** It is applied by something
upstream — `/triage` in `mattpocock/skills` — and `ship-merge` is its only exit. If the
project's `docs/agents/triage-labels.md` exists (written by `setup-matt-pocock-skills`),
read the name from there instead of asking; a mismatch means `ship-merge` clears nothing
and the label survives on closed work forever.

### Linking & branch

```markdown
## Linking & branch

- issue closure (PR → issue): `Fixes #N` / `Closes #N`
- feature branch name: `issue-<N>-<slug>`
```

Ask about the branch pattern only. The closure keyword is fixed by the host, not by taste.

### Platform

Derived, not asked. Work the host out from `git remote get-url origin` and write the
matching CLI. No hostname, owner, or repository path belongs in this file.

```markdown
## Platform

The code host and issue tracker. **Worked out, not written down** — a unit derives the
host from `git remote get-url origin`. No hostname, owner, or repository path belongs in
this file or in any unit; an address a person has to keep correct is one that goes stale
silently.

- CLI: `gh` (GitHub) · `glab` (GitLab) — both read the current repository from the git
  remote, so neither takes a `-R` / `--repo` argument while inside the repo
- change-request noun: `PR` (GitLab: `MR`) — wording, which is the one thing derivation
  cannot supply
- where the verbs differ: change requests `gh pr <verb>` / `glab mr <verb>` · comment on
  an issue `gh issue comment` / `glab issue note` · comment on a change request
  `gh pr comment` / `glab mr note` · label an issue
  `gh issue edit --add-label` / `glab issue update --label`. The rest — `issue view`,
  `issue list`, `issue create`, `label create` — read the same on both.
```

On a repo with **no remote**, say so and write the section with the CLI line left as a
question for the user — do not guess a host.

### Git

The merge strategy is the only question here. The default branch is derived by every unit
that needs it, and stays derived.

```markdown
## Git

- default branch: *derive it* (`git symbolic-ref --quiet refs/remotes/origin/HEAD`, minus
  the `refs/remotes/origin/` prefix), don't assume `main` — no network call and no
  platform CLI, so it reads the same on every host
- merge strategy: `--merge` (preserve history; switch to `--squash` only if the project requires)
```

### Docs & diagrams

```markdown
## Docs & diagrams

- README output: `README.md`
- diagram policy: SVG source committed + rendered to PNG (no Mermaid / inline diagram blocks)
- diagrams dir: `docs/diagrams/` (SVG source) + `docs/diagrams/png/` (rendered)
```

If the project already has a diagrams directory somewhere else, propose that path instead
of the default — exploration found it, so do not make the user say it twice.

### Reports

Written as-is unless the project has its own verdict vocabulary. Changing these words is
rare and deliberate.

```markdown
## Reports

The words a gate report uses. The contract itself — the questions a report answers and
why — is the plugin's `rules/agent-report.md`; a unit resolves the wording from here.

- verdict vocabulary: `PASS` · `REVISE` · `HAND BACK`
- extra verdict (artifact review only): `CUT` — the artifact duplicates another or does
  nothing useful; propose removal
- section names: `Verdict` · `Findings` · `Checked` · `Not done` · `Unresolved` ·
  `Trace` · `Next`
- empty-section marker: `none` (a section with nothing to report says so; it is not dropped)
- finding columns: `# · severity · location · what's wrong · smallest fix`
- formats by medium: chat session → plain text, tables, ASCII diagrams · document or
  issue → whatever renders there. For a *published* human-read doc the diagram policy
  under Docs & diagrams applies instead.
```

### Review semantics

The audience is the one value worth asking for — it is what `reviewing-phrasing` judges
jargon against, and it genuinely differs between an internal tool and a public library.

```markdown
## Review semantics

- canonical format (source of truth): `markdown`
- live integrations: `GitHub` — tools the project genuinely uses; coupling to one
  listed here is correct, not drift. (A downstream adds its own, e.g. Jira, Confluence,
  TestLink.)
- audience (human-read docs): engineers and newcomers
```

`live integrations` should name what the project actually uses. Read it from the remote
and from whatever the repo already integrates with; propose that list rather than the
default.
