# Create and Update Test Cases Reference

## Creating New Test Cases

### Required Fields

```json
{
  "testprojectid": "string (project ID)",
  "testsuiteid": "string (test suite ID)",
  "name": "string (test case name)",
  "authorlogin": "string (defaults to 'admin')",
  "summary": "string (HTML formatted summary)",
  "preconditions": "string (HTML formatted preconditions)",
  "steps": "array (formatted step objects)",
  "importance": "integer (1=low, 2=medium, 3=high, defaults to 3)",
  "execution_type": "integer (1=manual, 2=automated, defaults to 1)",
  "status": "integer (1=draft, 7=final, defaults to 7)"
}
```

### Step Fields (Required for Each Step)

```json
{
  "step_number": "string ('1', '2', '3', ...)",
  "actions": "string (HTML formatted action)",
  "expected_results": "string (HTML formatted expected result)",
  "active": 1,
  "execution_type": 1
}
```

### Post-Creation: Fix Preconditions

**IMPORTANT:** After creation, retrieve the test case and verify preconditions were applied.
If preconditions are empty string, immediately call `testlink-mcp:update_test_case` to add them.

### MCP Tool: `testlink-mcp:create_test_case`

---

## Updating Existing Test Cases

### Required Fields for Update

```json
{
  "testcaseexternalid": "string (e.g., 'PROJ-1')",
  "name": "string (test case name)",
  "summary": "string (HTML formatted summary)",
  "preconditions": "string (HTML formatted preconditions)",
  "steps": "array (formatted step objects)"
}
```

**Note:** Use external ID format for updates (e.g., "PROJ-1" not numeric "13")

### MCP Tool: `testlink-mcp:update_test_case`

---

## Diff Logic: Skip / Update / Create

When syncing from local files to TestLink:

1. **Get existing test cases in suite** using `testlink-mcp:list_test_cases_in_suite`
2. **For each local test case:**
   - If name matches AND all fields match → **SKIP** (already matching)
   - If name matches BUT fields differ → **UPDATE** (only differing fields)
   - If name not found in TestLink → **CREATE** (new test case)
3. **Report counts:** created/updated/skipped per suite

---

## Common Issues

- "Missing required fields" → Ensure testprojectid, testsuiteid, name, authorlogin provided
- "Invalid test suite ID" → Verify suite exists in the project
- Missing preconditions after creation → Use update_test_case immediately
- "Test case already exists" → Use update_test_case instead or change name
- "Invalid XML-RPC message" (on update) → Use external ID format instead of numeric ID
