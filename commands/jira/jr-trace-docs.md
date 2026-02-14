# Jira Trace - Documentation Generation

```
Generate documentation files for a traced Jira ticket project.

Jira Issue Key: {{input}}

## PURPOSE

Generate all documentation files for the project:
1. Main ticket file with full details
2. Related ticket files
3. Confluence documentation files
4. Project README
5. Ticket relationship diagram

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

## FILE 4: CONFLUENCE INDEX

**Filename:** `confluence/confluence_links.md`

### Content Structure

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

## FILE 5: README

**Filename:** `README.md`

### Content Structure

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
| `test_plan/` | Test planning (create with /tw-plan-*) |
| `test_cases/` | Test cases (create with /tw-case-*) |

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

1. Run `/tw-plan-init` to start test planning
2. Create test plan with `/tw-plan-feature` or `/tw-plan-bugfix`
3. Generate test cases with `/tw-case-init`
```

---

## FILE 6: RELATIONSHIP DIAGRAM

**Filename:** `Ticket_Relationship_Diagram.md`

### Content Structure

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

## TIPS

- **Extract insights from Confluence** - Don't just copy raw content; summarize key points
- **Include progress indicators** - Show what's resolved vs. open
- **Add next steps** - Guide user on test planning phase
- **Keep comments** - They contain crucial context and decisions
- **Follow naming conventions** - See `/jr-trace-structure` for details
```
