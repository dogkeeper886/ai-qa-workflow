# Merge a Pull Request

## Rules

Doctrine — the same in every project, and travels with these units:
@${CLAUDE_PLUGIN_ROOT}/rules/ship-tail.md
@${CLAUDE_PLUGIN_ROOT}/rules/agent-report.md
@${CLAUDE_PLUGIN_ROOT}/rules/profile-doctrine.md

Values — this project's:
@.claude/rules/project-profile.md

```
Merge an approved pull request and clean up.

PR number: {{input}}

## PURPOSE

The second half of the **ship tail**, and its terminal gate. Merges an approved
PR, clears the issue's labels, and removes the branch from both the remote and
your working copy, leaving you on the default branch.

Two kinds of label are cleared, and the second is the one nothing else clears:
the **status** label the ship tail itself set, and the **triage state** label
that marked the issue ready to be worked. Triage applies that state; without
this step it survives on closed work forever.

---

## WORKFLOW

    /ship-merge 30
        │
        ├─► Step 1: Verify Ready to Merge
        │   - Run: gh pr view <PR> --json mergeStateStatus,headRefName,headRefOid,comments
        │   - Must be mergeable (no conflicts)
        │   - Run: gh pr checks <PR> — any CI checks must pass (if applicable)
        │   - Note headRefOid, the head SHA. Step 2's confirmation is pinned to it
        │   - Resolve BOTH label names Step 5 clears — the status label and the
        │     triage state label (see project-profile → Labels) — now, while
        │     nothing has happened yet. A name the profile never declares is not
        │     the same as a label the issue happens not to carry: the first means
        │     this project was never configured for the step, the second is
        │     routine. Carry any undeclared key to Step 2; do NOT guess a name
        │     and do NOT quietly clear one label and forget the other
        │
        ├─► Step 2: The Human Gate — Look, Ask, Record
        │   - The gate is HUMAN review + test, not a platform approval. On a solo
        │     repo the host blocks self-approval, so do NOT require
        │     reviewDecision=APPROVED — and do not read an empty review list as
        │     either a yes or a no. It is not a signal in either direction.
        │   - Before either path below: if Step 1 could not resolve a label name,
        │     raise it HERE, naming the key and the profile section it belongs
        │     in. This gate is the last point before something irreversible, so
        │     it is raised whether or not a question gets asked — in the question
        │     when one is asked, alongside the found confirmation when it is not.
        │     Do not make it a second stop and do not refuse the merge over it: a
        │     missing key is configuration, not a reason to hold reviewed work.
        │     Raised before the merge it can still be acted on; after, it is news
        │   - Look first, in the comments Step 1 already fetched. A confirmation
        │     naming the current headRefOid IS the gate — say it was found and go
        │     to Step 3 without asking again
        │   - Otherwise ask the human outright: has this change been reviewed and
        │     tested at <headRefOid>? A green /code-review-2axis or
        │     reviewing-finish does not answer it — those are agent passes, and
        │     this gate is a person's judgment on the change as a whole
        │   - Nor does being told to run this command answer it. The instruction
        │     is to open the gate, not to pass it: "merge PR <N>" is a request to
        │     reach this question, never the answer to it. Ask, and wait
        │   - On no, or on no answer: do not merge. Stop here and report per Step 7,
        │     with the missing confirmation as the finding — a refused gate is a
        │     gate output, and it owes the human the same report a merge does
        │   - On yes, record it before merging so the gate leaves a trace (the
        │     comment verb is a project value — see project-profile → Platform):
        │     gh pr comment <PR> --body "Human review + test confirmed at <SHA>."
        │   - A confirmation covers the diff it was given for. If the head moved —
        │     the only confirmation names an older SHA, or the head changes
        │     mid-run — it does not carry. Ask again against the new head
        │
        ├─► Step 3: Identify the Linked Issue
        │   - Read the PR body for its closure keyword (see project-profile →
        │     Linking & branch) and note the issue number for label cleanup
        │   - If the PR closes no issue, skip Step 5 and say so in the report
        │
        ├─► Step 4: Merge
        │   - Re-read headRefOid first. If it no longer matches the SHA Step 2
        │     confirmed, the head moved under the gate: stop, say so, and go back
        │     to Step 2 against the new head. Do not merge on a stale confirmation
        │   - Run: gh pr merge <PR> --merge --delete-branch
        │   - The merge strategy is a project value (see project-profile → Git)
        │   - --delete-branch cleans up the remote branch
        │
        ├─► Step 5: Clear the Issue's Labels
        │   - Read what the issue carries first. This step runs AFTER the merge,
        │     and naming one label the repo lacks fails the whole call — leaving
        │     a merged PR with every label still on it:
        │       gh issue view <N> --json labels --jq '[.labels[].name]'
        │   - Remove the status label the ship tail set, and the triage state
        │     label (see project-profile → Labels), passing only the ones the
        │     issue actually carries:
        │     gh issue edit <N> --remove-label "<status label>" \
        │            --remove-label "<triage state label>"
        │   - A label the issue does not carry is not an error — drop it from the
        │     command and say so
        │   - A label the PROFILE does not declare is different: it was already
        │     raised at the gate, so clear the ones that did resolve and carry it
        │     to Step 7 as a finding. Never invent a name to fill the hole — a
        │     guessed label either fails the call or clears the wrong thing
        │   - Never create a label here (see ship-tail → Who creates a label)
        │   - The issue auto-closes via its closure keyword — no manual close needed
        │
        ├─► Step 6: Confirm the Branch Is Gone
        │   - Switch to the repo's default branch and pull — derive it, don't
        │     hardcode `main` (see project-profile → Git):
        │     git checkout <default> && git pull
        │   - Step 4 usually removed the local branch already. Confirm, and remove
        │     it if it survived: git branch -d <branch-name>
        │   - "branch not found" here means Step 4 did its job — not a failure
        │
        └─► Step 7: Report
            - Report per `agent-report`; Trace carries the merged PR URL, the head
              SHA the gate was confirmed at, and the labels cleared
            - A label name the profile never declared belongs in Findings, not in a
              footnote: name the key and the profile section it belongs in. Whatever
              that key would have named is still on the issue and now survives on
              closed work, which is the thing Step 5 exists to prevent
            - Next: nothing in this toolkit. The change has shipped — say so.
            - A follow-up the merge deliberately leaves behind is Not done (a choice);
              Unresolved is for what the merge left genuinely uncertain

---

## EXAMPLE

    /ship-merge 30

**Agent verifies, asks for the gate, records it, merges, cleans up:**

    $ gh pr view 30 --json mergeStateStatus,headRefName,headRefOid,comments
                                       # mergeable? head SHA a1b2c3d; confirmed already? no
    $ gh pr checks 30

    > Has PR #30 been reviewed and tested by a human at a1b2c3d?
    < yes

    $ gh pr comment 30 --body "Human review + test confirmed at a1b2c3d."
    $ gh pr merge 30 --merge --delete-branch
    $ gh issue view 27 --json labels --jq '[.labels[].name]'
                                       # ["status:needs-review","ready-for-agent"] — both there
    $ gh issue edit 27 --remove-label "status:needs-review" --remove-label "ready-for-agent"
    $ git checkout <default-branch> && git pull
    $ git branch -d issue-27-release-notes

**Output:**

    PR #30 merged at a1b2c3d: https://github.com/owner/repo/pull/30
    Human review + test confirmed and recorded on the PR.
    Issue #27 auto-closed; status:needs-review and ready-for-agent cleared.
    Branch issue-27-release-notes deleted (local + remote). You are on <default-branch>.

Run it again on the same PR and Step 2 finds its own comment at the unchanged head
SHA — the gate is satisfied from the record, and nobody is asked twice.

---

## API Notes

- Uses `gh` CLI for PR and issue operations
- `--merge` preserves full commit history; the strategy is a profile value
- `--delete-branch` removes the remote branch, and the local one too when run inside a
  clone. Step 5 is the check that it actually happened, not a second attempt: `git branch
  -d` on an already-deleted branch is a harmless error, and the checkout + pull is what
  leaves you somewhere sane either way.
- If the PR is not mergeable or CI fails, report the blocker instead of merging
- The gate comment is written by the agent on the human's answer, not by the human. That
  is deliberate: a signal a solo maintainer has to remember to leave is one that stops
  being left. Naming the SHA is what makes it a record rather than a rubber stamp
- `git branch -d` refuses an unmerged branch — that refusal is a signal, not a
  nuisance. Report it; do not reach for `-D`.
```
