# Test Case Review Reference

## Purpose

Review test case files for quality and completeness before TestLink sync.

---

## Prerequisites

- `test_cases/README.md` exists
- `test_cases/TS-XX_*.md` files exist for each scenario
- `test_plan/README.md` exists (for comparison)

**If test cases are missing:**
```
Instruct user: "Please run /designing-cases first to create test cases."
STOP - Cannot proceed without test case files
```

---

## Quality Checks

For each test case, verify:

### 3.1 Clear Objective
- [ ] Objective states WHAT is being validated
- [ ] Objective is specific, not vague
- **Good:** "Verify that entering a name shorter than 2 characters displays validation error"
- **Bad:** "Test name validation"

### 3.2 Complete Preconditions
- [ ] All required setup is listed
- [ ] No missing dependencies
- **Good:** "User Group 'Test-Group-A' exists with 2 members assigned"
- **Bad:** "User Group configured"

### 3.3 Specific Actions
- [ ] Actions use exact values, not placeholders
- [ ] Actions specify which element to interact with
- **Good:** "Enter 'test@example.com' in the Email field"
- **Bad:** "Enter data in the field"

### 3.4 Measurable Expected Results
- [ ] Expected results are observable and verifiable
- [ ] Expected results include specific text/values where applicable
- **Good:** "Error message displays: 'Email format is invalid'"
- **Bad:** "Verify error handling works"

### 3.5 Appropriate Step Count
- [ ] 3-10 steps is typical for most test cases
- [ ] Flag test cases with >15 steps for potential splitting
- [ ] Flag test cases with <3 steps as potentially incomplete

### 3.6 Test Independence
- [ ] Test can run standalone without prior tests
- [ ] All setup is in preconditions

---

## Completeness Check

Compare test cases against test plan:
1. Count test cases per scenario
2. Compare against test plan estimates
3. Flag scenarios with significantly fewer test cases than expected
4. Check for missing: error handling, edge cases, boundary conditions

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

### Vague Expected Results
| File | TC | Step | Issue | Suggested Fix |
|------|-----|------|-------|---------------|

### Missing Preconditions
| File | TC | Issue |
|------|-----|-------|

## Completeness Check

| Scenario | Expected TCs | Actual TCs | Status | Notes |
|----------|--------------|------------|--------|-------|

## Recommendations

### Must Fix Before TestLink Sync
1. [Critical issue]

### Should Fix
1. [Important improvement]

## Overall Assessment

**Status:** READY FOR TESTLINK / NEEDS REVISION
```

---

## Action Verbs (Good)
- Navigate, Click, Select, Enter, Type
- Verify, Observe, Confirm, Check
- Upload, Download, Submit, Save

## Vague Terms to Flag
- "data" → Specify the actual data
- "some" → Specify the quantity
- "correct" → Describe the correct state
- "works" → Describe the expected behavior
- "properly" → Define what properly means

## Expected Result Patterns (Good)
- "Message displays: '[exact text]'"
- "Page redirects to [specific page]"
- "Field shows value: [specific value]"
- "Button becomes [enabled/disabled]"
- "List contains [N] items"
