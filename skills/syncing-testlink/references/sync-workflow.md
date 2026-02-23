# Sync Workflow Reference

## Full Sync Process

### Overview

Synchronize TestLink test cases with local test case files:
1. Compare local markdown files against TestLink suites
2. Skip matching cases, update differing cases, create missing cases
3. Verify counts match after sync

---

## Pre-Sync Validation

Before syncing, verify local files exist:
- `test_cases/README.md` - exists
- `test_cases/TS-XX_*.md` - at least one file exists

List all TS-XX files and count total test cases to sync.

---

## Step-by-Step Sync

### For Each TS-XX Scenario File

1. **Find matching suite in TestLink**
   - Match suite name to scenario name
   - If not found, create new suite first (see suite-and-plan.md)

2. **Get existing cases in suite**
   - Use `testlink-mcp:list_test_cases_in_suite`
   - Build a map of `{name: test_case_object}`

3. **For each test case in local file:**
   - Look up name in TestLink map
   - **MATCHING (all fields same):** Skip — add to "already matching" list
   - **DIFFERS:** Update only differing fields — add to "updated" list
   - **NEW:** Create with HTML formatting — add to "created" list

4. **Review preconditions after creation**
   - Retrieve all newly created test cases
   - Check each for missing/empty preconditions
   - Fix with `testlink-mcp:update_test_case` if needed

---

## Comparison Fields

Compare these fields between local and TestLink:
- `name` - Test case name
- `summary` - Objective/summary text
- `preconditions` - Setup requirements
- `steps.actions` - Step actions (each step)
- `steps.expected_results` - Expected results (each step)

---

## Final Verification

After sync, verify counts:
1. Count test cases in all local TS-XX files
2. Count test cases in TestLink for each suite
3. Report: local count vs TestLink count
4. **PASS** if counts match, **FAIL** if they differ

---

## Summary Report Format

```
### Summary Report:
- **Test Suite:** [Name] (ID: [suite_id])
- **Total Test Cases in Local File:** X
- **Total Test Cases in TestLink:** Y

### Test Cases Already Matching: X
- List test case IDs and names

### Test Cases Updated: X
- List test case IDs, names, and what was updated

### New Test Cases Created: X
- List new test case IDs and names

### Preconditions Fixed: X
- List test case IDs with precondition issues fixed

### Final Status:
✅ All X test cases synchronized successfully
```

---

## Batch Test Case Creation Guidelines

### Problem: Context Compaction and Drift

When creating many test cases (10+) in a single session, quality issues occur:

| Issue | Cause | Example |
|-------|-------|---------|
| **Terminology Drift** | Earlier context lost during compaction | "Group A/B" vs "Original-Group/New-Group" inconsistency |
| **Hallucination** | AI fills gaps with plausible but wrong details | Added zones/names that didn't exist in source |
| **Precondition/Step Mismatch** | Copied patterns from different test cases | TC-02 had unrelated language from another scenario |
| **Quality Degradation** | Later test cases worse than earlier ones | Last test suite created had the most issues |

### Prevention: Batch Size Limits

| Batch Size | Risk Level | Recommendation |
|------------|------------|----------------|
| 1-5 test cases | Low | Direct creation OK |
| 6-10 test cases | Medium | Create in 2 batches, verify after each |
| 11-20 test cases | High | Use JSON payload files + script execution |
| 20+ test cases | Very High | **Mandatory**: Use scripted approach with verification |

### Recommended Workflow for Large Test Case Sets

```
┌─────────────────────────────────────────────────────────────────┐
│  PHASE 1: Generate (per test suite, not all at once)           │
├─────────────────────────────────────────────────────────────────┤
│  1. Generate TS-01 test cases (max 5-6 TCs)                     │
│  2. Save to JSON payload files in test_cases/sync/payloads/    │
│  3. Review JSON against source MD before proceeding            │
│  4. Repeat for TS-02, TS-03, etc. (new session if needed)      │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│  PHASE 2: Verify Payloads                                       │
├─────────────────────────────────────────────────────────────────┤
│  For each payload file, verify:                                 │
│  □ Name matches source MD title                                 │
│  □ Preconditions align with test steps                          │
│  □ Terminology is consistent within the test case               │
│  □ No copied content from unrelated test cases                  │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│  PHASE 3: Execute via Script                                    │
├─────────────────────────────────────────────────────────────────┤
│  Option A: Use a project sync script to generate payloads       │
│  Option B: Direct MCP calls from verified JSON files            │
│  Option C: Ask Claude to execute one suite at a time            │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│  PHASE 4: Post-Creation Verification                            │
├─────────────────────────────────────────────────────────────────┤
│  1. Read test cases back from TestLink                          │
│  2. Compare against source MD (use comparison table)            │
│  3. Check: Names, Summaries, Preconditions, Steps alignment     │
│  4. Fix any discrepancies before moving to next suite           │
└─────────────────────────────────────────────────────────────────┘
```

### Verification Checklist (Per Test Case)

Before pushing to TestLink, verify each test case:

| Check | What to Verify |
|-------|----------------|
| **Name** | Matches source MD section title |
| **Summary** | Matches source MD objective |
| **Preconditions** | All items exist in source MD; terminology matches steps |
| **Steps** | Actions use same terminology as preconditions |
| **No Cross-Contamination** | No content copied from other test cases |

### Script-Based Approach for 20+ Test Cases

For large test case sets, create project-specific sync scripts. Example workflow:

```bash
# Example — adapt script names and paths to your project

# 1. Generate comparison report
python sync_testlink.py --compare

# 2. Review sync plan for discrepancies
cat sync/reports/SYNC_PLAN.md

# 3. Generate update payloads
python sync_testlink.py --generate-payloads

# 4. Review each payload file
ls sync/updates/*.json

# 5. Execute updates (via Claude or script)
python execute_updates.py --dry-run  # Preview
python execute_updates.py            # Execute
```

### Red Flags During Test Case Generation

Stop and review if you notice:

- Using terminology not in the source document
- Copying preconditions from a different test case
- Test steps that don't match the precondition setup
- Generating content without re-reading the source
- Session has been running for 30+ minutes with many tool calls

### Recovery: When Issues Are Found Post-Creation

1. **Create comparison table**: Source MD vs TestLink for affected test suite
2. **Identify specific discrepancies**: Name, preconditions, steps
3. **Fix TestLink first**: Using MCP update tool
4. **Update source MD**: To match corrected TestLink (if source was also wrong)
5. **Document lesson**: Add specific issue to project guidelines

---

## Test Case Correction Workflow

When test execution reveals discrepancies between documented test cases and actual system behavior:

1. **Update source markdown FIRST** (single source of truth) — correct steps/expected results, add Notes section documenting actual behavior
2. **Update Confluence page** — find page ID in `confluence/confluence_links.md`, update content, add version comment
3. **Update TestLink test case** — read current case to verify structure, update steps, maintain HTML formatting

**Key Points:**
- Source markdown is always the single source of truth
- Document findings in Notes section for future reference
- Use version comments to track why changes were made

---

## Notes

- Always use TestLink HTML format for content (see html-formatting.md)
- Preserve existing test case properties when updating
- Author login should be your TestLink username for new test cases
- Project ID should match your TestLink project (use list_projects to find it)
