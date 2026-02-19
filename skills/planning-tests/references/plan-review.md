# Test Plan Review Reference

## Purpose

Review test plan for completeness, gaps, and overlaps before creating test cases.

---

## Prerequisites

- `test_plan/README.md` exists

**If test plan is missing:**
```
Instruct user: "Please run /planning-tests first to create the test plan."
STOP - Cannot proceed without test plan
```

---

## When to Use

- **After** writing the test plan
- **Before** running /designing-cases
- When updating an existing test plan

---

## Review Steps

### Step 1: Read Test Plan

```
1. Read test_plan/README.md
2. Identify test plan type from header:
   - "New Feature Validation" → Comprehensive review
   - "Bug Fix Validation" → Focused review
   - "Enhancement Validation" → Hybrid review
3. Extract all test scenarios (TS-XX)
4. For each scenario, note:
   - Scenario ID and name
   - Focus area
   - Estimated test case count
   - Test activities listed
```

### Step 2: Analyze Coverage

For each test scenario, identify which aspects it covers:

| Coverage Aspect | Description |
|-----------------|-------------|
| UI Configuration | Tests that configure via user interface |
| API Configuration | Tests that configure via API |
| Data Flow | How data moves through the system |
| Error Handling | Invalid inputs, edge cases, failures |
| Backward Compatibility | Existing functionality still works |
| Client/End-user Validation | End-to-end user scenarios |
| Feature Flags | ON/OFF state behavior |
| Edge Cases | Boundary conditions, empty/max states |

### Step 3: Generate Coverage Matrix

```
┌────────────────────────┬───────┬───────┬───────┬───────┬───────┐
│ Test Aspect            │ TS-01 │ TS-02 │ TS-03 │ TS-04 │ TS-05 │
├────────────────────────┼───────┼───────┼───────┼───────┼───────┤
│ UI Configuration       │   ✓   │       │       │   ✓   │       │
│ API Configuration      │       │       │   ✓   │       │       │
│ Error Handling         │       │   ✓   │       │       │       │
│ Backward Compatibility │       │       │       │   ✓   │       │
│ Edge Cases             │       │       │       │       │   ✓   │
└────────────────────────┴───────┴───────┴───────┴───────┴───────┘
```

### Step 4: Identify Issues

**Gaps:**
- Aspects not covered by any test scenario
- Missing error handling tests
- Missing edge case coverage

**Overlaps:**
- Multiple scenarios testing the same aspect
- Redundant test activities

### Step 5: Apply Hybrid Depth Strategy

1. Identify the **representative case** for full verification (deep testing)
2. Identify **variants** for lightweight validation (wide testing)

---

## Output Format

```markdown
# Test Plan Review: [Feature Name]

## Summary
- **Test Plan Type:** [New Feature / Bug Fix / Enhancement]
- **Total Scenarios:** X
- **Total Estimated Test Cases:** Y
- **Coverage Score:** Good / Fair / Needs Improvement

## Coverage Matrix
[ASCII matrix]

## Gaps Identified

| Gap | Impact | Recommendation |
|-----|--------|----------------|
| [Gap 1] | [High/Medium/Low] | [How to address] |

## Recommendations

### Immediate Actions (Before Test Case Creation)
1. [Specific recommendation]

## Overall Assessment

**Status:** READY FOR TEST CASES / NEEDS REVISION
```

---

## Tips for Good Reviews

- Bug fix test plans: 2-4 focused scenarios
- Enhancement test plans: 4-6 scenarios
- New feature test plans: 5-8+ scenarios
- Good: "Test grouping threshold at 9, 10, 11 items"
- Bad: "Test various amounts"
