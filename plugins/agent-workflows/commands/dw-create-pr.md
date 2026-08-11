# Create a Pull Request

## Rules

Doctrine — the same in every project, and travels with these units:
@${CLAUDE_PLUGIN_ROOT}/rules/agent-report.md
@${CLAUDE_PLUGIN_ROOT}/rules/profile-doctrine.md

Values — this project's:
@.claude/rules/project-profile.md

```
Push branch and open a pull request with issue linkage.

Issue number: {{input}}

## PURPOSE

The first half of the **ship tail** — the stretch between a commit and a merge.
Pushes the current branch, opens a pull request, and links it to its issue via
"Fixes #N" so the issue closes on merge instead of by hand.

Takes a committed branch and nothing else. There is no story file, plan issue, or
preceding command it needs — run it straight after whatever produced the commits.

---

## WORKFLOW

    /dw-create-pr 27
        │
        ├─► Step 1: Verify Readiness
        │   - Confirm you're on a feature branch, not the default branch —
        │     derive the default, don't hardcode `main` (see project-profile → Git)
        │   - Run: git status — the branch must be committed and clean
        │   - Review the branch's commits: git log --oneline <default>..HEAD
        │   - If no argument given, infer the issue number from the branch name
        │     (see project-profile → Linking & branch)
        │   - Run: gh issue view <N> — confirm the issue is the one this branch delivers
        │
        ├─► Step 2: Push Branch
        │   - Run: git push -u origin $(git branch --show-current)
        │
        ├─► Step 3: Create PR
        │   - Title: short, imperative, under 70 characters
        │   - Body must carry the issue closure keyword (see project-profile →
        │     Linking & branch)
        │   - Use this template:
        │
        │       gh pr create --title "<title>" --body "$(cat <<'EOF'
        │       ## Summary
        │       <1-3 bullet points>
        │
        │       Fixes #<issue-number>
        │
        │       ## Test plan
        │       - [ ] ...
        │
        │       Generated with [Claude Code](https://claude.com/claude-code)
        │       EOF
        │       )"
        │
        ├─► Step 4: Update Issue Labels
        │   - Move the issue's status label to "under review" (see project-profile
        │     → Labels):
        │     gh issue edit <N> --remove-label "status:in-progress" \
        │            --add-label "status:needs-review"
        │   - A label the issue does not carry is not an error — skip it and say so
        │   - Comment on issue:
        │     gh issue comment <N> --body "PR #<PR> created. Summary: <what changed>"
        │
        └─► Step 5: Report
            - Report per `agent-report`; Trace carries the PR URL
            - Next is the HUMAN review + test — stop here, don't auto-advance.
              Merge with /dw-merge <PR> only once a human is satisfied.

---

## EXAMPLE

    /dw-create-pr 27

**Agent verifies, pushes, creates PR:**

    $ git status
    $ git log --oneline <default-branch>..HEAD
    $ git push -u origin issue-27-release-notes
    $ gh pr create --title "Add release notes generator command" --body "..."
    $ gh issue edit 27 --remove-label "status:in-progress" --add-label "status:needs-review"
    $ gh issue comment 27 --body "PR #30 created."

**Output:**

    PR #30 created: https://github.com/owner/repo/pull/30
    A human reviews + tests it; merge with /dw-merge 30 when satisfied.

---

## API Notes

- Uses `gh` CLI for PR and issue operations
- `Fixes #N` in PR body auto-closes the issue when PR is merged
- Copy relevant labels from the issue to the PR if needed
- If branch is already pushed, the push step is a no-op
```
