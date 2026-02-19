# Feature Test Cases Reference (Type A)

## Purpose

Create comprehensive test cases for new features:
- Step-by-step test execution procedures
- TestLink-ready format
- One file per test scenario
- Expected: 20-40 test cases across 5-8 scenarios

---

## Information Sources

**PRIMARY SOURCE (Required):**
1. **TEST_PLAN.md § 4.4** - Test scenarios to expand into test cases
2. **TEST_PLAN.md § 4.3** - Priority operations (example test operations)
3. **TEST_PLAN.md § 3.1** - In-scope testing categories

**SECONDARY SOURCES (Reference):**
4. **Confluence HLD** (`confluence/HLD_*.md`) - For detailed acceptance criteria
5. **UX Design Tickets** (`01_*UX*.md`) - For exact UI element names
6. **README.md** - For feature behavior clarification

---

## Step-by-Step Workflow

### Step 1: Parse TEST_PLAN.md
```
1. Read TEST_PLAN.md § 4.4 (Test Scenarios table)
2. Count test scenarios (TS-01, TS-02, etc.)
3. For each scenario, extract:
   - Scenario ID (TS-XX)
   - Scenario name, Focus area, Estimated test case count, Test activities
4. Note priority operations from § 4.3 (use as examples)
```

### Step 2: Create Directory and README.md
```markdown
# Test Cases: [Feature Name] ([Ticket ID])

**Version:** 1.0
**Created:** [Date]
**QA Engineer:** [Name]

## Default Test Assumptions
[Copy from test plan § 4.3]

## Test Scenarios Index
| File | Scenario | Test Cases |
|------|----------|------------|
| [TS-01_*.md] | [Name] | TC-01 to TC-XX |
```

### Step 3: Create Separate File for Each Test Scenario

**FOR EACH test scenario in test plan § 4.4:**

1. Create `test_cases/TS-XX_[Scenario_Name].md`

2. Add file header:
```markdown
# TS-XX: [Scenario Name]

**Objective:** [Copy from test plan]
**Focus:** [From "Focus" column]
**Test Cases:** [Count]
**Test Plan Reference:** test_plan/README.md § 4.4, TS-XX
```

3. For each test activity, create test case variations:
```markdown
## TC-XX: [Descriptive Name]

**Objective:**
[Specific behavior validated]

**Preconditions:**
- [Only non-default requirements]
- [Specific test data needed]

**Test Steps:**

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1 | [Specific action] | [Measurable result] |
| 2 | [Next action] | [Expected outcome] |

**Execution Type:** Manual
```

4. Add Summary table at end of file:
```markdown
## Summary

| TC ID | Name | Priority | Type |
|-------|------|----------|------|
| TC-01 | ... | P0 | Functional |
```

5. SAVE file before moving to next scenario
6. Update README.md index
7. Move to next scenario

---

## Quality Guidelines

### Be Specific, Not Vague
- **Bad:** "Enter data" → **Good:** "Enter 'test@example.com' in Email field"
- **Bad:** "Verify result" → **Good:** "Message displays: 'Success'"

### Appropriate Test Case Counts
- Simple scenario: 2-4 test cases
- Moderate scenario: 5-8 test cases
- Complex scenario: 8-12 test cases
- If creating 20+: Split into 2 scenarios

### Priority Assignment
- **P0 (Critical):** Core functionality, happy path
- **P1 (High):** Important variations, common scenarios
- **P2 (Medium):** Edge cases, rare scenarios

### Test Variations
Create variations based on:
- **Volume:** small (2-3), medium (10-20), large (50-100+)
- **State:** enabled, disabled, partial, full
- **Data:** valid, invalid, boundary, special characters

---

## Decision Trees

### Vague Test Activity
```
IF test activity is vague (e.g., "Test notification grouping"):
  1. Identify the operation
  2. Create volume variations (below, at, above threshold)
  3. Create data variations (single type, multiple types)
  4. Create edge cases (empty, maximum)
  Result: 1 vague activity → 5-6 specific test cases
```

### No Volume Guidance
```
IF test plan doesn't specify volumes:
  1. Check HLD for thresholds
  2. Use defaults: Small=2-3, Medium=10-20, Large=50-100+
  3. Document assumption
```
