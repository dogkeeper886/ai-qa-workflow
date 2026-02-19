# Demo Content Reference

## Design Principles

Demo content should be **concise and user-focused**, with bullets for slides and conversational script for the presenter co-located per slide.

- `**Bullets:**` = what goes on the slide (concise, scannable)
- `**Script:**` = what presenter says (verbose, conversational, quoted speech)
- Both live together per slide so edits stay in sync

### Slide Structure (6 slides maximum)

| Slide | Title | Bullets | Script |
|-------|-------|---------|--------|
| 1 | Title | Ticket ID + Feature Name + Subtitle | One sentence introduction |
| 2 | What We Built | 3-4 user-facing capabilities | Single paragraph, no technical details |
| 3 | The Problem | 3-4 user impacts being solved | User impact focus, not system internals |
| 4 | What's New | UI changes and behaviors | Navigation steps + UI explanation |
| 5 | Demo | Screenshot placeholder | Observational language phrases |
| 6 | Questions | Q&A slide | Brief closing statement |

### What to Exclude

| Exclude | Reason |
|---------|--------|
| **Feature flags** | Internal implementation detail |
| **Backend values** | Technical detail (e.g., "-1 means unlimited") |
| **Customer examples** | Unless explicitly provided |
| **Time estimates** | Keep flexible for live demo |
| **Next Steps** | Not needed for demo |

---

## Template

```markdown
# Demo Showcase: [TICKET]
## [Feature Name]

---

## Slide 1: Title
**Title:** [TICKET]: [Feature Name]
**Subtitle:** [One-line description of the capability]

**Script:**
"Today I'm going to show you our new feature: [Feature Name]. This is for ticket [TICKET]."

---

## Slide 2: What We Built
**Title:** What We Built
**Bullets:**
- [User-facing capability 1]
- [User-facing capability 2]
- [User-facing capability 3]

**Script:**
"Let me start by explaining what we built. [One paragraph describing user-facing capability.]"

---

## Slide 3: The Problem
**Title:** The Problem
**Bullets:**
- [User pain point 1]
- [User pain point 2]
- [User pain point 3]

**Script:**
"Now, let's talk about the problem we're solving. [Problem description focused on user impact.]"

---

## Slide 4: What's New
**Title:** What's New
**Bullets:**
- [UI change or new option 1]
- [UI change or new option 2]
- [Behavior change 1]

**Script:**
"To access this setting:
1. Navigate to [Menu] > [Submenu] > [Page]
2. Select [option or item]
3. Click on [menu or button]"

"Under [Section Name], you'll see [UI element description]."

---

## Slide 5: Demo
**Title:** Demo
**Content:** [Screenshot placeholder]

**Script:**
"Now let me show you how [feature] looks in action."
"You can see [observation about current state]."

---

## Slide 6: Questions
**Title:** Questions?

**Script:**
"That's [Feature Name]. Thank you for watching."
```

---

## Information Sources

Read project context from:
1. Project README.md
2. Test plan README.md or sections
3. HLD/Confluence documentation
4. Jira ticket summary

## Extract Key Information
- Feature name and ticket ID
- User-facing capabilities (3-4 bullets)
- Problems being solved (3-4 bullets)
- UI changes and behaviors
- Navigation path to feature

## Output File
Create `demo/` folder if it doesn't exist
Save as `demo/Demo_Showcase_Content.md`

---

## Bullet Writing Guidelines

### Good Bullets
- Start with action or outcome
- User-focused language
- Short and scannable (under 10 words ideal)
- No technical jargon

| Bad (Technical) | Good (User-Focused) |
|-----------------|---------------------|
| "Backend API returns -1 for unlimited" | "Unlimited devices option available" |
| "Feature flag controls visibility" | "New checkbox in User Connection settings" |
