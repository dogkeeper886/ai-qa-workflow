# Jira Trace - Documentation Download

```
Download documentation files for a traced Jira ticket project.

Jira Issue Key: {{input}}

## PURPOSE

Download and save documentation from Jira tickets and Confluence pages:
1. Main ticket file with full details
2. Related ticket files
3. Confluence documentation files (faithful download, not summarized)

---

## FILE 1: MAIN TICKET FILE

**Filename:** `00_Main_Task_[TICKET].md`

### Content Structure

```markdown
# [TICKET]: [Summary]

## Ticket Information

| Field | Value |
|-------|-------|
| Type | [Epic/Story/Bug/Task] |
| Status | [Status] |
| Priority | [Priority] |
| Assignee | [Name] |
| Reporter | [Name] |
| Created | [Date] |
| Updated | [Date] |

## Description

[Full description from ticket]

## Changelog Summary

| Date | Author | Change |
|------|--------|--------|
| [Date] | [Name] | [Key change description] |

## Comments

### Comment by [Author] - [Date]
[Comment content]

---

### Comment by [Author] - [Date]
[Comment content]

## Related Tickets

- Parent: [TICKET] - [Summary]
- Children: [TICKET], [TICKET]
- Linked: [TICKET] (blocks), [TICKET] (relates to)

## Confluence Documents

- [Page Title](confluence/[filename].md)
```

---

## FILE 2: RELATED TICKET FILES

**Filename:** `01_[DESCRIPTION]_[TICKET].md`

Create one file for each:
- Parent ticket (if exists)
- Child tickets/stories
- Linked tickets (blocks, relates to, duplicates)

### Content Structure

```markdown
# [TICKET]: [Summary]

## Ticket Information

| Field | Value |
|-------|-------|
| Type | [Type] |
| Status | [Status] |
| Relationship | [Parent of/Child of/Blocks/Relates to] [MAIN_TICKET] |

## Description

[Full description]

## Comments

[All comments with author and date]
```

---

## FILE 3: CONFLUENCE FILES

**Filename:** `confluence/[SANITIZED_TITLE].md`

### Content Structure

```markdown
# [Page Title]

## Page Metadata

| Field | Value |
|-------|-------|
| Page ID | [ID] |
| Space | [Space Key] |
| Version | [Version Number] |
| URL | [Full URL] |
| Last Updated | [Date] |

## Content

[Full page content converted to markdown]

## Attachments

| Filename | Size | Type |
|----------|------|------|
| [name] | [size] | [type] |
```

---

## TIPS

- **Download faithfully** — Save full Confluence page content as-is, do not summarize or rewrite
- **Keep comments** — They contain crucial context and decisions
- **Follow naming conventions** — See `/jr-trace-structure` for details
- **Preserve all content** — Include every section, table, and detail from the source

## NEXT STEP

After downloading files, run `/jr-trace-verify` to validate downloads and generate summaries.
```
