---
name: receiving-tickets
description: |
  Fetches a Jira ticket with all linked tickets and Confluence pages, then
  creates a standardized project workspace folder with documentation files.
  Use when a QA engineer receives a new Jira ticket to work on, wants to
  start a project, trace a ticket, set up a project folder, or begin a
  QA project from a Jira issue.
disable-model-invocation: true
tools:
  - mcp-atlassian:jira_get_issue
  - mcp-atlassian:jira_search
  - mcp-atlassian:confluence_get_page
---

# receiving-tickets

Fetches a Jira ticket with all linked tickets and Confluence pages, then creates a standardized project workspace.

## Progress Checklist

Copy and track your progress:

```
- [ ] Step 1: Collect ticket data (main + related + Confluence)
- [ ] Step 2: Create folder structure
- [ ] Step 3: Generate documentation files
- [ ] Validate: Confirm created structure and file count
- [ ] (Optional) Step 4: Initialize test scaffolding
```

## Steps

### Step 1: Collect Ticket Data

Fetch the main Jira ticket with all fields, comments, and remote links. Then find and fetch:
- Parent ticket (if exists)
- Child tickets via JQL `parent = [TICKET]`
- Linked issues from `issuelinks` field
- Confluence pages linked in description, comments, changelog

See `references/data-collection.md` for exact API parameters and Confluence URL patterns.

**MCP tools:** `mcp-atlassian:jira_get_issue`, `mcp-atlassian:jira_search`, `mcp-atlassian:confluence_get_page`

### Step 2: Create Folder Structure

Create `active/[TICKET]_[Short_Description]/` with:
- `confluence/` subfolder only if Confluence links were found
- No empty folders

See `references/folder-structure.md` for naming conventions and rules.

### Step 3: Generate Documentation Files

Create these 5-6 files from collected data:
1. `00_Main_Task_[TICKET].md` — main ticket details + comments
2. `01_[Description]_[TICKET].md` — one file per related ticket
3. `confluence/[Title].md` — one file per Confluence page
4. `confluence/confluence_links.md` — index of all Confluence links
5. `README.md` — project overview with key insights
6. `Ticket_Relationship_Diagram.md` — visual ticket hierarchy

See `references/doc-templates.md` for full file templates.

### Validate

List the created folder structure. Report:
- Total files created
- Whether Confluence links were found
- Suggested next step: `/planning-tests`

### Step 4 (Optional): Initialize Test Scaffolding

If user requests project initialization, scaffold `test_plan/` and `test_cases/` folders with README templates.

See `references/project-init.md` for template content.

## Expected Input

Jira issue key: `PROJ-12345`

## Next Step

After receiving tickets, run `/planning-tests` to detect the ticket type and start test planning.
