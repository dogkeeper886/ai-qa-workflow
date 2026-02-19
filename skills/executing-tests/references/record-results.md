# Recording Test Results Reference

## Creating Test Executions

### Required Fields

```json
{
  "test_case_id": "string (NUMERIC ID like '5', NOT 'PROJ-1')",
  "plan_id": "string (test plan ID)",
  "build_id": "string (build ID)",
  "status": "string (p=pass, f=fail, b=block)",
  "notes": "string (execution notes, optional)",
  "platform_id": "string (platform ID, optional)"
}
```

### Status Values
- **p** = Pass (test execution successful)
- **f** = Fail (test execution failed)
- **b** = Block (test execution blocked)

### MCP Tool: `testlink-mcp:create_test_execution`

**CRITICAL:** Must use NUMERIC test case ID (e.g., "5"), NOT external format (e.g., "PROJ-1")

---

## Convert External ID to Numeric ID

If you have external ID (e.g., "PROJ-1"), convert:
1. Use `testlink-mcp:read_test_case` with external ID
2. Extract the numeric `tcase_id` from response
3. Use that numeric ID for create_test_execution

---

## Pre-Execution Checklist

Before recording results:
1. Verify test plan exists using `testlink-mcp:list_test_plans`
2. Verify build exists and is active using `testlink-mcp:list_builds`
3. Verify test case is assigned to the test plan
4. Convert external IDs to numeric IDs if needed

---

## Execution Notes Format

Write clear, descriptive notes for each result:

**PASS notes:**
```
All steps completed successfully. [Feature] behaves as expected.
Step 3 observation: [specific detail].
```

**FAIL notes:**
```
Failed at Step [N]: Expected "[expected result]" but got "[actual result]".
Screenshot captured for evidence.
[Additional context about the failure]
```

**BLOCKED notes:**
```
Blocked by: [reason].
Could not execute because [dependency/prerequisite issue].
```

---

## Summary Tracking

After all executions, compile final summary:

```
Total Test Cases in Plan: X
├── Executed: X
│   ├── Passed: X
│   ├── Failed: X
│   └── Blocked: X
└── Not Executed: X

Pass Rate: XX%
```

---

## Common Errors

| Error | Cause | Solution |
|-------|-------|---------|
| "Test Case ID does not exist" | Using external ID format | Convert to numeric ID |
| "Test case not assigned to test plan" | Case not in plan | Use add_test_case_to_test_plan first |
| "Build not found or inactive" | Build ID doesn't exist | Verify build with list_builds |
| "Missing required fields" | Missing test_case_id, plan_id, build_id, or status | Ensure all required fields provided |
