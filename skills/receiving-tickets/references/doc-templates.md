# Documentation Templates Reference

## File 1: Main Ticket File

**Filename:** `00_Main_Task_[TICKET].md`

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

## File 2: Related Ticket Files

**Filename:** `01_[DESCRIPTION]_[TICKET].md`

Create one file for each:
- Parent ticket (if exists)
- Child tickets/stories
- Linked tickets (blocks, relates to, duplicates)

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

## File 3: Confluence Files

**Filename:** `confluence/[SANITIZED_TITLE].md`

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

## File 4: Confluence Index

**Filename:** `confluence/confluence_links.md`

```markdown
# Confluence Links Index

## Documents Found

| Page Title | Page ID | Source | Context |
|------------|---------|--------|---------|
| [Title] | [ID] | Description | HLD for feature |
| [Title] | [ID] | Comment by [Name] | Design discussion |
| [Title] | [ID] | RemoteWorkItemLink | Linked on [Date] |

## Document Summaries

### [Page Title]
- **Purpose:** [Brief description of document purpose]
- **Key Content:** [What information it contains]
- **Relevance:** [How it relates to the ticket]
```

---

## File 5: README

**Filename:** `README.md`

```markdown
# [TICKET]: [Short Description]

## Problem Summary

[2-3 paragraphs explaining the problem being solved]
[Include context from ticket description and comments]

## Solution Overview

[Key features or fixes being implemented]
[Extract from HLD or ticket description]

## Key Insights

[Important findings from tickets AND Confluence docs]
[Technical decisions, constraints, considerations]

## Project Structure

| Path | Description |
|------|-------------|
| `confluence/` | HLD and design documentation |
| `00_Main_Task_*.md` | Main ticket details |
| `01_*.md` | Related ticket files |
| `test_plan/` | Test planning (create with /planning-tests) |
| `test_cases/` | Test cases (create with /designing-cases) |

## Team

| Role | Name | Ticket |
|------|------|--------|
| Dev Lead | [Name] | [TICKET] |
| QA | [Name] | [TICKET] |

## Resources

- [Jira Epic]([URL])
- [HLD Document](confluence/[filename].md)
- [Feature Request]([URL])

## Next Steps

1. Run `/planning-tests` to start test planning
2. Create test cases with `/designing-cases`
3. Sync to TestLink with `/syncing-testlink`
```

---

## File 6: Relationship Diagram

**Filename:** `Ticket_Relationship_Diagram.md`

```markdown
# Ticket Relationship Diagram

## Ticket Hierarchy

```
[PARENT_TICKET] (Epic)
├── [MAIN_TICKET] (Story) ◄── THIS PROJECT
│   ├── [CHILD_1] (Task) - [Status]
│   └── [CHILD_2] (Task) - [Status]
└── [SIBLING] (Story)
```

## Timeline

| Date | Event | Ticket |
|------|-------|--------|
| [Date] | Created | [TICKET] |
| [Date] | HLD linked | [TICKET] |
| [Date] | Development started | [TICKET] |
| [Date] | Resolved | [TICKET] |

## Team Assignments

| Ticket | Assignee | Status |
|--------|----------|--------|
| [TICKET] | [Name] | [Status] |

## Progress Summary

- Total Tickets: [N]
- Resolved: [N] ✓
- In Progress: [N] ●
- Open: [N] ○

## Confluence Documents

| Document | Type | Linked To |
|----------|------|-----------|
| [Title] | HLD | [TICKET] |
| [Title] | Design | [TICKET] |
```

---

## Tips

- **Extract insights from Confluence** - Don't just copy raw content; summarize key points
- **Include progress indicators** - Show what's resolved vs. open
- **Add next steps** - Guide user on test planning phase
- **Keep comments** - They contain crucial context and decisions
- **Follow naming conventions** - See folder-structure.md for details
