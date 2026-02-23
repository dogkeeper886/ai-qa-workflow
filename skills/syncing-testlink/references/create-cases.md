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

### Comparison Fields

Compare these fields between local and TestLink:
- `name` - Test case name
- `summary` - Objective/summary text
- `preconditions` - Setup requirements
- `steps.actions` - Step actions (each step)
- `steps.expected_results` - Expected results (each step)

---

## Common Issues

- "Missing required fields" → Ensure testprojectid, testsuiteid, name, authorlogin provided
- "Invalid test suite ID" → Verify suite exists in the project
- Missing preconditions after creation → Use update_test_case immediately
- "Test case already exists" → Use update_test_case instead or change name
- "Invalid XML-RPC message" (on update) → Use external ID format instead of numeric ID

---

## Batch Test Case Creation Guidelines

### Problem: Context Compaction and Drift

When creating many test cases (10+) in a single session, quality issues occur:

| Issue | Cause | Example |
|-------|-------|---------|
| **Terminology Drift** | Earlier context lost during compaction | "Group A/B" vs "Original-Group/New-Group" inconsistency |
| **Hallucination** | AI fills gaps with plausible but wrong details | Added zones/names that didn't exist in source |
| **Precondition/Step Mismatch** | Copied patterns from different test cases | TC-02 had unrelated language from another scenario |
| **Quality Degradation** | Later test cases worse than earlier ones | Last test suite created had the most issues |

### Prevention: Batch Size Limits

| Batch Size | Risk Level | Recommendation |
|------------|------------|----------------|
| 1-5 test cases | Low | Direct creation OK |
| 6-10 test cases | Medium | Create in 2 batches, verify after each |
| 11-20 test cases | High | Use JSON payload files + script execution |
| 20+ test cases | Very High | **Mandatory**: Use scripted approach with verification |

### Recommended Workflow for Large Test Case Sets

```
┌─────────────────────────────────────────────────────────────────┐
│  PHASE 1: Generate (per test suite, not all at once)           │
├─────────────────────────────────────────────────────────────────┤
│  1. Generate TS-01 test cases (max 5-6 TCs)                     │
│  2. Save to JSON payload files in test_cases/sync/payloads/    │
│  3. Review JSON against source MD before proceeding            │
│  4. Repeat for TS-02, TS-03, etc. (new session if needed)      │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│  PHASE 2: Verify Payloads                                       │
├─────────────────────────────────────────────────────────────────┤
│  For each payload file, verify:                                 │
│  □ Name matches source MD title                                 │
│  □ Preconditions align with test steps                          │
│  □ Terminology is consistent within the test case               │
│  □ No copied content from unrelated test cases                  │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│  PHASE 3: Execute                                               │
├─────────────────────────────────────────────────────────────────┤
│  Option A: Use a project sync script to generate payloads       │
│  Option B: Direct MCP calls from verified JSON files            │
│  Option C: Ask Claude to execute one suite at a time            │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│  PHASE 4: Post-Creation Verification                            │
├─────────────────────────────────────────────────────────────────┤
│  1. Read test cases back from TestLink                          │
│  2. Compare against source MD (use comparison table)            │
│  3. Check: Names, Summaries, Preconditions, Steps alignment     │
│  4. Fix any discrepancies before moving to next suite           │
└─────────────────────────────────────────────────────────────────┘
```

### Verification Checklist (Per Test Case)

Before pushing to TestLink, verify each test case:

| Check | What to Verify |
|-------|----------------|
| **Name** | Matches source MD section title |
| **Summary** | Matches source MD objective |
| **Preconditions** | All items exist in source MD; terminology matches steps |
| **Steps** | Actions use same terminology as preconditions |
| **No Cross-Contamination** | No content copied from other test cases |

### Red Flags During Test Case Generation

Stop and review if you notice:

- Using terminology not in the source document
- Copying preconditions from a different test case
- Test steps that don't match the precondition setup
- Generating content without re-reading the source
- Session has been running for 30+ minutes with many tool calls

### Recovery: When Issues Are Found Post-Creation

1. **Create comparison table**: Source MD vs TestLink for affected test suite
2. **Identify specific discrepancies**: Name, preconditions, steps
3. **Fix TestLink first**: Using MCP update tool
4. **Update source MD**: To match corrected TestLink (if source was also wrong)
5. **Document lesson**: Add specific issue to project guidelines

---

## Test Case Correction Workflow

When test execution reveals discrepancies between documented test cases and actual system behavior:

1. **Update source markdown FIRST** (single source of truth) — correct steps/expected results, add Notes section documenting actual behavior
2. **Update Confluence page** — find page ID in `confluence/confluence_links.md`, update content, add version comment
3. **Update TestLink test case** — read current case to verify structure, update steps, maintain HTML formatting

**Key Points:**
- Source markdown is always the single source of truth
- Document findings in Notes section for future reference
- Use version comments to track why changes were made
