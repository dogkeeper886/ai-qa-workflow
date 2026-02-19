# Reading Test Results Reference

## Getting Test Cases for a Plan

### Step 1: Validate Test Plan

Use `testlink-mcp:list_test_plans` to verify the test plan exists and is active.

### Step 2: Get All Test Cases

```json
{
  "plan_id": "string (numeric test plan ID)"
}
```

**MCP Tool:** `testlink-mcp:get_test_cases_for_test_plan`

### Execution Status Values in Response
- `n` = Not executed
- `p` = Passed
- `f` = Failed
- `b` = Blocked

---

## Reading Individual Execution Details

### API Limitation

**TestLink API requires test case ID for reliable execution reading.**

The `read_test_execution` tool needs a test case ID for best results.

### Recommended Approach: Complete Overview

```
1. get_test_cases_for_test_plan(plan_id) → Get all test cases
2. For each test case:
   - read_test_execution(plan_id, test_case_id)
3. Compile all execution results into summary
```

**MCP Tool:** `testlink-mcp:read_test_execution`

---

## Execution Summary Format

Present results in this format before starting executions:

```
Test Plan Execution Summary: [Plan Name]

Total Test Cases: N
├── Not Executed: N
├── Passed: N
├── Failed: N
└── Blocked: N

Execution Progress: XX% (N/N completed)

Test Cases:
1. PROJ-1 - [Test Case Name] (Status: Not Executed)
2. PROJ-2 - [Test Case Name] (Status: Not Executed)
...
```

---

## Data Interpretation

### Test Case Object Structure

```json
{
  "13": [{
    "tcase_name": "Test Case Name",
    "tcase_id": "13",
    "tcversion_id": "14",
    "version": "1",
    "full_external_id": "PROJ-1",
    "exec_status": "n",
    "execution_type": "1",
    "execution_order": "1"
  }]
}
```

### Execution Type Values
- **1** = Manual execution
- **2** = Automated execution

---

## Common Errors

| Error | Cause | Solution |
|-------|-------|---------|
| "Expected one of this fields: testcaseid" | API requires test case ID | Use get_test_cases_for_test_plan first |
| "Test plan not found" | Invalid test plan ID | Verify with list_test_plans |
| "No executions found" | No test executions exist | Check if test cases are assigned and executed |
