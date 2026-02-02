# Create Confluence Page

Create Confluence pages from a test plan folder under parent page {{parent_page_id}}.

Source folder: $ARGUMENTS

## Instructions

1. **Get parent page info** to find the space key from page ID {{parent_page_id}}

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
   - Parent: {{parent_page_id}}

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
   - Parent: The newly created parent page (from step 4)
   - Content: Section file content

6. **Report created pages**
   - List all created page IDs and titles
   - Provide links to the pages

## Page Naming Convention

| Source File | Page Title Format |
|-------------|-------------------|
| `README.md` | `[PROJECT_ID]: Test Plan - [Feature Name]` |
| `01_Project_Business_Context.md` | `[PROJECT_ID]: 1. Project & Business Context` |
| `02_Feature_Definition.md` | `[PROJECT_ID]: 2. Feature Definition` |
| `03_Scope_Boundaries.md` | `[PROJECT_ID]: 3. Scope & Boundaries` |
| `04_Test_Strategy.md` | `[PROJECT_ID]: 4. Test Strategy` |
| `05_References_Resources.md` | `[PROJECT_ID]: 5. References & Resources` |
| `06_Revision_History.md` | `[PROJECT_ID]: 6. Document Revision History` |

## Example Usage

```
/cf-create-page /path/to/project/PROJ-12345_Feature_Description/test_plan
```

This creates:
1. Parent page: `PROJ-12345: Test Plan - Feature Description`
2. Child pages for each section under the parent
