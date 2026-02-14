# Jira Ticket Trace and Folder Organization with Confluence Integration

```
Trace Jira tickets and organize them into a clear folder structure, including comments and linked Confluence documents:

Jira Issue Key: {{input}}

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
- Save with sanitized page title as filename

### 4. Create Folder Structure
- Create main folder: `[TICKET]_[SHORT_DESCRIPTION]/`
- Use flat file structure with numbered prefixes (00_, 01_)
- Create `confluence/` subfolder if Confluence links found
- DO NOT create empty subfolders

### 5. Generate Documentation Files
Create the following files in order:

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
- Ticket relationships and progress
- Resources and links
- QA/Testing checklist

**f. Relationship Diagram:** `Ticket_Relationship_Diagram.md`
- Visual tree of ticket relationships
- Timeline of key events
- Team assignments
- Progress tracking
- Confluence document references

## Folder Structure Example:

```
PROJ-12345_Notification_Center/
├── 00_Main_Task_PROJ-12345.md              # Main epic with full details
├── 01_Feature_Request_FR-1234.md          # Parent feature request
├── 01_HLD_Story_PROJ-12346.md             # Child story (HLD)
├── 01_UX_Design_PROJ-12347.md              # Child story (UX)
├── 01_UI_Implementation_PROJ-12348.md     # Child story (UI - Bulk)
├── 01_UI_Sleep_Notifications_PROJ-12349.md # Child story (UI - Sleep)
├── 01_API_Sleep_Notifications_PROJ-12350.md # Child story (API)
├── 01_Feature_Flag_PROJ-12351.md          # Child story (Feature Flag)
├── confluence/                            # Confluence documents
│   ├── HLD_R1_Notification_Center_Enhancement.md
│   └── confluence_links.md               # Index of all Confluence links
├── README.md                              # Project overview & insights
└── Ticket_Relationship_Diagram.md        # Complete trace & timeline
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
- `/pages/123456789/` → Page ID: `123456789`
- `pageId=123456789` → Page ID: `123456789`

## Naming Rules:

### File Names
- **00_** prefix for main ticket file
- **01_** prefix for related/child tickets at same level
- **02_** prefix if there's a second level of nesting (rare)
- Format: `[PREFIX]_[SHORT_DESCRIPTION]_[TICKET].md`
- Use underscores instead of spaces
- Keep descriptions concise (2-4 words max)

### Folder Names
- Format: `[TICKET]_[SHORT_DESCRIPTION]/`
- Use underscores instead of spaces
- Example: `PROJ-12345_Notification_Center/`

### Confluence Files
- Sanitize page titles (remove special chars: `:`, `/`, `\`, `?`, `*`, `<`, `>`, `|`)
- Limit length to ~50 characters
- Example: `HLD_R1_Notification_Center_Enhancement.md`

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
- Ticket relationships and progress
- Team assignments
- Resources and external links
- Testing checklist (for QA)

### Relationship Diagram Should Include:
- Visual tree of ticket hierarchy
- Timeline of key events
- Team member assignments
- Progress indicators (resolved/open)
- Confluence document references
- Blockers and risks

## Example Workflow:

1. Run command: `/jira-trace PROJ-12345`
2. Fetch PROJ-12345 with all fields, comments, remotes
3. Find Confluence link in description: `pages/123456789/`
4. Fetch parent FR-1234 and all 6 child stories
5. Retrieve Confluence page 123456789
6. Create folder structure
7. Generate all markdown files
8. Create README with insights
9. Create relationship diagram
10. Review for empty folders (remove if any)

## Tips:

- **Always check changelogs** for RemoteWorkItemLink entries
- **Retrieve comments for ALL tickets** - they contain crucial info
- **Extract insights from Confluence** - don't just save raw content
- **Keep folder structure flat** - avoid unnecessary nesting
- **Remove empty folders** - only create subfolders when needed
- **Include progress indicators** - show what's resolved vs. open
- **Add QA checklists** - help testers understand what to verify
```
