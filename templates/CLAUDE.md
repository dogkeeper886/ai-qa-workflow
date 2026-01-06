## AI QA Workflow

This section provides AI coding agents with QA workflow guidance powered by MCP integrations.

### Quick Start

Use these slash commands for end-to-end test automation:

| Phase | Command | Purpose |
|-------|---------|---------|
| Discover | `/jira-trace TICKET-ID` | Gather requirements from Jira/Confluence |
| Plan | `/test-planning-checklist` | Create TEST_PLAN.md |
| Design | `/test-case-design-checklist` | Create TEST_CASES.md |
| Manage | `/create-test-case` | Import to TestLink |
| Execute | `/create-test-execution` | Record test results |

### MCP Dependencies

These MCP servers must be configured:
- **mcp-atlassian** - Jira/Confluence access
- **testlink-mcp** - TestLink API access
- **playwright-mcp** - Browser automation (optional)

### Test Lifecycle Workflow

**Phase 1: Discover Requirements**
```
/jira-trace PROJ-123
```
Creates folder with requirements, related tickets, and Confluence docs.

**Phase 2: Create Test Plan**
```
/test-planning-checklist
```
Generates TEST_PLAN.md with test strategy, scope, and entry/exit criteria.

**Phase 3: Design Test Cases**
```
/test-case-design-checklist
```
Transforms TEST_PLAN.md into detailed TEST_CASES.md with unique IDs.

**Phase 4: Manage in TestLink**
```
/list-projects          # Find project ID
/list-test-suites       # Find or create suite
/create-test-case       # Import each test case
/create-test-plan       # Create test plan
/add-test-case-to-test-plan  # Assign cases to plan
```

**Phase 5: Automate Tests**
Create YAML test files using [test-framework-template](https://github.com/dogkeeper886/test-framework-template):
```yaml
id: TC-AUTH-001
name: User Login Test
suite: integration
steps:
  - name: Login request
    command: curl -X POST /api/login
criteria: |
  Verify login returns 200 and valid token
```

**Phase 6: Execute and Report**
```bash
npm test                    # Run tests
/create-test-execution      # Record results in TestLink
```

### Available Commands

**Jira/Confluence:**
- `/jira-trace` - Trace ticket with related items
- `/jira-to-confluence` - Convert ticket to Confluence page
- `/jira-to-testlink` - Convert ticket to TestLink case

**Test Planning:**
- `/test-planning-checklist` - Create test plan
- `/test-case-design-checklist` - Design test cases
- `/identify-test-type` - Categorize test type

**TestLink:**
- `/list-projects`, `/list-test-suites`, `/list-test-cases`
- `/create-test-suite`, `/create-test-case`, `/create-test-plan`
- `/get-test-case`, `/update-test-case`, `/delete-test-case`
- `/add-test-case-to-test-plan`, `/create-build`
- `/create-test-execution`, `/read-test-execution`

**Confluence:**
- `/create-confluence-page`, `/read-confluence-page`
- `/update-confluence-page`, `/delete-confluence-page`

**Utilities:**
- `/rewrite-text` - Improve text clarity
- `/analyze-log` - Analyze log files
