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

    /dw-merge 30
        │
        ├─► Step 1: Verify Ready to Merge
        │   - Run: gh pr view <PR> --json mergeStateStatus,headRefName,reviewDecision
        │   - Must be mergeable (no conflicts)
        │   - Run: gh pr checks <PR> — any CI checks must pass (if applicable)
        │   - The merge gate is HUMAN review + test, not a GitHub approval. On a
        │     solo repo GitHub blocks self-approval, so do NOT require
        │     reviewDecision=APPROVED. Before merging, confirm a human has reviewed
        │     and tested the change. If not yet reviewed/tested, stop and say so.
        │
        ├─► Step 2: Identify the Linked Issue
        │   - Read the PR body for its closure keyword (see project-profile →
        │     Linking & branch) and note the issue number for label cleanup
        │   - If the PR closes no issue, skip Step 4 and say so in the report
        │
        ├─► Step 3: Merge
        │   - Run: gh pr merge <PR> --merge --delete-branch
        │   - The merge strategy is a project value (see project-profile → Git)
        │   - --delete-branch cleans up the remote branch
        │
        ├─► Step 4: Clear the Issue's Labels
        │   - Remove the status label the ship tail set, and the triage state
        │     label (see project-profile → Labels):
        │     gh issue edit <N> --remove-label "status:needs-review" \
        │            --remove-label "ready-for-agent"
        │   - A label the issue does not carry is not an error — skip it and say so
        │   - The issue auto-closes via its closure keyword — no manual close needed
        │
        ├─► Step 5: Confirm the Branch Is Gone
        │   - Switch to the repo's default branch and pull — derive it, don't
        │     hardcode `main` (see project-profile → Git):
        │     git checkout <default> && git pull
        │   - Step 3 usually removed the local branch already. Confirm, and remove
        │     it if it survived: git branch -d <branch-name>
        │   - "branch not found" here means Step 3 did its job — not a failure
        │
        └─► Step 6: Report
            - Report per `agent-report`; Trace carries the merged PR URL and the
              labels cleared
            - Next: nothing in this toolkit. The change has shipped — say so.
            - A follow-up the merge deliberately leaves behind is Not done (a choice);
              Unresolved is for what the merge left genuinely uncertain

---

## EXAMPLE

    /dw-merge 30

**Agent verifies, merges, cleans up:**

    $ gh pr view 30 --json mergeStateStatus,headRefName,reviewDecision  # mergeable? (don't gate on self-approval)
    $ gh pr checks 30
    $ gh pr merge 30 --merge --delete-branch
    $ gh issue edit 27 --remove-label "status:needs-review" --remove-label "ready-for-agent"
    $ git checkout <default-branch> && git pull
    $ git branch -d issue-27-release-notes

**Output:**

    PR #30 merged: https://github.com/owner/repo/pull/30
    Issue #27 auto-closed; status:needs-review and ready-for-agent cleared.
    Branch issue-27-release-notes deleted (local + remote). You are on <default-branch>.

---

## API Notes

- Uses `gh` CLI for PR and issue operations
- `--merge` preserves full commit history; the strategy is a profile value
- `--delete-branch` removes the remote branch, and the local one too when run inside a
  clone. Step 5 is the check that it actually happened, not a second attempt: `git branch
  -d` on an already-deleted branch is a harmless error, and the checkout + pull is what
  leaves you somewhere sane either way.
- If the PR is not mergeable or CI fails, report the blocker instead of merging
- `git branch -d` refuses an unmerged branch — that refusal is a signal, not a
  nuisance. Report it; do not reach for `-D`.
```
