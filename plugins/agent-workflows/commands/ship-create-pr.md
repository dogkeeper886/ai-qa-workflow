# Create a Pull Request

## Rules

Doctrine — the same in every project, and travels with these units:
@${CLAUDE_PLUGIN_ROOT}/rules/ship-tail.md
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

    /ship-create-pr 27
        │
        ├─► Step 1: Verify Readiness
        │   - Confirm HEAD is on a branch at all. A detached HEAD is neither the
        │     default nor a feature branch, and Step 1a does not repair it — stop
        │     and say so, or Step 2 pushes an empty ref
        │   - Derive the default branch, don't hardcode `main` (see
        │     project-profile → Git)
        │   - Run: git status — the tree must be committed and clean, whichever
        │     branch you are on
        │   - If you are ON the default branch, go to Step 1a and come back.
        │     Nothing upstream creates a feature branch, so commits landing here
        │     is the ordinary case, not a mistake to scold anyone for
        │   - Review the branch's commits: git log --oneline <default>..HEAD
        │   - If no argument given, infer the issue number from the branch name
        │     (see project-profile → Linking & branch)
        │   - Run: gh issue view <N> — confirm the issue is the one this branch delivers
        │   - If there is no issue — none given, none inferable — say so and carry on
        │     without one. Steps 3 and 4 adapt below; do NOT invent an issue number,
        │     and do NOT stop. Not every change has a ticket behind it.
        │
        ├─► Step 1a: On the Default Branch — Move the Commits
        │   (skip entirely if Step 1 found you on a feature branch)
        │   - `/implement` ends at "commit your work to the current branch" and
        │     nothing before it branches, so the commits land on the default.
        │     Repair that here rather than refusing — but never silently
        │   - Show exactly what would move, and move nothing else:
        │       git fetch origin
        │       git log --oneline origin/<default>..HEAD
        │     Empty means there is nothing to ship at all — hand back per Step 5.
        │     If anything listed does not belong to this change, STOP and say so:
        │     carrying someone else's work onto this branch is not this command's
        │     call to make
        │   - The branch name comes from the profile's pattern, which needs the
        │     issue number and a slug from the issue title (see project-profile →
        │     Linking & branch). This is the one place where having no issue is
        │     NOT survivable — with no number there is nothing to name the branch
        │     from, so stop and ask for one
        │   - Ask before touching history. On no, hand back per Step 5 and do NOT
        │     go on to Step 2: pushing from the default branch is the very thing
        │     this step exists to prevent. On yes:
        │       git switch -c <branch-name>
        │       git branch -f <default> origin/<default>
        │     The first carries the commits onto the new branch; the second
        │     rewinds the default to what the remote already has. Nothing is
        │     discarded and the working tree is never touched — the commits are
        │     safe on the new branch, which is why no --hard reset appears here
        │   - Then return to Step 1's remaining checks on the branch you now have
        │
        ├─► Step 2: Push Branch
        │   - Run: git push -u origin $(git branch --show-current)
        │
        ├─► Step 3: Create PR
        │   - Title: short, imperative, under 70 characters
        │   - The body's issue line follows what this PR does to the issue:
        │       finishes it     → the closure keyword (see project-profile →
        │                         Linking & branch)
        │       one of several  → "Part of #N". The issue outlives this PR, so
        │                         the keyword would close it early
        │       no issue        → no line, and the report says this PR closes
        │                         nothing
        │   - A closure keyword fires from ANYWHERE in the body, and the parser
        │     reads the keyword and the number and nothing around them — so a
        │     sentence explaining that this PR must NOT close #N closes it. On
        │     the middle case write "Part of #N" and leave keywords unmentioned
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
        │   - Read back what the PR actually links and confirm it matches the
        │     intent above — the issue's number when this PR finishes it, empty
        │     otherwise:
        │       gh pr view <PR> --json closingIssuesReferences
        │     The link is computed a moment after the PR exists, so an empty
        │     first read can simply be too early. Read it again before believing
        │     an empty one, and treat a keyword you actually wrote as the truth
        │     the second read should confirm
        │   - A mismatch that survives the re-read is cheap here and expensive
        │     after a merge, where the repair is reopening an issue that closed
        │     itself. Fix the body with gh pr edit --body, then read it back once
        │     more
        │
        ├─► Step 4: Update Issue Labels   (skip entirely if there is no issue)
        │   - Ensure the label this step APPLIES exists — applying one the repo
        │     lacks fails outright. Resolve name, colour and description from the
        │     profile (see project-profile → Labels); do NOT copy a literal colour
        │     in, because --force UPDATES an existing label and would overwrite a
        │     downstream's own choice on every run:
        │       gh label create "<name>" --color "<hex>" \
        │              --description "<text>" --force
        │   - Read what the issue actually carries, so the removal names only a
        │     label that is there:
        │       gh issue view <N> --json labels --jq '[.labels[].name]'
        │   - Move the issue's status label to "under review":
        │     gh issue edit <N> --remove-label "status:in-progress" \
        │            --add-label "status:needs-review"
        │   - A label the issue does not carry is not an error — drop it from the
        │     command and say so. Leaving it in fails the whole call, and would
        │     take the --add-label down with it
        │   - Comment on issue:
        │     gh issue comment <N> --body "PR #<PR> created. Summary: <what changed>"
        │
        └─► Step 5: Report
            - Report per `agent-report`; Trace carries the PR URL
            - Next is the HUMAN review + test — stop here, don't auto-advance.
              Merge with /ship-merge <PR> only once a human is satisfied.

---

## EXAMPLE

    /ship-create-pr 27

**Agent verifies, pushes, creates PR:**

    $ git status
    $ git log --oneline <default-branch>..HEAD
    $ git push -u origin issue-27-release-notes
    $ gh pr create --title "Add release notes generator command" --body "..."
    $ gh pr view 30 --json closingIssuesReferences
                                       # [27] — this PR finishes the issue, as intended
    $ gh label create "status:needs-review" --color "fbca04" \
             --description "PR open, awaiting review" --force
                                       # all three resolved from project-profile → Labels
    $ gh issue view 27 --json labels --jq '[.labels[].name]'
                                       # ["status:in-progress"] — carried, so safe to remove
    $ gh issue edit 27 --remove-label "status:in-progress" --add-label "status:needs-review"
    $ gh issue comment 27 --body "PR #30 created."

**Output:**

    PR #30 created: https://github.com/owner/repo/pull/30
    A human reviews + tests it; merge with /ship-merge 30 when satisfied.

**Started on the default branch instead — Step 1a first, then the above:**

    $ git status
                                       # on <default-branch>, clean
    $ git fetch origin
    $ git log --oneline origin/<default-branch>..HEAD
                                       # a1b2c3d feat(#27): add release notes generator
                                       # one commit, and it is this change's

    > Move that commit onto issue-27-release-notes and rewind <default-branch>?
    < yes

    $ git switch -c issue-27-release-notes
    $ git branch -f <default-branch> origin/<default-branch>

---

## API Notes

- Uses `gh` CLI for PR and issue operations
- `Fixes #N` in PR body auto-closes the issue when PR is merged — from anywhere in the
  body, prose included, which is why Step 3 reads the link back instead of trusting it
- Copy relevant labels from the issue to the PR if needed
- If branch is already pushed, the push step is a no-op
- Step 1a only ever moves what the remote does not already have, so a commit already
  pushed to the default branch is out of its reach by construction
```
