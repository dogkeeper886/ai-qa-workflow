# Bug Fix Test Cases Reference (Type B)

## Purpose

Create focused test cases for bug fixes:
- Defect verification test cases
- Regression test cases
- Edge case prevention
- Expected: 8-15 test cases across 2-4 scenarios

---

## Information Sources

**PRIMARY SOURCE (Required):**
1. **TEST_PLAN.md § 3.2** - Test scenarios (bug fix plans use section 3)
2. **TEST_PLAN.md § 1.2** - Reproduction steps (critical for defect verification)
3. **TEST_PLAN.md § 2.1-2.3** - Test scope

**SECONDARY SOURCES (Reference):**
4. **Bug Ticket** (`00_Main_Task_*.md`) - Original reproduction steps
5. **README.md** - Problem summary

---

## Output File Structure

```
test_cases/
├── README.md                        # Index and summary
├── TS-01_Defect_Verification.md     # Defect verification tests
├── TS-02_Regression_Testing.md      # Regression tests
└── TS-03_Edge_Cases.md              # Edge case prevention
```

---

## Step-by-Step Workflow

### Step 1: Parse Bug Fix Test Plan
```
1. Read TEST_PLAN.md § 1.2 - Extract reproduction steps
   - These become the basis for TS-01 (Defect Verification)
2. Read TEST_PLAN.md § 3.2 - Test scenarios (typically 2-4)
3. Read TEST_PLAN.md § 1.3 - Fix summary
   - Identify component/area affected for regression scope
```

### Step 2: Create Defect Verification Test Cases (TS-01)

```markdown
# TS-01: Defect Verification

**Objective:** Verify the original bug no longer occurs
**Focus:** Defect verification
**Test Cases:** 2-3
**Test Plan Reference:** test_plan/README.md § 1.2

---

## TC-01: Reproduce Original Bug

**Objective:** Verify original bug no longer occurs using exact reproduction steps

**Preconditions:**
- [Copy from TEST_PLAN.md § 1.2]

**Test Steps:**

| Step | Action | Expected Result |
|------|--------|-----------------|
| [Copy exact steps from § 1.2] | [Expected behavior - NOT the bug] |

**Execution Type:** Manual

---

## TC-02: Defect Variation 1

**Objective:** Verify fix works with slightly different data

---

## Summary

| TC ID | Name | Priority | Type |
|-------|------|----------|------|
| TC-01 | Reproduce Original Bug | P0 | Defect Verification |
| TC-02 | Defect Variation 1 | P0 | Defect Verification |
```

### Step 3: Create Regression Test Cases (TS-02)

```markdown
# TS-02: Regression Testing

**Objective:** Verify fix didn't break related functionality
**Focus:** Regression
**Test Cases:** 2-3
**Test Plan Reference:** test_plan/README.md § 2.2

---

## TC-01: Related Operation 1

**Objective:** Verify [related operation] still works correctly

**Test Steps:**

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1 | [Test related operation] | [Expected behavior] |

---

## Summary

| TC ID | Name | Priority | Type |
|-------|------|----------|------|
| TC-01 | Related Operation 1 | P1 | Regression |
```

### Step 4: Create Edge Case Test Cases (TS-03)

```markdown
# TS-03: Edge Cases & Prevention

**Objective:** Prevent similar bugs through edge case coverage
**Focus:** Edge Cases
**Test Cases:** 2-4
**Test Plan Reference:** test_plan/README.md § 2.3

---

## TC-01: Boundary Condition
**Objective:** Verify behavior at boundary limits

## TC-02: Empty/Zero State
**Objective:** Verify behavior with empty data

## TC-03: Large Volume
**Objective:** Verify behavior under stress
```

### Step 5: Keep It Focused

Bug fix test cases should be FOCUSED:
- **Total:** 8-15 test cases (not 40+)
- **Priority:** Most should be P0 or P1
- **Depth over breadth:** Thorough testing of affected area

---

## Quality Guidelines

### Bug Fix Priority
- **P0:** Defect verification (must pass)
- **P0:** Critical regression
- **P1:** Standard regression, edge cases
- **P2:** Nice-to-have edge cases

### Test Independence
- Each test runs standalone
- Include all setup in preconditions
- Don't rely on other test states
