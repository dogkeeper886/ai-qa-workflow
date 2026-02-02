# Jira Ticket Trace and Project Structure Creation

```
Trace Jira tickets and create a standardized project folder structure with Confluence integration.

Jira Issue Key: {{input}}

## Recommended Project Structure

Create this standardized structure for all new test projects:

```
[JIRA-ID]_[Short_Description]/
├── README.md                 # Project overview and navigation
├── confluence/               # HLD and design documentation
│   ├── [Page_Title].md       # Confluence page content
│   └── confluence_links.md   # Index of all Confluence links
├── test_plan/                # Test planning documents (create later)
│   ├── README.md             # Test plan index
│   └── sections/             # Modular sections
├── test_cases/               # Test cases (create later)
│   └── README.md             # Test case index
├── 00_Main_Task_[TICKET].md  # Main ticket details
├── 01_[Description]_[TICKET].md  # Related tickets
└── Ticket_Relationship_Diagram.md
```

## Steps:

### 1. Fetch Main Ticket
- Use `jira_get_issue` with `fields='*all'` and `expand='renderedFields,changelog,comments,remotelinks'`
- Set `comment_limit=100` to ensure ALL comments are retrieved
- Comments often contain critical information not in descriptions

### 2. Find Related Tickets
- Identify parent ticket (if this is a child/subtask)
- Find all child tickets using `jira_search` with `jql="parent = [TICKET]"`
- Check for linked issues in the issue links
- Get full details for each related ticket with comments

### 3. Detect and Fetch Confluence Links
Look for Confluence URLs in multiple places:
- **Ticket descriptions** - URLs in description field
- **All comments** - URLs in comment bodies
- **Remote issue links** - Check changelog for `RemoteWorkItemLink` entries
- **Rendered fields** - Sometimes links are in custom fields

**Confluence URL Patterns:**
- `https://yourcompany.atlassian.net/wiki/spaces/SPACE/pages/[PAGE_ID]/Page+Title`
- `https://yourcompany.atlassian.net/wiki/pages/viewpage.action?pageId=[PAGE_ID]`

**Extract page IDs** (numeric ID in URL) and fetch content:
- Use `confluence_get_page(page_id='...', convert_to_markdown=true, include_metadata=true)`
- Save to `confluence/` folder with sanitized page title

### 4. Create Folder Structure

**Required folders:**
- `confluence/` - For HLD and design docs (only if Confluence links found)

**Optional folders (create only when needed):**
- `test_plan/` and `test_plan/sections/` - Create during test planning phase
- `test_cases/` - Create during test case creation phase
- `reference/` - Only if external reference docs needed
- `archive/` - Only if archiving old versions

**DO NOT create empty folders!**

### 5. Generate Documentation Files

**a. Main Ticket File:** `00_Main_Task_[TICKET].md`
- Full ticket details (summary, description, status, assignee, dates)
- Complete changelog summary
- All comments
- Links to related tickets
- Links to Confluence documents

**b. Related Ticket Files:** `01_[DESCRIPTION]_[TICKET].md`
- Parent ticket (if exists)
- Child tickets/stories
- Linked tickets
- Each with full details and comments

**c. Confluence Files:** `confluence/[PAGE_TITLE].md`
- Full page content in markdown
- Metadata (page ID, space, version, URL)
- List of attachments

**d. Confluence Index:** `confluence/confluence_links.md`
- List all Confluence pages found
- Show where each link was discovered
- Provide context for each document

**e. README:** `README.md`
- Problem summary (what issue is being solved)
- Solution overview
- Key insights from tickets AND Confluence docs
- Project structure overview
- Links to test_plan/ and test_cases/ (placeholder until created)
- QA/Testing next steps

**f. Relationship Diagram:** `Ticket_Relationship_Diagram.md`
- Visual tree of ticket relationships
- Timeline of key events
- Team assignments
- Progress tracking
- Confluence document references

## Folder Structure Example:

```
PROJ-12345_Feature_Integration/
├── README.md                              # Project overview
├── confluence/                            # HLD and design docs
│   ├── HLD_Feature_Name.md
│   └── confluence_links.md
├── 00_Main_Task_PROJ-12345.md             # Main epic
├── 01_Feature_Request_FR-1234.md          # Related FR
├── 01_Related_Epic_EP-5678.md             # Related epic
└── Ticket_Relationship_Diagram.md         # Ticket trace
```

**Later, during test planning:**
```
PROJ-12345_Feature_Integration/
├── ...
├── test_plan/
│   ├── README.md
│   └── sections/
│       ├── 01_Project_Business_Context.md
│       ├── 02_Feature_Definition.md
│       ├── 03_Scope_Boundaries.md
│       ├── 04_Test_Strategy.md
│       ├── 05_References_Resources.md
│       └── 06_Revision_History.md
└── test_cases/
    ├── README.md
    ├── TS-01_Configuration_Basic_Functionality.md
    ├── TS-02_Backward_Compatibility.md
    └── ...
```

## Important: Comment Retrieval

**ALWAYS retrieve ALL comments from EVERY ticket!**

Comments contain critical information:
- Customer problem discussions
- Reproduction steps and technical details
- Problem-solving conversations
- Workarounds and behaviors
- Team collaboration and decisions

Use: `jira_get_issue(issue_key='...', comment_limit=100, expand='comments')`

## Important: Confluence Link Detection

**Check these sources for Confluence URLs:**

1. **Ticket Description Field**
   - Direct URLs in description text
   - Smart links in Jira format

2. **All Comments**
   - URLs in comment bodies
   - Links shared during discussions

3. **Changelog - RemoteWorkItemLink**
   - Look for entries like: `"field": "RemoteWorkItemLink"`
   - These indicate Confluence pages linked to the ticket
   - Check the `created` date to see when linked

4. **Custom Fields**
   - Some tickets have custom fields with documentation links

**Always extract the numeric page ID** from URLs:
- `/pages/233078810/` → Page ID: `233078810`
- `pageId=233078810` → Page ID: `233078810`

## Naming Rules:

### File Names
- **00_** prefix for main ticket file
- **01_** prefix for related/child tickets at same level
- Format: `[PREFIX]_[SHORT_DESCRIPTION]_[TICKET].md`
- Use underscores instead of spaces
- Keep descriptions concise (2-4 words max)

### Folder Names
- Format: `[TICKET]_[SHORT_DESCRIPTION]/`
- Use underscores instead of spaces
- Example: `PROJ-12345_Feature_Integration/`

### Confluence Files
- Save to `confluence/` folder
- Sanitize page titles (remove special chars: `:`, `/`, `\`, `?`, `*`, `<`, `>`, `|`)
- Limit length to ~50 characters
- Example: `confluence/HLD_R1_Add_AP_Group_name_to_NAS_ID.md`

### Test Case Files (for later use)
- Test Scenarios: `TS-XX_[Scenario_Name].md`
- Test Cases within: `TC-01`, `TC-02`, etc. (per scenario)
- Example: `test_cases/TS-01_Configuration_Basic_Functionality.md`

## Content Guidelines:

### Ticket Files Should Include:
- Header with ticket metadata (type, status, priority, assignee, dates)
- Full description
- Current status or latest update
- Changelog summary (key changes with dates)
- All comments (if any)
- Related tickets section
- Links to Confluence docs (if any)

### README Should Include:
- Problem summary (2-3 paragraphs)
- Solution overview (key features)
- Insights from Confluence docs
- Project structure overview with folder descriptions
- Next steps (test planning, test case creation)
- Team assignments
- Resources and external links

### Relationship Diagram Should Include:
- Visual tree of ticket hierarchy
- Timeline of key events
- Team member assignments
- Progress indicators (resolved/open)
- Confluence document references

## Example Workflow:

1. Run command: `/jr-trace PROJ-12345`
2. Fetch PROJ-12345 with all fields, comments, remotes
3. Find Confluence link in description: `pages/123456789/`
4. Find parent/child tickets
5. Fetch Confluence page 123456789
6. Create folder: `active/PROJ-12345_Feature_Integration/`
7. Create `confluence/` subfolder with HLD document
8. Generate ticket markdown files (00_, 01_)
9. Create README with project overview
10. Create relationship diagram
11. **Do NOT create empty test_plan/ or test_cases/ folders yet**

## Tips:

- **Always check changelogs** for RemoteWorkItemLink entries
- **Retrieve comments for ALL tickets** - they contain crucial info
- **Extract insights from Confluence** - don't just save raw content
- **Keep folder structure minimal** - only create folders when populated
- **Remove empty folders** - if created by mistake
- **Include progress indicators** - show what's resolved vs. open
- **Add next steps** - guide user on test planning phase
- **Follow naming conventions** - consistent prefixes and underscores
```
