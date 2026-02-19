# Meeting Invite Template Reference

## Design Principles

The meeting invite format follows these visual design principles for readability:

### 1. White Space for Grouping

Use blank lines to create visual separation between sections.

### 2. Font Weight for Hierarchy

| Element | Format | Purpose |
|---------|--------|---------|
| Section titles | `## Title` | Primary navigation |
| Numbered items | `**1. Item**` | Secondary anchors within sections |
| Link labels | `**Label:**` | Tertiary anchors for reference items |

### 3. Reference-Style Links

Keep the body clean by moving URLs to the bottom:

```markdown
**Test Plan:** [Descriptive Title][test-plan]

**Epic:** [Ticket Title][epic]

[test-plan]: https://confluence-url
[epic]: https://jira-url
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

## Information Sources

Read project context from:
- Test plan README.md
- Test cases README.md
- Project README.md
- confluence/confluence_links.md (for Confluence URLs)
- Jira ticket (for reviewer names from assignee/reporter/watchers)

## Output File
Save as `Meeting_Invite_[Type]_Review.md` in project root

---

## Best Practices

1. Keep it concise - only essential information
2. Use descriptive link titles (not raw URLs)
3. Use reference-style links for clean body text
4. Group related items together with white space
5. Use bold for visual anchors and hierarchy
6. No emojis or decorative elements
