# Confluence Format Guidelines

## Overview

This document provides guidelines for creating properly formatted Confluence pages programmatically.

## Path A — `mcp-atlassian:confluence_create_page` with `content_format: "markdown"` (RECOMMENDED for simple pages, verified 2026-05-15)

**Use markdown for flat, blank-line-separated content.** The Atlassian MCP server's markdown converter produces clean Confluence storage format for the majority of authoring needs. Verified across multiple multi-page test plan publishes.

What round-trips cleanly:

| Markdown input | Confluence output |
|---|---|
| `\| col \| col \|` table | `<table data-layout="default"><tbody>…<th><p>…` (proper Confluence table) |
| `- item` bullet (top-level, preceded by blank line) | `<ul><li><p>…</p></li></ul>` |
| `1. item` numbered (top-level, preceded by blank line) | `<ol start="1"><li><p>…</p></li></ol>` |
| ` ```mermaid ` fenced | `<ac:structured-macro ac:name="code"><ac:parameter ac:name="language">mermaid</ac:parameter>` (renders as a diagram if Mermaid Cloud app is installed; otherwise as readable source) |
| ` ```json ` etc. | `<ac:structured-macro ac:name="code">` with language parameter |
| `[text](url)` | `<a href="url">text</a>` |
| `**bold**` / `*italic*` | `<strong>…</strong>` / `<em>…</em>` |
| ``` `code` ``` | `<code>…</code>` |
| `---` | `<hr />` |
| `&` | auto-escaped to `&amp;` |
| `→` `↔` `↑` `↓` | preserved as Unicode (Confluence renders correctly) |

**Schema gotcha:** the tool's parameter description lists `markdown`, `wiki`, and `storage` as the supported values. `html` and `adf` are rejected by the validator despite some older notes claiming otherwise. Use `markdown` for simple pages and `storage` for pages with the gotcha patterns below (see Path C).

### Path A gotchas — patterns the markdown converter silently mangles

Four common patterns DO NOT round-trip cleanly. Each failure mode is silent — the page returns 200 OK from create/update — so you only catch it by re-fetching with `convert_to_markdown: false` and inspecting the storage HTML.

| Source pattern | What the converter produces | Fix |
|---|---|---|
| **Bold paragraph + immediately-following list with no blank line:**<br/>`**Heading:**`<br/>`- item A`<br/>`- item B` | Whole block collapses to one `<p>` paragraph with the hyphens preserved as plain text. **The list never renders.** | Insert a blank line between the bold paragraph and the first `-`. |
| **Nested list (2-space-indented sub-bullets):**<br/>`- Parent`<br/>`  - Sub-item 1`<br/>`  - Sub-item 2` | Sub-bullets are **flattened** to the same level as the parent — "Parent" sits next to "Sub-item 1" instead of containing it. | Either restructure as sibling lists separated by a paragraph, or switch the page to `content_format: "storage"` and write `<ul><li><p>Parent</p><ul><li><p>Sub-item 1</p></li></ul></li></ul>` directly (see § 1.3). |
| **Metadata block (multiple bold-prefixed lines, single newlines between):**<br/>`**Focus:** A`<br/>`**Estimated cases:** 3`<br/>`**Test plan reference:** ...` | All lines **merge** into one `<p>` paragraph with bold labels run together as one wall of inline text. | Insert blank lines (each line becomes its own `<p>`), or switch to storage format with `<p>...<br/>...<br/>...</p>` (the cleanest visual result). |
| **Task list checkboxes (`- [ ]`)** in a paragraph context | Render as **bullet items with literal `[ ]` text**, not as native `<ac:task-list>` macros — even with a blank line before. The native task-list conversion is unreliable across contexts. | Use `content_format: "storage"` with explicit `<ac:task-list>` + `<ac:task>` macros (see § 1.4 below). |

**Decision rule (apply before every publish):** scan the source markdown for the four patterns above.

- **All four absent** → markdown is fine, use Path A as-is.
- **Patterns 1 or 3 present** → either pre-process the markdown to insert blank lines / `<br/>`, or write the page in storage format.
- **Patterns 2 or 4 present** → markdown cannot express the intent; write that page in storage format. Mixing is OK: most pages in a publish can be markdown while just the ones with nested lists or task lists are storage.

**Pre-flight check (mandatory for batch publishes):** after creating pages, immediately re-fetch each with `convert_to_markdown: false` and grep the storage HTML for these red flags before declaring the publish complete:

- `<p>…<strong>…:</strong>\s*-\s` (collapsed bold-then-list)
- `<li><p>\[ \]` or `<li>\[ \]` (un-converted task-list markers)
- `<p>…<strong>Focus:</strong>…<strong>Estimated test cases:</strong>` (collapsed metadata block)
- `<li>…</li>\s*<li>` followed at the same depth by items that should have been nested (harder to detect mechanically — eyeball the `Checkpoints:` / `tenant already has:` style patterns)

Run `/cf-review-page` against each page; it automates this scan.

## Path C — Mixed markdown + storage (RECOMMENDED for multi-page publishes with mixed content)

In practice, a typical test-plan publish has both simple pages (sections, README) and complex pages (TS-XX scenarios with nested Checkpoints, Test Strategy with task lists). Rather than picking one format for the whole publish, pick per page based on the patterns each page contains:

| Page shape | Recommended format |
|---|---|
| Flat bullets + tables + code blocks + Mermaid | `markdown` |
| Bold-paragraph-headed sub-lists (e.g. Scope `**Admin configuration:** + bullets`) | `markdown` with blank line before each list (works) |
| Nested lists (e.g. TS-XX `Checkpoints:` with sub-bullets) | `storage` |
| Task-list checkboxes (Entry/Exit Criteria) | `storage` with `<ac:task-list>` |
| Metadata header block (`**Focus:** … **Estimated cases:** …`) | `storage` with `<br/>`, OR markdown with blank lines between each label line |

Both `mcp-atlassian:confluence_create_page` and `mcp-atlassian:confluence_update_page` accept `content_format: "markdown"` or `"storage"`. Pages can be mixed within a single publish — no special handling needed at the API level.

**Recovery pattern:** if a page was created in markdown and the review reveals one of the Path A gotchas, update the same page ID with `content_format: "storage"` rather than delete-and-recreate. This preserves the page URL (and any inbound links from Jira/Slack/demo decks).

## Path B — Direct Confluence REST API call (legacy, manual conversion required)

When NOT going through the MCP tool (direct `POST /wiki/rest/api/content` calls), the older guidance below applies: write Confluence storage format (HTML-based) by hand because the REST API's markdown intake was unreliable for tables and lists.

This path is retained for completeness but should not be the default. The MCP tool covers all current authoring needs.

### Legacy Key Principle

**Use Confluence `storage` format (HTML-based) instead of `markdown` format** when creating pages programmatically through the legacy REST API. Markdown format often fails to convert lists and tables properly, resulting in plain text with markdown syntax instead of proper HTML elements.

---

## 1. Lists

### 1.1 Bullet Lists (Unordered Lists)

**Correct Format (Storage/HTML):**
```html
<ul>
  <li><p>First item</p></li>
  <li><p>Second item</p></li>
  <li><p>Third item</p></li>
</ul>
```

**Incorrect (Markdown converted):**
```html
<p> * First item * Second item * Third item</p>
```

**Example:**
```html
<ul>
  <li><p>First feature requirement with <strong>important detail</strong></p></li>
  <li><p>Second feature requirement with additional information</p></li>
</ul>
```

**Key Points:**
- Each list item (`<li>`) must contain a paragraph (`<p>`) tag
- Use `<ul>` for unordered/bullet lists
- Nested lists: Place nested `<ul>` or `<ol>` inside the parent `<li>` element

### 1.2 Numbered Lists (Ordered Lists)

**Correct Format (Storage/HTML):**
```html
<ol start="1">
  <li><p>First step</p></li>
  <li><p>Second step</p></li>
  <li><p>Third step</p></li>
</ol>
```

**Incorrect (Markdown converted):**
```html
<p> 1. First step 2. Second step 3. Third step</p>
```

**Example:**
```html
<ol start="1">
  <li><p><strong>Precondition:</strong> Set up test environment</p></li>
  <li><p>Navigate to the feature page</p></li>
  <li><p><strong>Test Execution:</strong> Perform the test steps</p></li>
</ol>
```

**Key Points:**
- Use `<ol>` for ordered/numbered lists
- Include `start="1"` attribute (or appropriate start number)
- Each list item (`<li>`) must contain a paragraph (`<p>`) tag

### 1.3 Nested Lists

**Correct Format:**
```html
<ul>
  <li><p>Parent item</p>
    <ul>
      <li><p>Nested item 1</p></li>
      <li><p>Nested item 2</p></li>
    </ul>
  </li>
  <li><p>Another parent item</p></li>
</ul>
```

**Key Points:**
- Nested list goes inside the parent `<li>` element, after the `<p>` tag
- Can mix `<ul>` and `<ol>` for nested lists
- **Markdown cannot express nesting reliably** — the MCP converter flattens 2-space-indented sub-bullets (see Path A gotchas above). For any page with nested lists, use `content_format: "storage"` with the structure above.

### 1.4 Task Lists (Native Confluence Checkboxes)

When the page needs **interactive checkboxes** (Entry/Exit criteria, sign-off checklists, definition-of-done lists), use Confluence's native task-list macro. The markdown `- [ ]` shortcut converts unreliably (see Path A gotchas) — write storage format directly.

**Correct Format (Storage):**
```html
<ac:task-list>
  <ac:task>
    <ac:task-id>1</ac:task-id>
    <ac:task-status>incomplete</ac:task-status>
    <ac:task-body>First criterion to verify</ac:task-body>
  </ac:task>
  <ac:task>
    <ac:task-id>2</ac:task-id>
    <ac:task-status>incomplete</ac:task-status>
    <ac:task-body>Second criterion — inline <code>code</code> and <strong>bold</strong> are fine inside <code>ac:task-body</code></ac:task-body>
  </ac:task>
</ac:task-list>
```

**Key Points:**
- Each task needs a unique `<ac:task-id>` (any integer; just keep them unique within the page).
- `<ac:task-status>` is `incomplete` or `complete`.
- `<ac:task-body>` accepts inline HTML (`<code>`, `<strong>`, `<a>`, etc.) but not block-level elements.
- The rendered output is a checkbox the reader can tick directly in Confluence — much better than a bullet list with `[ ]` placeholder text.
- Reference example: a Test Strategy page § 4.5 with 16 task-list items split across Entry Criteria (9) and Exit Criteria (7).

---

## 2. Tables

### 2.1 Basic Table Structure

**Correct Format (Storage/HTML):**
```html
<table ac:local-id="unique-id" data-layout="center" data-table-width="1800">
  <tbody>
    <tr>
      <th><p>Header 1</p></th>
      <th><p>Header 2</p></th>
    </tr>
    <tr>
      <td><p>Cell 1</p></td>
      <td><p>Cell 2</p></td>
    </tr>
  </tbody>
</table>
```

**Incorrect (Markdown converted):**
```html
<p>|| Header 1 || Header 2 || | Cell 1 | Cell 2 |</p>
```

**Example:**
```html
<table ac:local-id="unique-id-here" data-layout="center" data-table-width="1800">
  <tbody>
    <tr>
      <th><p>Category</p></th>
      <th><p>Description</p></th>
    </tr>
    <tr>
      <td><p>Feature A</p></td>
      <td><p>Description of feature A</p></td>
    </tr>
  </tbody>
</table>
```

**Key Points:**
- Use `<table>` with Confluence attributes:
  - `ac:local-id`: Unique identifier (can be generated UUID)
  - `data-layout="center"`: Center alignment
  - `data-table-width="1800"`: Table width in pixels
- Table structure: `<table>` → `<tbody>` → `<tr>` → `<th>` or `<td>`
- Each cell content should be wrapped in `<p>` tags
- Use `<th>` for header cells, `<td>` for data cells

### 2.2 Tables with Bullet Points in Cells

**Correct Format:**
```html
<table>
  <tbody>
    <tr>
      <td><p>• First bullet point<br/>• Second bullet point<br/>• Third bullet point</p></td>
    </tr>
  </tbody>
</table>
```

**Key Points:**
- Use bullet character `•` (not asterisk `*`)
- Use `<br/>` for line breaks between bullet points
- All bullet points in one `<p>` tag

**Example:**
```html
<td><p>• First feature requirement<br/>• Second feature requirement<br/>• Third feature requirement</p></td>
```

### 2.3 Tables with Multiple Columns

**Correct Format:**
```html
<table ac:local-id="unique-id" data-layout="center" data-table-width="1800">
  <colgroup>
    <col style="width: 124.0px;"/>
    <col style="width: 155.0px;"/>
    <col style="width: 1350.0px;"/>
  </colgroup>
  <tbody>
    <tr>
      <th><p>Column 1</p></th>
      <th><p>Column 2</p></th>
      <th><p>Column 3</p></th>
    </tr>
    <tr>
      <td><p>Data 1</p></td>
      <td><p>Data 2</p></td>
      <td><p>Data 3</p></td>
    </tr>
  </tbody>
</table>
```

**Key Points:**
- Use `<colgroup>` with `<col>` elements to define column widths
- Column widths can be specified in pixels (e.g., `width: 124.0px`)

---

## 3. Code Blocks

### 3.1 Inline Code

**Correct Format:**
```html
<code>feature-flag-name</code>
```

### 3.2 Code Blocks

**Correct Format (Using Confluence Code Macro):**
```html
<ac:structured-macro ac:name="code" ac:schema-version="1">
  <ac:parameter ac:name="language">json</ac:parameter>
  <ac:plain-text-body><![CDATA[{
  "name": "example-config",
  "type": "EXAMPLE"
}]]></ac:plain-text-body>
</ac:structured-macro>
```

**Or Simple Code Block:**
```html
<ac:structured-macro ac:name="code" ac:schema-version="1">
  <ac:plain-text-body><![CDATA[POST /api/v1.1/example-endpoint]]></ac:plain-text-body>
</ac:structured-macro>
```

**Key Points:**
- Use `<ac:structured-macro>` with `ac:name="code"`
- Wrap code content in `<![CDATA[...]]>` to preserve formatting
- Optional: Add `ac:parameter` with `ac:name="language"` for syntax highlighting

---

## 4. Headers

### 4.1 Header Levels

**Correct Format:**
```html
<h1>Main Title</h1>
<h2>Section Title</h2>
<h3>Subsection Title</h3>
<h4>Sub-subsection Title</h4>
<h5>Operation Title</h5>
```

**Key Points:**
- Use appropriate header levels for document hierarchy
- H1 for main title, H2 for major sections, H3 for subsections, etc.

---

## 5. Links

### 5.1 External Links

**Correct Format:**
```html
<a href="https://example.atlassian.net/browse/PROJ-123">PROJ-123</a>
```

### 5.2 Confluence Page Links

**Correct Format:**
```html
<ac:link>
  <ri:page ri:content-title="Page Title" ri:space-key="SPACE"></ri:page>
  <ac:link-body>Page Title</ac:link-body>
</ac:link>
```

**Or Simple Link Format:**
```html
<a href="https://example.atlassian.net/wiki/spaces/SPACE/pages/123456789">Confluence Page Title</a>
```

**Key Points:**
- Replace `SPACE` with your Confluence space key
- Replace `123456789` with the actual page ID
- Replace `example.atlassian.net` with your Confluence instance URL

---

## 6. Text Formatting

### 6.1 Bold Text

**Correct Format:**
```html
<strong>Bold Text</strong>
```

### 6.2 Italic Text

**Correct Format:**
```html
<em>Italic Text</em>
```

### 6.3 Paragraphs

**Correct Format:**
```html
<p>Paragraph text here.</p>
```

**Key Points:**
- Always wrap text content in `<p>` tags
- Use `<br/>` for line breaks within paragraphs

---

## 7. Horizontal Rules

**Correct Format:**
```html
<hr/>
```

---

## 8. Special Characters

### 8.1 Bullet Character in Tables

**Use:** `•` (bullet character, Unicode U+2022)

**Not:** `*` (asterisk)

### 8.2 HTML Entities

- Less than: `&lt;` or `<`
- Greater than: `&gt;` or `>`
- Ampersand: `&amp;` or `&`
- Quotes: `&quot;` or `"`

---

## 9. Complete Example Structure

### 9.1 Section with Lists and Tables

```html
<h2>1. Project &amp; Business Context</h2>
<h3>1.1 Product Overview</h3>
<p><strong>Product:</strong> Product Name<br/> <strong>Feature:</strong> Feature Name<br/> <strong>Release Version:</strong> Version Number</p>

<h3>1.2 Business Value</h3>
<p>Description text here.</p>
<p><strong>User Benefits:</strong></p>
<table ac:local-id="unique-id" data-layout="center" data-table-width="1800">
  <tbody>
    <tr>
      <th><p>Benefit</p></th>
      <th><p>Description</p></th>
    </tr>
    <tr>
      <td><p>Benefit Name</p></td>
      <td><p>Description of the benefit</p></td>
    </tr>
  </tbody>
</table>

<p><strong>Business Impact:</strong></p>
<ul>
  <li><p>Addresses customer feature request</p></li>
  <li><p>Prioritized feature for upcoming release</p></li>
</ul>
```

### 9.2 Section with Numbered List

```html
<h4>Workflow Steps</h4>
<ol start="1">
  <li><p>First step with configuration (e.g., <code>example.com</code>, port 8080)</p></li>
  <li><p>Second step in the workflow</p></li>
  <li><p>Third step to complete the process</p></li>
</ol>
```

---

## 10. Common Mistakes to Avoid

### ❌ Mistake 1: Using Markdown Format
**Problem:** Markdown format doesn't convert lists and tables properly
```javascript
// DON'T DO THIS
content_format: "markdown"
```

**Solution:** Use storage format
```javascript
// DO THIS
content_format: "storage"
```

### ❌ Mistake 2: Lists Without Paragraph Tags
**Problem:**
```html
<ul>
  <li>Item without paragraph</li>
</ul>
```

**Solution:**
```html
<ul>
  <li><p>Item with paragraph</p></li>
</ul>
```

### ❌ Mistake 3: Tables as Plain Text
**Problem:**
```html
<p>|| Header || | Cell |</p>
```

**Solution:**
```html
<table>
  <tbody>
    <tr>
      <th><p>Header</p></th>
    </tr>
    <tr>
      <td><p>Cell</p></td>
    </tr>
  </tbody>
</table>
```

### ❌ Mistake 4: Numbered Lists as Plain Text
**Problem:**
```html
<p>1. First step 2. Second step</p>
```

**Solution:**
```html
<ol start="1">
  <li><p>First step</p></li>
  <li><p>Second step</p></li>
</ol>
```

---

## 11. Best Practices

1. **Always use `storage` format** when creating pages programmatically
2. **Wrap all text content in `<p>` tags** - even inside list items and table cells
3. **Use proper HTML structure** - `<ul>`, `<ol>`, `<table>`, etc.
4. **Include Confluence attributes** for tables (`ac:local-id`, `data-layout`, `data-table-width`)
5. **Use bullet character `•`** (not asterisk `*`) in table cells
6. **Use `<br/>` for line breaks** within paragraphs or table cells
7. **Test the page** after creation to verify formatting
8. **Reference existing well-formatted pages** in your Confluence instance as examples

---

## 12. Format Conversion Checklist

When converting markdown to Confluence storage format:

- [ ] Convert `*` bullet lists to `<ul><li><p>...</p></li></ul>`
- [ ] Convert numbered lists to `<ol start="1"><li><p>...</p></li></ol>`
- [ ] Convert `||` tables to proper `<table>` HTML
- [ ] Wrap all text in `<p>` tags
- [ ] Convert inline code `` `code` `` to `<code>code</code>`
- [ ] Convert code blocks to `<ac:structured-macro ac:name="code">`
- [ ] Convert markdown links `[text](url)` to `<a href="url">text</a>`
- [ ] Convert `**bold**` to `<strong>bold</strong>`
- [ ] Convert `*italic*` to `<em>italic</em>`
- [ ] Add Confluence table attributes (`ac:local-id`, `data-layout`, `data-table-width`)
- [ ] Use `•` character (not `*`) for bullets in table cells
- [ ] Use `<br/>` for line breaks in table cells

---

## 13. Multi-Page Sync Workflow

When syncing multiple related pages to Confluence:

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

## 14. Content Completeness Checklist

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

### Content Truncation Detection

| Issue | Symptom | Prevention |
|-------|---------|------------|
| **Missing sections** | Page ends abruptly or lacks sections from source | Compare section headers between local file and Confluence page |
| **Simplified content** | Tables have fewer rows, test steps are missing | Count items in local file vs Confluence |
| **Missing diagrams** | ASCII diagrams not included in page | Check all code blocks are present |
| **Missing header metadata** | Objective/Focus/Test Cases count missing | Verify header section matches source |
| **Incomplete tables** | Preconditions or steps tables have fewer rows | Compare row counts |

---

## 15. Reference

- **Confluence Storage Format Documentation:** [Confluence Storage Format](https://developer.atlassian.com/cloud/confluence/apis-for-confluence-content/)
- **Confluence REST API:** [Confluence REST API Documentation](https://developer.atlassian.com/cloud/confluence/rest/)
- **Created:** 2025-11-06
- **Based on:** Analysis of Confluence page formatting patterns and common conversion issues

---

**Note:** This document should be updated as new formatting patterns are discovered or Confluence formatting requirements change.

