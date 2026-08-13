# ship-tail

The stretch of a change's life between **committed** and **merged**. Everything before it
— the interview, the spec, the tickets, the build, the diff review — belongs to
[`mattpocock/skills`](https://github.com/mattpocock/skills), which ends at *"commit your
work to the current branch"*. This is what picks it up there.

## The flow

```
   a committed branch
        │
   reviewing-finish ──► run the project's tooling; clear the leftovers and
        │                orphans a diff-reading review cannot see
        ▼
   ship-create-pr ───► [human review + test]   push, open the change request,
        │                                      link it to its issue
        ▼
   ship-merge          merge · clear the labels · delete the branch · back to default
```

Each step stops for a human. None auto-runs the next.

## It starts at a commit, and needs nothing else

No story file, no plan issue, no preceding command in this plugin. A committed branch and
an issue number are the whole input. This is deliberate: it is what lets the tail run
straight after an `/implement` that knows nothing about this toolkit.

Where a step would once have updated a story file or closed a plan issue, it no longer
does — those artifacts have no producer here. See
[ADR-0002](../../../docs/adr/0002-complement-mattpocock-skills.md).

## The branch has no producer either

Nothing upstream creates it. `/implement` ends at *"commit your work to the current
branch"* and nothing before it branches, so a flow run straight through commits to the
**default** branch and arrives here with nowhere to push from.

That is a gap between two toolkits rather than anyone's mistake, and `/implement` is not
ours to edit (see the ADR above). So `ship-create-pr` repairs it where it already detects
it: create the branch at HEAD, rewind the default to the remote. That moves the commits
without touching the working tree and without discarding one — which is what makes it a
safe thing for a command to offer at all. It still shows what will move and asks first,
because the one thing it must never do is carry along work belonging to something else.

## Two kinds of label, and only one of them is ours

`ship-create-pr` sets a **status** label and `ship-merge` clears it — that pair is this
pipeline's own bookkeeping, and it closes itself.

The **triage state** label is different. Something upstream applies it to mark an issue
ready to be worked, and nothing upstream ever removes it. `ship-merge` is that label's only
exit; without this step it accumulates on closed work forever. Both names resolve from the
profile.

## Who creates a label

A label must exist in the tracker before any command can touch it. `gh` fails the *whole*
call on a name the repo does not have — taking the rest of that call with it — so this
does not degrade gracefully. Creation belongs **where a label is applied**, never where it
is cleared:

- `ship-create-pr` **applies** the status label, so it creates it first, resolving name,
  colour and description from the profile:
  `gh label create "<name>" --color "<hex>" --description "<text>" --force`.
- `ship-merge` only **clears**, so it creates nothing. A label the issue carries already
  exists by definition, and one it does not carry is dropped from the command — which is
  why clearing reads the issue's labels before naming any.

`--force` does not mean "skip if present" — it **updates the colour and description in
place**. So the values passed must be the profile's, never a literal copied into a command:
on a downstream that chose its own colour, a hardcoded one would silently overwrite it on
every run. That is also why only a label something here *applies* declares creation values
in the profile — the rest need a name and nothing more.

The triage state label is the case that makes the rule concrete: something upstream applies
it, this plugin only clears it, so **creating it is not ours**. Doing so would mint a label
on repos that never use it, purely to delete it again. A downstream hitting
`'ready-for-agent' not found` while *publishing* has found the upstream toolkit's gap, not
this one's.

## Producer → review pairing

| Producer | Review | Covers |
|----------|--------|--------|
| `ship-create-pr` | **human review + test** (before the merge) | the change as a whole, on the change request |
| `ship-merge` | *(is the terminal gate)* | mergeable, checks green, a human has reviewed |

No producer ships without a review covering its output. The review paired with
`ship-create-pr` is a **human gate**, not a command — the same shape as the human gate in
`doc-workflow`. The merge gate is a person's judgment, not a platform approval: on a solo
repo the host blocks self-approval, so neither command may require one.

A gate a person's judgment passes still has to be **observable**, or the command is left
inferring it. An empty review list is not evidence either way — a carefully reviewed PR
and an untouched one look identical. So `ship-merge` asks outright and records the answer on
the change request against the head SHA, and reads that record on a later run. The
judgment stays the human's; what changes is that it leaves a trace, and a trace pinned to
a SHA stops covering the diff once the head moves.

## Project-specific values

The label names, the closure keyword, the branch-name pattern, the merge strategy, the
default branch, and **the platform** — the CLI, the change-request noun, and the verbs that
differ between hosts — are **not** owned by these commands. They resolve from
`.claude/rules/project-profile.md`. The values a command shows are the defaults; change
them in the profile, not the command.

The `gh` invocations throughout these commands are that kind of illustrated default. A
project on another host reads its equivalents from the profile's **Platform** section; no
command here names a hostname, an owner, or a repository path, and none should be edited
to add one.
