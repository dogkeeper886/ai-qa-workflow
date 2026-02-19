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

## Notes

- Always use TestLink HTML format for content (see html-formatting.md)
- Preserve existing test case properties when updating
- Author login should be your TestLink username for new test cases
- Project ID should match your TestLink project (use list_projects to find it)
