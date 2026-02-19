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

### Content Completeness Checklist

- [ ] All section headers from source file present in Confluence
- [ ] All test cases included (no truncation)
- [ ] All test steps/actions present
- [ ] All expected results match source file exactly
- [ ] Prerequisites/preconditions complete
- [ ] Summary tables present with correct row counts

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
