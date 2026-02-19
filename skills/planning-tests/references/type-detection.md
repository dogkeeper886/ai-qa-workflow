# Test Type Detection Reference

## Pre-Check: Verify Prerequisites

Before starting, verify these files exist (created by /receiving-tickets skill):
- [ ] `00_Main_Task_*.md` - Main ticket file
- [ ] `README.md` - Project overview
- [ ] Related ticket files (`01_*.md`)

**Optional but helpful:**
- [ ] `confluence/*.md` - Confluence documentation (HLD, designs)

If `00_Main_Task_*.md` is missing, instruct user: "Please run `/receiving-tickets [TICKET]` first to gather all documentation."

---

## Detection Logic

Read the main ticket file (`00_Main_Task_*.md`) and determine the testing context:

**Type A: New Feature Testing**
- **Indicators:** Ticket type = Epic, Feature, Story
- **Has:** HLD in confluence/ folder, child tickets (UX, UI, API stories)
- **Focus:** Validate new functionality works as designed
- **Plan type:** `tw-plan-feature` approach (5-8 scenarios)

**Type B: Customer Problem Testing (Bug Fix)**
- **Indicators:** Ticket type = Bug, Defect, Customer Issue
- **Has:** Comments with reproduction steps, customer reports
- **May lack:** HLD, design docs, stakeholder info
- **Focus:** Verify fix works, prevent recurrence
- **Plan type:** `tw-plan-bugfix` approach (2-4 scenarios)

**Type C: Enhancement/Improvement Testing**
- **Indicators:** Ticket type = Enhancement, Improvement, Task
- **Has:** Partial design docs, describes changes to existing features
- **Focus:** Validate enhancement + integration impact
- **Plan type:** `tw-plan-enhance` approach (4-6 scenarios)

---

## Detection Flow

```
READ 00_Main_Task_*.md header section

IF ticket_type in ['Epic', 'Feature', 'Story']:
  → Report: "Type A: New Feature Testing detected"
  → Use feature plan approach (see feature-plan.md)

ELSE IF ticket_type in ['Bug', 'Defect'] OR title contains 'customer issue':
  → Report: "Type B: Bug Fix Testing detected"
  → Use bugfix plan approach (see bugfix-plan.md)

ELSE IF ticket_type in ['Enhancement', 'Improvement', 'Task']:
  → Report: "Type C: Enhancement Testing detected"
  → Use enhance plan approach (see enhance-plan.md)

ELSE:
  → Ask user: "Is this for: (A) New feature testing, (B) Bug fix testing, or (C) Enhancement testing?"
```

---

## Output Format

```markdown
# Test Plan Initialization: [Project Name]

## Detection Results

**Detected Type:** [Type A/B/C]: [Description]
**Confidence:** [High/Medium/Low]

### Indicators Found
- [Indicator 1]
- [Indicator 2]
- [Indicator 3]

### Prerequisites Status
- [x] Main ticket file exists
- [x] README.md exists
- [ ] Confluence HLD (optional)

## Recommended Next Step

Proceeding with [feature/bugfix/enhance] test plan...

**Quick Reference:**
- Type A (Feature): Comprehensive, 5-8 scenarios
- Type B (Bug Fix): Focused, 2-4 scenarios
- Type C (Enhancement): Moderate, 4-6 scenarios
```
