# Test Suite and Test Plan Reference

## Creating Test Suites

### Step 1: List TestLink Projects

Use `testlink-mcp:list_projects` to find the target project.

### Step 2: Create Parent Test Suite

```json
{
  "project_id": "string (required)",
  "suite_name": "string (required)",
  "details": "string (optional, HTML formatted)",
  "parent_id": "string (optional)"
}
```

**HTML Formatting for Details:**
- Wrap descriptions in `<p>` tags
- Use `<strong>` for important terms and features
- Use `<ul><li>` for lists of test types or features
- Apply HTML entities: `&gt;`, `&lt;`, `&quot;`, `&amp;`, `&apos;`

**Example:**
```
Suite Name: PROJ-12345 Feature Integration Test Suite
Details: <p>Comprehensive test suite for validating <strong>Feature Integration</strong> functionality.</p>
```

### Step 3: Create Child Suites Per Scenario

For each TS-XX scenario, create a child suite:

```
Parent Suite: PROJ-12345 Feature Integration Test Suite
  ├── TS-01 Configuration Basic (child suite)
  ├── TS-02 Integration Testing (child suite)
  ├── TS-03 Backward Compatibility (child suite)
  └── TS-04 Edge Cases (child suite)
```

**MCP Tool:** `testlink-mcp:create_test_suite`

---

## Creating Test Plans

### Important: Plain Text Only for Test Plans

**TestLink XML-RPC API Limitation:**
- Test plan `notes` field only supports plain text
- HTML formatting will be stored as encoded text and display as raw code
- Use plain text descriptions only in API calls

### Step 1: Create Test Plan

```
Required Fields:
- project_id: String (exact project name, not prefix)
- name: String (test plan name)
- notes: String (plain text description, optional)
- active: Integer (1 = active, 0 = inactive, defaults to 1)
- is_public: Integer (1 = public, 0 = private, defaults to 1)
```

**IMPORTANT:** Use EXACT project name (e.g., "User Session Management" not "USM")

### Step 2: Verify Creation

Confirm test plan was created successfully, note the plan ID.

### Test Plan Naming Conventions
- `AIGEN - [Feature] Test Plan` for AI-generated test plans
- `Manual - [Feature] Validation` for manual testing focus
- `Automated - [Feature] Regression` for automated testing

### MCP Tool: `testlink-mcp:create_test_plan`

---

## Common Errors

### Suite Creation
- "Missing required fields" → Ensure project_id and suite_name provided
- "Invalid project ID" → Verify project exists using list_projects

### Test Plan Creation
- "Test Project (name:XXX) does not exist" → Use exact project name from list_projects
- "Project ID must contain only digits" → Use project name, not numeric ID
