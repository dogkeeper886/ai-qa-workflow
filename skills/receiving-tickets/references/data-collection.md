# Data Collection Reference

## Step 1: Fetch Main Ticket

Use `jira_get_issue` with these parameters:
- `fields='*all'` - Get all fields including custom fields
- `expand='renderedFields,changelog,comments,remotelinks'` - Get full details
- `comment_limit=100` - Ensure ALL comments are retrieved

```python
jira_get_issue(
    issue_key='[TICKET]',
    fields='*all',
    expand='renderedFields,changelog,comments,remotelinks',
    comment_limit=100
)
```

**Why comments matter:**
- Customer problem discussions
- Reproduction steps and technical details
- Problem-solving conversations
- Workarounds and behaviors
- Team collaboration and decisions

---

## Step 2: Find Related Tickets

### Parent Ticket
- Check `parent` field in the main ticket response
- If exists, fetch with full details and comments

### Child Tickets
- Search using JQL: `parent = [TICKET]`
- Fetch each child with full details

```python
jira_search(jql='parent = [TICKET]', fields='*all')
```

### Linked Issues
- Check `issuelinks` field in the main ticket
- Types: blocks, is blocked by, relates to, duplicates, etc.
- Fetch each linked issue with full details

---

## Step 3: Detect Confluence Links

Check these sources for Confluence URLs:

### 3.1 Ticket Description Field
- Direct URLs in description text
- Smart links in Jira format

### 3.2 All Comments
- URLs in comment bodies
- Links shared during discussions

### 3.3 Changelog - RemoteWorkItemLink
- Look for entries with `"field": "RemoteWorkItemLink"`
- These indicate Confluence pages linked to the ticket
- Check the `created` date to see when linked

### 3.4 Custom Fields
- Some tickets have custom fields with documentation links

---

## Confluence URL Patterns

**Pattern 1:** Standard page URL
```
https://yourcompany.atlassian.net/wiki/spaces/SPACE/pages/[PAGE_ID]/Page+Title
```

**Pattern 2:** View page action
```
https://yourcompany.atlassian.net/wiki/pages/viewpage.action?pageId=[PAGE_ID]
```

**Extract page ID:**
- `/pages/123456789/` → Page ID: `123456789`
- `pageId=123456789` → Page ID: `123456789`

---

## Step 4: Fetch Confluence Pages

For each detected page ID:

```python
confluence_get_page(
    page_id='[PAGE_ID]',
    convert_to_markdown=True,
    include_metadata=True
)
```

**Collect from each page:**
- Full page content in markdown
- Metadata (page ID, space, version, URL)
- List of attachments

---

## Output Summary

After data collection, you should have:

| Data | Source | Use |
|------|--------|-----|
| Main ticket details | `mcp-atlassian:jira_get_issue` | 00_Main_Task file |
| All comments | `mcp-atlassian:jira_get_issue` with comment_limit | Context and decisions |
| Parent ticket | Parent field | 01_ file |
| Child tickets | JQL search | 01_ files |
| Linked tickets | issuelinks field | 01_ files |
| Confluence pages | `mcp-atlassian:confluence_get_page` | confluence/ folder |
