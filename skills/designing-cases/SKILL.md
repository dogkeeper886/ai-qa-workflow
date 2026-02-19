---
name: designing-cases
description: |
  Writes detailed test cases from a test plan, reviews quality, and publishes
  a test case page to Confluence. Use when a QA engineer wants to design cases,
  create test cases, write test cases, or expand test scenarios into detailed
  steps.
disable-model-invocation: true
tools:
  - mcp-atlassian:confluence_create_page
  - mcp-atlassian:confluence_get_page
---

# designing-cases

Writes detailed test cases from a test plan, reviews quality, and publishes to Confluence.

## Progress Checklist

Copy and track your progress:

```
- [ ] Step 1: Validate prerequisites
- [ ] Step 2: Read plan, extract scenarios
- [ ] Step 3: Write test cases per type
- [ ] Step 4: Review quality
- [ ] Validate: Scenario count + case count + quality assessment
- [ ] Step 5: Create Confluence test case pages
- [ ] Validate: Confluence URL + page count
```

## Steps

### Step 1: Validate Prerequisites

Check that `test_plan/README.md` exists.

If missing: "Please run `/planning-tests` first to create the test plan."

### Step 2: Read Plan and Extract Scenarios

Read `test_plan/README.md`, identify:
- Test Plan Type (New Feature / Bug Fix / Enhancement)
- All TS-XX scenarios with estimated case counts

See `references/case-init.md` for initialization logic and routing.

### Step 3: Write Test Cases

Create `test_cases/README.md` and one `TS-XX_[Name].md` file per scenario.

Route to the appropriate reference based on plan type:
- **Feature (Type A):** see `references/feature-cases.md` — expect 20-40 cases
- **Bug Fix (Type B):** see `references/bugfix-cases.md` — expect 8-15 cases
- **Enhancement (Type C):** see `references/enhance-cases.md` — expect 15-25 cases

Each test case needs: Objective, Preconditions, Test Steps table, Execution Type.

### Step 4: Review Quality

Check all test cases for:
- Specific (not vague) actions and expected results
- Complete preconditions
- 3-10 steps per test case
- Test independence (can run standalone)

See `references/case-review.md` for quality checklist and common issues.

### Validate

Report:
- Total scenario count
- Total test case count
- Quality assessment: **READY FOR TESTLINK** or **NEEDS REVISION**

### Step 5: Create Confluence Pages

Create test case pages in Confluence:
- Parent page: `[TICKET]: Test Cases - [Feature Name]`
- Child pages for each TS-XX scenario

See `references/confluence-page.md` for naming conventions and formatting review.

**MCP tool:** `mcp-atlassian:confluence_create_page`

### Validate

Report:
- Confluence parent page URL
- Number of pages created

## Expected Input

Path to project folder containing `test_plan/README.md`.

## Next Step

After designing cases, run `/syncing-testlink` to import test cases to TestLink.
