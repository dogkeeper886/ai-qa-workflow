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

## Two kinds of label, and only one of them is ours

`ship-create-pr` sets a **status** label and `ship-merge` clears it — that pair is this
pipeline's own bookkeeping, and it closes itself.

The **triage state** label is different. Something upstream applies it to mark an issue
ready to be worked, and nothing upstream ever removes it. `ship-merge` is that label's only
exit; without this step it accumulates on closed work forever. Both names resolve from the
profile.

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
