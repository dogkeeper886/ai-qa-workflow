# Confluence Page Creation & Review Reference (Test Cases)

## Creating Test Case Confluence Pages

### Instructions

1. **Get parent page info** to find the space key from parent page ID

2. **Read the source folder structure**
   - Look for `README.md` as the main page content (test cases index)
   - Look for individual `TS-XX_*.md` files as child pages

3. **Extract project ID from folder path**
   - Parse folder path to find project ID (e.g., `PROJ-12345`)
   - Use this as prefix for all page titles

4. **Create parent page first**
   - Title format: `[PROJECT_ID]: Test Cases - [Feature Name]`
   - Example: `PROJ-12345: Test Cases - Feature Description`
   - Content: README.md content
   - Parent: provided parent page ID

5. **Create child pages for each test scenario**
   - Read each `TS-XX_*.md` file
   - Title format: `[PROJECT_ID]: [TS-XX] - [Scenario Name]`
   - Examples:
     - `PROJ-12345: TS-01 - Defect Verification`
     - `PROJ-12345: TS-02 - Regression Testing`
   - Parent: The newly created parent page

6. **Report created pages**
   - List all created page IDs and titles
   - Provide links to the pages

### Page Naming Convention

| Source File | Page Title Format |
|-------------|-------------------|
| `README.md` | `[PROJECT_ID]: Test Cases - [Feature Name]` |
| `TS-01_*.md` | `[PROJECT_ID]: TS-01 - [Scenario Name]` |
| `TS-02_*.md` | `[PROJECT_ID]: TS-02 - [Scenario Name]` |

### MCP Tool
`mcp-atlassian:confluence_create_page`

---

## Reviewing Confluence Pages

### Quick Content Check

- [ ] Section header count matches source file
- [ ] Test case count matches (no truncation)
- [ ] Summary table row counts match

For a detailed content completeness checklist, see the **Content Completeness Review** section below.

### Formatting Checklist

- [ ] Bullet lists render as proper `<ul><li>`
- [ ] Numbered lists render as proper `<ol><li>`
- [ ] Tables render as proper `<table>` elements (not plain `|`)
- [ ] No markdown syntax visible as plain text

### Common Issues

| Issue | Symptom | Fix |
|-------|---------|-----|
| Lists as plain text | `* item` visible instead of bullet | Use storage format with `<ul><li><p>` |
| Tables as plain text | `\| col1 \| col2 \|` visible | Use storage format with `<table>` |
| Missing test cases | Page ends abruptly | Compare test case count in local file vs Confluence |
| Summarized expected results | Generic results instead of specific ones | Match expected results word-for-word |

### Agent Processing for Review

1. Fetch page using `mcp-atlassian:confluence_get_page` with `convert_to_markdown: false`
2. Compare section headers between local file and Confluence
3. Count test cases in source vs Confluence
4. Check for missing/truncated sections
5. Report issues and provide update recommendations

### MCP Tool
`mcp-atlassian:confluence_get_page`

Parameters:
- `page_id`: The page ID to review
- `include_metadata`: true
- `convert_to_markdown`: false (important - see raw storage format)

---

<!-- Shared sections below (Multi-Page Sync, Content Completeness, ASCII Diagrams)
     are duplicated in planning-tests/references/confluence-page.md.
     Keep both files in sync when editing. -->

## Multi-Page Sync Workflow

When syncing multiple related pages (e.g., test cases folder):

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
