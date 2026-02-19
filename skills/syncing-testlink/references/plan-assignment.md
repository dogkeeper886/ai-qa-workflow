# Test Plan Case Assignment Reference

## Adding Test Cases to Test Plan

### Required Fields

```json
{
  "testcaseid": "string (external format 'PROJ-1' or numeric '5')",
  "testplanid": "string (numeric test plan ID)",
  "testprojectid": "string (numeric project ID)",
  "urgency": "number (1=low, 2=medium, 3=high, defaults to 2)",
  "overwrite": "boolean (replace existing assignment, defaults to false)"
}
```

### MCP Tool: `testlink-mcp:add_test_case_to_test_plan`

### Urgency Level Mapping
- **1** = Low priority
- **2** = Medium priority (default)
- **3** = High priority

---

## Bulk Assignment Process

After creating all test cases in all suites:

1. **Get all test case IDs** from the created/existing suites
2. **For each test case**, call `testlink-mcp:add_test_case_to_test_plan`
3. **Handle "already assigned"** gracefully — use overwrite=true only if needed
4. **Confirm assignments** using `testlink-mcp:get_test_cases_for_test_plan`

---

## Getting Test Cases for a Plan

### Required Fields

```json
{
  "plan_id": "string (numeric test plan ID)"
}
```

### MCP Tool: `testlink-mcp:get_test_cases_for_test_plan`

### Execution Status Values in Response
- `n` = Not executed
- `p` = Passed
- `f` = Failed
- `b` = Blocked

### Sample Response Object

```json
{
  "13": [{
    "tcase_name": "Test Case Name",
    "tcase_id": "13",
    "tcversion_id": "14",
    "version": "1",
    "full_external_id": "PROJ-1",
    "exec_status": "n",
    "execution_type": "1"
  }]
}
```

---

## Common Errors

### Assignment Errors
- "Missing required fields" → Ensure testcaseid, testplanid, testprojectid provided
- "Test case not found" → Verify test case exists using read_test_case
- "Test plan not found" → Verify test plan exists using list_test_plans
- "Test case already assigned" → Use overwrite=true to replace existing assignment
- "Test case not in project" → Verify test case and test plan are in same project

### Verification Errors
- "No test cases assigned" → Check if test cases were assigned to correct plan
- Empty result → Verify plan_id is correct

---

## Best Practices

- ✅ Always validate test case and test plan exist before assignment
- ✅ Check for existing assignments to avoid duplicates
- ✅ Use appropriate urgency levels based on test importance
- ✅ Verify test case and test plan are in same project
- ✅ Provide clear feedback on assignment success/failure
