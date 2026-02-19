# Demo Share Email Template Reference

## Design Principles

Demo share emails should be **concise and scannable**, with clear sections that help recipients quickly understand what was built and where to watch the demo.

### Email Structure

| Section | Purpose | Content |
|---------|---------|---------|
| **Opening** | Context | "We've created a demo recording... It's about X minutes long." |
| **What We Built** | Brief description | 1-2 sentences, user-facing capability |
| **The Problem** | Why it matters | 3-5 bullet points of user pain |
| **What's New** | Key changes | 3-5 bullet points of improvements |
| **Demo Recording** | Links | Duration + 2-3 links (video, slides) |
| **The recording shows:** | Content preview | 3-4 bullets of what viewers will see |
| **Key Benefits** | Value summary | 3-4 bullets of user value |
| **Closing** | Sign off | Questions invitation + thanks |

### What to Exclude

| Exclude | Reason |
|---------|--------|
| **Feature flags** | Internal implementation |
| **Backend values** | Technical detail |
| **Navigation steps** | Save for demo itself |
| **Detailed flow** | Covered in recording |
| **Customer names** | Unless approved |

---

## Template

```markdown
# Demo Recording Share: [TICKET]

**Subject:** Demo Recording: [Feature Name] - [TICKET]

Hi Team,

We've created a demo recording for our latest feature. It's about [X] minutes long.

**What We Built**

[1-2 sentences describing the user-facing capability in plain language.]

**The Problem**

- [User pain point 1]
- [User pain point 2]
- [User pain point 3]

**What's New**

- [Key change 1]
- [Key change 2]
- [Key change 3]

**Demo Recording (~[X] minutes)**

- [Link 1 - primary video]
- [Link 2 - backup/alternate]
- [Link 3 - slides if available]

**The recording shows:**
- [Demo content 1]
- [Demo content 2]
- [Demo content 3]

**Key Benefits**

- **[Benefit 1]:** [One sentence explanation]
- **[Benefit 2]:** [One sentence explanation]
- **[Benefit 3]:** [One sentence explanation]

If you have any questions, please let me know.

Thanks,
[Name]
```

---

## Information Sources

Read project context from (in order of preference):
1. `demo/Demo_Showcase_Content.md` (preferred - reuse bullets/content)
2. Project README.md
3. Test plan README.md or sections
4. HLD/Confluence documentation
5. Jira ticket summary

## Extract Key Information
- Feature name and ticket ID
- User-facing capability (brief description)
- Problems being solved (user pain points)
- What's new (key changes)
- Key benefits (user value)

## Output File
Save as `demo/Demo_Showcase_Email.md`

---

## Writing Guidelines

### Good vs Bad Bullets

| Bad (Technical) | Good (User-Focused) |
|-----------------|---------------------|
| "API returns lastSeenTimestamp field" | "Last Seen field shows when device was online" |
| "Backend stores uptime in seconds" | "Uptime shows how long device was running" |

### Benefit Statement Format

Format: **[Benefit Name]:** [One sentence explanation]

Examples:
- **Better troubleshooting:** Know exactly when device was last seen
- **Historical context:** See last uptime before disconnection
- **No data loss:** Information stays even when device is offline
