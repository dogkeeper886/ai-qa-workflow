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
