# Jira Ticket Trace and Project Structure Creation

```
Trace Jira tickets and create a standardized project folder structure with Confluence integration.

Jira Issue Key: {{input}}

## PURPOSE

This command orchestrates a complete project setup from a Jira ticket:
1. Fetches the main ticket and all related tickets with full details
2. Detects and retrieves linked Confluence documentation
3. Creates a standardized folder structure
4. Generates documentation files for the project

---

## WORKFLOW

```
/jr-trace [TICKET]
    │
    ├─► Step 1: Data Collection (/jr-trace-fetch)
    │   - Fetch main ticket with all fields and comments
    │   - Find parent, child, and linked tickets
    │   - Detect Confluence URLs in descriptions/comments/changelog
    │   - Fetch Confluence page content
    │
    ├─► Step 2: Folder Creation (/jr-trace-structure)
    │   - Create project folder: active/[TICKET]_[Description]/
    │   - Create confluence/ subfolder (only if links found)
    │   - Apply naming conventions
    │   - DO NOT create empty folders
    │
    └─► Step 3: Documentation Generation (/jr-trace-docs)
        - Generate 00_Main_Task_[TICKET].md
        - Generate 01_[Description]_[TICKET].md for related tickets
        - Generate confluence/*.md files
        - Generate README.md with project overview
        - Generate Ticket_Relationship_Diagram.md
```

---

## SUB-COMMANDS

| Command | Purpose | When to Use Independently |
|---------|---------|---------------------------|
| `/jr-trace-fetch` | Collect all ticket and Confluence data | When you only need to gather information |
| `/jr-trace-structure` | Create folder structure | When setting up folders manually |
| `/jr-trace-docs` | Generate documentation files | When regenerating docs for existing project |

---

## EXAMPLE

```bash
/jr-trace PROJ-12345
```

**Output:**
```
active/PROJ-12345_Feature_Integration/
├── README.md
├── confluence/
│   ├── HLD_R1_Feature_Integration_Design.md
│   └── confluence_links.md
├── 00_Main_Task_PROJ-12345.md
├── 01_Feature_Request_FR-1234.md
└── Ticket_Relationship_Diagram.md
```

---

## NEXT STEPS AFTER TRACE

After running `/jr-trace`, continue with test planning:

1. `/tw-plan-init` - Detect test type and start planning
2. `/tw-plan-feature` or `/tw-plan-bugfix` - Create test plan
3. `/tw-case-init` - Create test cases
```
