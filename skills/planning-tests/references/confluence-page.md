# Confluence Page Creation & Review Reference

## Creating Confluence Pages

### Instructions

1. **Get parent page info** to find the space key from parent page ID

2. **Read the source folder structure**
   - Look for `README.md` as the main page content
   - Look for `sections/` folder containing numbered section files (01_*, 02_*, etc.)

3. **Extract project ID from folder path**
   - Parse folder path to find project ID (e.g., `PROJ-12345` from `PROJ-12345_Feature_Description`)
   - Use this as prefix for all page titles

4. **Create parent page first**
   - Title format: `[PROJECT_ID]: [Title from README.md]`
   - Example: `PROJ-12345: Test Plan - Feature Description`
   - Content: README.md content
   - Parent: provided parent page ID

5. **Create child pages for each section**
   - Read each file in `sections/` folder in order (01, 02, 03...)
   - Title format: `[PROJECT_ID]: [Section Number]. [Section Title]`
   - Examples:
     - `PROJ-12345: 1. Project & Business Context`
     - `PROJ-12345: 2. Feature Definition`
     - `PROJ-12345: 3. Scope & Boundaries`
     - `PROJ-12345: 4. Test Strategy`
     - `PROJ-12345: 5. References & Resources`
     - `PROJ-12345: 6. Document Revision History`
   - Parent: The newly created parent page

6. **Report created pages**
   - List all created page IDs and titles
   - Provide links to the pages

### Page Naming Convention

| Source File | Page Title Format |
|-------------|-------------------|
| `README.md` | `[PROJECT_ID]: Test Plan - [Feature Name]` |
| `01_Project_Business_Context.md` | `[PROJECT_ID]: 1. Project & Business Context` |
| `02_Feature_Definition.md` | `[PROJECT_ID]: 2. Feature Definition` |
| `03_Scope_Boundaries.md` | `[PROJECT_ID]: 3. Scope & Boundaries` |
| `04_Test_Strategy.md` | `[PROJECT_ID]: 4. Test Strategy` |
| `05_References_Resources.md` | `[PROJECT_ID]: 5. References & Resources` |
| `06_Revision_History.md` | `[PROJECT_ID]: 6. Document Revision History` |

### MCP Tool
`mcp-atlassian:confluence_create_page`

---

## Reviewing Confluence Pages

### Formatting Checklist

#### 1. List Formatting
- [ ] Bullet lists render as proper `<ul><li>` (not plain text with `*` or `-`)
- [ ] Numbered lists render as proper `<ol><li>` (not plain text with `1.`, `2.`)
- [ ] Nested lists are NOT used (Confluence markdown doesn't support nesting)
- [ ] Sub-items use tables instead of nested lists

#### 2. Table Formatting
- [ ] Tables render as proper `<table>` elements (not plain text with `|`)
- [ ] No long semicolon-separated content in table cells
- [ ] Each distinct item has its own row

#### 3. Code Block Formatting
- [ ] ASCII diagrams preserved correctly in code blocks

#### 4. Content Completeness
- [ ] All section headers from source file present in Confluence
- [ ] All diagrams/ASCII art preserved in code blocks
- [ ] All table rows present (count items in source vs Confluence)
- [ ] All test steps/cases included (no truncation)

### Common Issues

| Issue | Symptom | Fix |
|-------|---------|-----|
| Nested lists collapsed | `1. Item - sub1 - sub2` on one line | Convert to table format |
| Lists as plain text | `* item` visible instead of bullet | Use storage format with `<ul><li><p>` |
| Tables as plain text | `\| col1 \| col2 \|` visible | Use storage format with `<table>` |
| Code blocks missing | ` ```code``` ` visible as text | Use `<ac:structured-macro>` |

### Agent Processing for Review

1. Fetch page using `mcp-atlassian:confluence_get_page` with `convert_to_markdown: false` to see raw storage format
2. Check for plain text markdown syntax that wasn't converted
3. Report issues found with specific locations
4. If issues found, recommend using storage format for update

### MCP Tool
`mcp-atlassian:confluence_get_page`

Parameters:
- `page_id`: The page ID to review
- `include_metadata`: true
- `convert_to_markdown`: false (important - see raw storage format)

---

<!-- Shared sections below (Multi-Page Sync, Content Completeness, ASCII Diagrams)
     are duplicated in designing-cases/references/confluence-page.md.
     Keep both files in sync when editing. -->

## Multi-Page Sync Workflow

When syncing multiple related pages (e.g., test plan sections folder):

1. **Create parent page first** with complete content
2. **Create child pages** with FULL content from source files
3. **Review ALL pages** — don't assume child pages are complete
4. **Compare file sizes** — if Confluence content is much shorter than local file, content is missing

### Common Multi-Page Issues

| Scenario | Issue | Solution |
|----------|-------|----------|
| Batch page creation | Later pages have simplified content | Re-sync with full source content |
| Child pages | Missing sections that parent has | Each page needs independent full sync |
| README with children | Children don't match their source files | Review each child against its source |

---

## Content Completeness Review

When syncing local files to Confluence, verify **content completeness** not just formatting.

### Content Truncation Detection

| Issue | Symptom | Prevention |
|-------|---------|------------|
| **Missing sections** | Page ends abruptly or lacks sections from source | Compare section headers between local file and Confluence page |
| **Simplified content** | Tables have fewer rows, test steps are missing | Count items in local file vs Confluence |
| **Missing diagrams** | ASCII diagrams not included in page | Check all code blocks are present |
| **Missing header metadata** | Objective/Focus/Test Cases count missing | Verify header section matches source |
| **Incomplete tables** | Preconditions or steps tables have fewer rows | Compare row counts |

### Content Completeness Checklist

When reviewing synced pages, verify:

1. **Header Section**
   - [ ] Title matches local file
   - [ ] Objective/Summary present
   - [ ] Focus/Category present
   - [ ] Test case count matches

2. **All Sections Present**
   - [ ] Count section headers (##) in local file
   - [ ] Verify same count in Confluence
   - [ ] Check section order matches

3. **Tables Complete**
   - [ ] Preconditions table has all rows
   - [ ] Test steps table has all steps
   - [ ] Summary table at end present

4. **Diagrams and Code Blocks**
   - [ ] All ASCII diagrams present
   - [ ] Diagram header boxes included
   - [ ] Special characters preserved

5. **Supplementary Content**
   - [ ] Notes sections present
   - [ ] Pass criteria included (if applicable)
   - [ ] Troubleshooting guides included (if applicable)

---

## ASCII Diagrams and Storage Format

### When to Use Storage Format (vs Markdown)

Use HTML storage format instead of markdown when:
- Page has nested lists that collapse incorrectly
- Tables don't render properly
- Code blocks show raw markdown syntax
- Page contains ASCII diagrams (flowcharts, coverage matrices, box diagrams)

For simple pages with only tables and bullet lists, markdown is fine.

### Storage Format for ASCII Diagrams

Markdown triple backticks do not render correctly for ASCII diagrams. Use the `ac:structured-macro` code block:

```xml
<ac:structured-macro ac:name="code" ac:schema-version="1">
  <ac:parameter ac:name="theme">Default</ac:parameter>
  <ac:parameter ac:name="language">none</ac:parameter>
  <ac:parameter ac:name="linenumbers">true</ac:parameter>
  <ac:plain-text-body><![CDATA[
┌─────────────────────────────────────────┐
│     YOUR ASCII DIAGRAM HERE             │
└─────────────────────────────────────────┘
  ]]></ac:plain-text-body>
</ac:structured-macro>
```

**Critical Parameters:**

| Parameter | Value | Why |
|-----------|-------|-----|
| `theme` | `Default` | Ensures proper styling |
| `language` | `none` | Prevents syntax highlighting that breaks box characters |
| `linenumbers` | `true` | Maintains alignment |

### Common Diagram Pitfalls

| Issue | Cause | Solution |
|-------|-------|----------|
| **"Defaultnonetrue" artifact** | Markdown code blocks with triple backticks | Use storage format with `ac:structured-macro` |
| **Box characters garbled** | `language=text` or other language | Use `language=none` |
| **API shows artifact but page is OK** | MCP API markdown conversion bug | Always verify in browser — API response may show false artifacts |

### Workflow for Pages with ASCII Diagrams

1. **Use storage format** — Not markdown format for pages with diagrams
2. **Wrap each diagram** in `ac:structured-macro` code block
3. **Update page** via MCP API
4. **Verify in browser** — Don't trust API response markdown conversion
5. **If artifact appears in browser**, check parameters match exactly

### Finding Working Examples

If diagrams aren't rendering correctly, find a working example page and examine its storage format:

```bash
# Get page storage format via MCP
confluence_get_page --page_id=PAGE_ID --expand=body.storage
```

Look for the `ac:structured-macro` block and copy its exact parameter structure.

### Important Note on API Response

The MCP API's markdown conversion may show artifacts like "Defaultnonetrue" when reading back a page, even when the actual browser rendering is correct. **Always verify diagram rendering in the browser** before assuming there's a problem.
