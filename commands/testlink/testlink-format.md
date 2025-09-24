# TestLink Format

```
Format this text for TestLink with proper HTML formatting and external ID format:

{{input}}

Critical Requirements:
- External ID: Use PROJECT- prefix (e.g., "PROJECT-12345", not "12345")
- Summary: Use <p> tags with <strong> for emphasis
- Preconditions: Format as <ul><li>item</li></ul> lists
- Actions: Use <p> for main action, <ul><li> for alternatives, <ol><li> for ordered steps
- Expected Results: Use <p> with <ul><li> or <br>• for multi-line items

HTML Formatting Examples:
- Summary: "<p>Verify that users can <strong>perform action</strong> and validate behavior</p>"
- Preconditions: "<ul><li>Admin access with Advanced Permissions &gt; Feature &gt; Setting</li><li>Required configuration: Parameter &quot;value&quot;</li></ul>"
- Actions with sub-steps: "<p>Click button and click \"<strong>Edit</strong>\"</p><ul><li>Alternatively, click name then click \"<strong>Configure</strong>\"</li></ul>"
- Actions with ordered steps: "<p>Navigate to page and click \"<strong><em>Edit</em></strong>\"</p><ol><li><em>Use Configure button method</em></li><li><em>Or access via direct URL</em></li></ol>"
- Expected Results: "<p>Action completes successfully</p><ul><li>Success notification appears</li><li>Settings persist after save</li></ul>"
- Alternative Expected Results: "User can perform action successfully<br>• First validation point<br>• Second validation point<br>• Third validation point"

HTML Entities Required:
- &gt; for >, &lt; for <, &quot; for ", &amp; for &

HTML Tags Available:
- <p> for paragraphs, <strong> for bold, <em> for italic, <strong><em> for bold italic
- <ul><li> for bullet lists, <ol><li> for numbered lists
- <br> for line breaks

Required Step Fields:
- step_number: String (e.g., "1", "2", "3")
- actions: String (what to do)
- expected_results: String (what should happen)
- active: Integer (always use 1)
- execution_type: Integer (1 = manual, 2 = automated)

Common Mistakes to Avoid:
- Don't use \n for line breaks (shows as literal 'n')
- Don't forget HTML entities for special characters
- Don't use numeric-only external IDs
- Don't skip required step fields

Success Criteria:
✅ External ID includes "PROJECT-" prefix
✅ Preconditions use <ul><li> HTML format
✅ Multi-line expected results use <br>• format
✅ All special characters use HTML entities
✅ All required step fields included
✅ All formatting follows HTML standards
```
