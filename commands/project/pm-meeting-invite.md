# Create Meeting Invite

Generate a meeting invite for test plan review, test cases review, or demo showcase.

**Usage:** `/create-meeting-invite [TEST_PLAN_PATH] [TEST_CASES_PATH]`

**Arguments:**
- `$ARGUMENTS` - Paths to test_plan and test_cases folders

---

## Design Principles

The meeting invite format follows these visual design principles for readability:

### 1. White Space for Grouping

Use blank lines to create visual separation between sections. Related items stay together, unrelated items have space between them.

```
## Section A

Content for section A
- Item 1
- Item 2

## Section B

Content for section B
```

### 2. Font Weight for Hierarchy

Use bold (**text**) to create visual anchors and establish hierarchy:

| Element | Format | Purpose |
|---------|--------|---------|
| Section titles | `## Title` | Primary navigation |
| Numbered items | `**1. Item**` | Secondary anchors within sections |
| Link labels | `**Label:**` | Tertiary anchors for reference items |

### 3. Dark Grey Color (Calendar Rendering)

When rendered in calendar apps (Outlook, Teams), links appear in a muted/dark color that draws attention to "detail info to read" without being distracting. The link text provides context, the URL is secondary.

### 4. Reference-Style Links

Keep the body clean by moving URLs to the bottom:

```markdown
**Test Plan:** [Descriptive Title][test-plan]

**Epic:** [Ticket Title][epic]

[test-plan]: https://confluence.example.com/pages/12345
[epic]: https://jira.example.com/browse/PROJ-12345
```

Benefits:
- Body text remains scannable
- URLs grouped at bottom for reference
- Easy to update links without changing body

---

## Review Meeting Template

### Sections to Include

1. **Purpose** - One sentence explaining what will be reviewed
2. **Agenda** - Numbered sections with bullet points
3. **Please Review Before Meeting** - Reference-style links to documents

### Sections to AVOID

- Meeting Details (Subject, Date, Duration, Location, Attendees)
- Horizontal rule separators between content sections
- Time allocations in agenda (10 min, 25 min)
- Entry Criteria, Key Questions, Calendar Invite Text sections
- Emojis or icons

### Template

```markdown
# Meeting Invite: [Review Type] - [TICKET]

## Purpose

Review [test plan/test cases] for [TICKET] to ensure [alignment with HLD / quality and readiness for execution].

## Agenda

**1. [Overview Section]**
- [Key point 1]
- [Key point 2]
- [Key point 3]

**2. [Review Section]**
- [Item 1]
- [Item 2]
- [Item 3]

## Please Review Before Meeting

**Test Plan:** [PROJ-XXXXX: Test Plan - Feature Name][test-plan]

**Test Cases:** [PROJ-XXXXX: Test Cases - Feature Name][test-cases]

**Epic:** [PROJ-XXXXX Feature Name][epic]

**HLD:** [HLD - Feature Name][hld]

**Figma:** [UX Wireframes][figma]

[test-plan]: https://confluence-url
[test-cases]: https://confluence-url
[epic]: https://jira-url
[hld]: https://confluence-url
[figma]: https://figma-url
```

---

## Demo Showcase Template

```markdown
# Demo Invitation: [TICKET]

## [Feature Name]

### What We Built

[One paragraph describing what was built]

### The Problem

- [Problem point 1]
- [Problem point 2]
- [Problem point 3]

### What's New

**[Feature 1]** - [description]

**[Feature 2]** - [description]

**[Feature 3]** - [description]

### Demo Flow

**1. Show the problem** - [description]

**2. Walk through [feature]** - [description]

**3. Questions and next steps**

### Who Should Attend

- Product Managers
- Support Engineers
- [Other relevant teams]

### Why This Matters

- [Benefit 1]
- [Benefit 2]
- [Benefit 3]

### Ready to Demo

- Test environment is set up
- Sample configurations prepared
- All features working and tested

**Contact the team to schedule your demo.**
```

---

## Agent Instructions

1. **Read project context** from test_plan and test_cases paths provided
2. **Gather context** from:
   - Test plan README.md
   - Test cases README.md
   - Project README.md
   - confluence/confluence_links.md (for Confluence URLs)
3. **Apply design principles** (white space, font weight, reference links)
4. **Output to file** as `Meeting_Invite_[Type]_Review.md` in project root

## Best Practices

1. Keep it concise - only essential information
2. Use descriptive link titles (not raw URLs)
3. Use reference-style links for clean body text
4. Group related items together with white space
5. Use bold for visual anchors and hierarchy
6. No emojis or decorative elements
