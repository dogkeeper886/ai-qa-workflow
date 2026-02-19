# Test Case Initialization Reference

## Purpose

Analyze the test plan to:
1. Read the test plan type from header
2. Verify prerequisites are in place
3. Route to the appropriate test case workflow

---

## Prerequisites

Before starting, verify these files exist:
- [ ] `test_plan/README.md` or `TEST_PLAN.md` - Must exist (created by /planning-tests skill)
- [ ] Test scenarios defined in test plan (§ 3.2 for bug fixes, § 4.4 for features)

**If test plan is missing:**
```
Instruct user: "Please run /planning-tests first to create the test plan."
STOP - Cannot proceed without test plan
```

---

## Step 1: Read Test Plan Type

```
READ test_plan/README.md (or TEST_PLAN.md) header
FIND "Test Plan Type:" field

IF "New Feature Validation":
  → Type A detected
  → Use feature-cases.md approach
  → Expect: 20-40 test cases across 5-8 scenarios

IF "Bug Fix Validation":
  → Type B detected
  → Use bugfix-cases.md approach
  → Expect: 8-15 test cases across 2-4 scenarios

IF "Enhancement Validation":
  → Type C detected
  → Use enhance-cases.md approach
  → Expect: 15-25 test cases across 4-6 scenarios
```

---

## Step 2: Extract Test Scenarios

```
READ test plan § 4.4 (features/enhancements) or § 3.2 (bug fixes)
EXTRACT test scenario table

FOR EACH scenario:
  - Scenario ID (TS-XX)
  - Scenario name
  - Focus area
  - Estimated test case count
  - Test activities listed
```

---

## Output Format

```markdown
# Test Case Initialization: [Project Name]

## Test Plan Analysis

**Test Plan Type:** [Type A/B/C]: [Description]
**Test Plan Version:** [Version from header]
**Test Scenarios:** [Count]
**Estimated Test Cases:** [Total from test plan]

## Test Scenarios Found

| ID | Scenario Name | Focus | Est. Cases |
|----|---------------|-------|------------|
| TS-01 | [Name] | [Focus] | [N] |
| TS-02 | [Name] | [Focus] | [N] |

## Recommended Next Step

Proceeding with [feature/bugfix/enhance] test case creation...

**Expected Output:**
- `test_cases/README.md` - Index file
- `test_cases/TS-01_[Name].md` - Scenario 1 test cases
- `test_cases/TS-02_[Name].md` - Scenario 2 test cases

## Quick Reference

| Test Plan Type | Expected TCs |
|----------------|--------------|
| New Feature | 20-40 |
| Bug Fix | 8-15 |
| Enhancement | 15-25 |
```

---

## Output File Structure

```
test_cases/
├── README.md                        # Index and summary
├── TS-01_[Scenario_Name].md         # First test scenario
├── TS-02_[Scenario_Name].md         # Second test scenario
└── TS-XX_[Scenario_Name].md         # Additional scenarios
```
