# Test Case Review

Review test cases for quality and completeness before TestLink sync.

## Purpose

Analyze test case files to:
1. Verify test case quality (clear steps, measurable results)
2. Check completeness (all scenarios covered, no gaps)
3. Identify issues early before TestLink sync
4. Ensure test cases are ready for execution

## Prerequisites

- `test_cases/README.md` exists (created by `/tw-case-*` commands)
- `test_cases/TS-XX_*.md` files exist for each scenario
- `test_plan/README.md` and `test_plan/sections/` exist (for comparison)

**If test cases are missing:**
```
Ask user: "Please run /tw-case-init first to create test cases."
STOP - Cannot proceed without test case files
```

## When to Use

- **After** running `/tw-case-feature`, `/tw-case-bugfix`, or `/tw-case-enhance`
- **Before** running `/tl-sync`
- When updating existing test cases
- Before test execution begins

## Agent Instructions

### Step 1: Read Test Plan

Read the test plan for comparison baseline:

```
1. Read test_plan/README.md for type and quick reference counts
2. Read the Test Strategy section file for scenario details:
   - Feature: test_plan/sections/04_Test_Strategy.md § 4.4
   - Bug Fix: test_plan/sections/03_Test_Strategy.md § 3.2
   - Enhancement: test_plan/sections/04_Test_Strategy.md § 4.2
3. Reference coverage matrix from /tw-plan-review (if available)
4. Note the test plan type:
   - "New Feature Validation" → Expect 20-40 test cases
   - "Bug Fix Validation" → Expect 8-15 test cases
   - "Enhancement Validation" → Expect 15-25 test cases
```

> **Fallback:** If `test_plan/sections/` does not exist, read `test_plan/README.md` directly.

### Step 2: Read All Test Case Files

```
1. Read test_cases/README.md
   - Extract scenario index
   - Note total test case count
   - Check default assumptions section

2. Read each TS-XX_*.md file
   - Count test cases per scenario
   - Extract test case names and objectives
   - Note preconditions, steps, and expected results
```

### Step 3: Quality Checks

For each test case, verify the following quality criteria:

#### 3.1 Clear Objective
- [ ] Objective states WHAT is being validated
- [ ] Objective is specific, not vague
- [ ] Objective matches the test steps

**Good:** "Verify that entering a name shorter than 2 characters displays validation error"
**Bad:** "Test name validation"

#### 3.2 Complete Preconditions
- [ ] All required setup is listed
- [ ] No missing dependencies
- [ ] Preconditions use same terminology as test steps
- [ ] No items referenced in steps that aren't set up

**Good:** "User Group 'Test-Group-A' exists with 2 members assigned"
**Bad:** "User Group configured"

#### 3.3 Specific Actions
- [ ] Actions use exact values, not placeholders
- [ ] Actions specify which element to interact with
- [ ] Actions are atomic (one action per step)

**Good:** "Enter 'test@example.com' in the Email field"
**Bad:** "Enter data in the field"

#### 3.4 Measurable Expected Results
- [ ] Expected results are observable and verifiable
- [ ] Expected results include specific text/values where applicable
- [ ] Expected results describe the outcome, not the action

**Good:** "Error message displays: 'Email format is invalid'"
**Bad:** "Verify error handling works"

#### 3.5 Appropriate Step Count
- [ ] 3-10 steps is typical for most test cases
- [ ] Flag test cases with >15 steps for potential splitting
- [ ] Flag test cases with <3 steps as potentially incomplete

#### 3.6 Test Independence
- [ ] Test can run standalone without prior tests
- [ ] All setup is in preconditions
- [ ] No reliance on state from other test cases

### Step 4: Completeness Check

Compare test cases against test plan:

```
1. Count test cases per scenario
2. Compare against test plan estimates
3. Flag scenarios with significantly fewer test cases than expected
4. Check for missing:
   - Error handling tests
   - Edge case tests
   - Boundary condition tests
```

### Step 5: Consistency Check

Verify consistency across test cases:

```
1. Terminology consistency
   - Same names used throughout (not "Group A" vs "Original-Group")
   - Same navigation paths described consistently

2. Format consistency
   - All files use same structure
   - All test cases have required sections
   - Summary tables are complete

3. Cross-reference accuracy
   - TC counts in README.md match actual files
   - Scenario references are correct
```

### Step 6: Generate Review Report

Create the review report with findings.

---

## Output Format

```markdown
# Test Case Review: [Feature Name]

## Summary

| Metric | Value |
|--------|-------|
| Test Scenarios | X (Expected: Y) |
| Test Cases | Z |
| Quality Score | Good / Fair / Needs Work |
| TestLink Readiness | Ready / Needs Revision |

## Quality Issues

### Vague Actions

| File | TC | Step | Issue | Suggested Fix |
|------|-----|------|-------|---------------|
| TS-01 | TC-02 | 3 | "Enter data" | Specify exact value to enter |
| TS-02 | TC-01 | 5 | "Configure settings" | List specific settings to configure |

### Vague Expected Results

| File | TC | Step | Issue | Suggested Fix |
|------|-----|------|-------|---------------|
| TS-01 | TC-03 | 4 | "Verify success" | Specify expected message or state |
| TS-03 | TC-02 | 7 | "Page updates" | Describe what should appear/change |

### Missing Preconditions

| File | TC | Issue |
|------|-----|-------|
| TS-01 | TC-03 | Step 2 uses "Group-A" but not defined in preconditions |
| TS-02 | TC-04 | References "admin user" but preconditions say "test user" |

### Long Test Cases (>10 steps)

| File | TC | Steps | Recommendation |
|------|-----|-------|----------------|
| TS-03 | TC-02 | 18 | Split into "Setup" and "Validation" test cases |
| TS-04 | TC-05 | 15 | Consider breaking at step 8 (natural division point) |

### Terminology Inconsistencies

| Issue | Locations | Recommendation |
|-------|-----------|----------------|
| "Group A" vs "Original-Group" | TS-01 TC-02, TS-03 TC-01 | Standardize to "Original-Group" |
| "Save button" vs "Save Changes" | TS-02 TC-03, TS-02 TC-04 | Use exact UI label |

## Completeness Check

| Scenario | Expected TCs | Actual TCs | Status | Notes |
|----------|--------------|------------|--------|-------|
| TS-01 | 5-6 | 5 | OK | |
| TS-02 | 4-5 | 2 | **Missing** | Need error handling tests |
| TS-03 | 3-4 | 4 | OK | |
| TS-04 | 4-5 | 3 | **Missing** | Missing edge cases |

### Missing Test Coverage

| Scenario | Missing Coverage | Recommendation |
|----------|------------------|----------------|
| TS-02 | Error handling for invalid input | Add TC for invalid email format |
| TS-04 | Boundary: maximum name length | Add TC for 64-character name |

## Recommendations

### Must Fix Before TestLink Sync
1. [Critical issue with specific file/TC reference]
2. [Critical issue with specific file/TC reference]

### Should Fix
1. [Important improvement with file/TC reference]
2. [Important improvement with file/TC reference]

### Nice to Have
1. [Optional enhancement]
2. [Optional enhancement]

## Overall Assessment

**Status:** READY FOR TESTLINK / NEEDS REVISION

[Summary of test case quality and specific next steps]

---

## Next Steps

If READY FOR TESTLINK:
1. Run `/tl-sync` to sync test cases to TestLink
2. Verify synced test cases in TestLink UI

If NEEDS REVISION:
1. Address "Must Fix" items
2. Re-run `/tw-case-review` to verify fixes
3. Then proceed to `/tl-sync`
```

---

## Example Usage

```
User: /test-case-review

Agent:
1. Reads test_plan/README.md + test_plan/sections/ for baseline
2. Reads test_cases/README.md for index
3. Reads each TS-XX_*.md file
4. Checks quality of each test case
5. Compares actual vs expected counts
6. Generates review report with findings
7. Provides recommendations and next steps
```

---

## Workflow Position

```
┌─────────────────────────────────────────────────────────────────┐
│                    TEST DOCUMENTATION WORKFLOW                   │
└─────────────────────────────────────────────────────────────────┘

/jr-trace [TICKET]
    └── Creates project structure and gathers documentation

/tw-plan-init → /tw-plan-[feature|bugfix|enhance]
    └── Creates test_plan/README.md + test_plan/sections/*.md

/tw-plan-review
    └── Reviews test plan for gaps and overlaps

/tw-case-init → /tw-case-[feature|bugfix|enhance]
    └── Creates test_cases/README.md + TS-XX_*.md files
                              ↓
              ┌───────────────────────────────┐
              │  /tw-case-review  ◄── YOU     │
              │  Reviews test case quality    │
              └───────────────────────────────┘
                              ↓
/tl-sync
    └── Syncs reviewed test cases to TestLink
```

---

## Quality Criteria Reference

### Action Verbs (Good)
- Navigate, Click, Select, Enter, Type
- Verify, Observe, Confirm, Check
- Wait, Scroll, Hover, Drag
- Upload, Download, Submit, Save

### Vague Terms to Flag
- "data" → Specify the actual data
- "some" → Specify the quantity
- "appropriate" → Define what is appropriate
- "correct" → Describe the correct state
- "works" → Describe the expected behavior
- "properly" → Define what properly means

### Expected Result Patterns (Good)
- "Message displays: '[exact text]'"
- "Page redirects to [specific page]"
- "Field shows value: [specific value]"
- "Button becomes [enabled/disabled]"
- "List contains [N] items"
- "Error icon appears next to [field name]"

### Expected Result Patterns (Bad)
- "Verify it works"
- "Check the result"
- "Should be correct"
- "Page updates properly"
- "Success"
