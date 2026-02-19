---
name: planning-tests
description: |
  Creates a complete test plan from a project folder by detecting the ticket
  type, writing test plan sections, reviewing coverage, and publishing to
  Confluence. Use when a QA engineer wants to plan tests, create a test plan,
  write a test plan, or start test planning for a project.
disable-model-invocation: true
tools:
  - mcp-atlassian:confluence_create_page
  - mcp-atlassian:confluence_get_page
---

# planning-tests

Creates a complete test plan from a project folder by detecting the ticket type, writing sections, and publishing to Confluence.

## Progress Checklist

Copy and track your progress:

```
- [ ] Step 1: Validate prerequisites
- [ ] Step 2: Detect ticket type (Feature/Bug/Enhancement)
- [ ] Step 3: Write test plan to test_plan/
- [ ] Step 4: Review coverage (matrix + diagrams)
- [ ] Validate: Scenario count + coverage assessment
- [ ] Step 5: Create Confluence test plan pages
- [ ] Validate: Confluence URL + page count
- [ ] Step 6: Review Confluence for formatting issues
```

## Steps

### Step 1: Validate Prerequisites

Check that `00_Main_Task_*.md` exists in the current project folder.

If missing: "Please run `/receiving-tickets [TICKET]` first to gather all documentation."

### Step 2: Detect Ticket Type

Read `00_Main_Task_*.md` and detect:
- **Type A (Feature):** ticket type = Epic/Feature/Story → use `references/feature-plan.md`
- **Type B (Bug Fix):** ticket type = Bug/Defect → use `references/bugfix-plan.md`
- **Type C (Enhancement):** ticket type = Enhancement/Task → use `references/enhance-plan.md`

See `references/type-detection.md` for detection logic and output format.

### Step 3: Write Test Plan

Write test plan sections to `test_plan/README.md` and `test_plan/sections/` based on the detected type:
- Feature: 5-8 scenarios, comprehensive coverage
- Bug Fix: 2-4 scenarios, focused on defect verification + regression
- Enhancement: 4-6 scenarios, hybrid new + regression

See the appropriate plan reference file for output format and decision trees.

### Step 4: Review Plan

Analyze coverage and generate:
- Coverage matrix (ASCII table)
- Diagrams for 5+ scenarios (configuration flow, data flow, modular design)
- Gap and overlap analysis

See `references/plan-review.md` and `references/diagrams.md`.

### Validate

Report:
- Total scenario count
- Estimated test case count
- Coverage assessment: **READY FOR TEST CASES** or **NEEDS REVISION**

### Step 5: Create Confluence Pages

Create the test plan hierarchy in Confluence:
- Parent page: `[TICKET]: Test Plan - [Feature Name]`
- Child pages for each section

See `references/confluence-page.md` for naming conventions and MCP tool usage.

**MCP tool:** `mcp-atlassian:confluence_create_page`

### Validate

Report:
- Confluence parent page URL
- Number of pages created

### Step 6: Review Confluence

Fetch each created page and check for markdown conversion issues (lists rendering as plain text, missing tables, etc.).

See `references/confluence-page.md` for the formatting checklist.

**MCP tool:** `mcp-atlassian:confluence_get_page` with `convert_to_markdown: false`

## Expected Input

Path to project folder containing `00_Main_Task_*.md` and optional Confluence docs.

## Next Step

After planning tests, run `/designing-cases` to create detailed test cases.
