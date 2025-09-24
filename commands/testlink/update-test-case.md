# Update TestLink Test Case

```
Update test case {{testcaseId}} in TestLink with proper HTML formatting and TestLink compliance.

Input Format:
- Test Case ID: Use Project prefix (e.g., "ABC-12345")
- Test Case Name
- Summary/Test Objective  
- Pre-conditions (if any)
- Test Steps with Actions and Expected Results

HTML Formatting Applied Automatically:
- Summary: <p> tags with <strong> for emphasis on key actions
- Preconditions: <ul><li> lists for each requirement
- Actions: <p> for main action, <ul><li> for alternatives, <ol><li> for ordered steps
- Expected Results: <br>• format for multi-line items or <ul><li> for complex validations

HTML Formatting Examples:
- Summary: "<p>Verify that users can <strong>perform action</strong> and validate behavior</p>"
- Preconditions: "<ul><li>Admin access with Advanced Permissions &gt; Feature &gt; Setting</li><li>Required configuration: Parameter &quot;value&quot;</li></ul>"
- Actions with alternatives: "<p>Click button and click &quot;<strong>Edit</strong>&quot;</p><ul><li>Alternatively, click name then click &quot;<strong>Configure</strong>&quot;</li></ul>"
- Actions with ordered steps: "<p>Navigate to page and click &quot;<strong><em>Edit</em></strong>&quot;</p><ol><li><em>Use Configure button method</em></li><li><em>Or access via direct URL</em></li></ol>"
- Expected Results (simple): "User can perform action successfully<br>• First validation point<br>• Second validation point"
- Expected Results (complex): "<p>Action completes successfully</p><ul><li>Success notification appears</li><li>Settings persist after save</li><li>User redirected to correct page</li></ul>"

HTML Entities Applied:
- &gt; for >, &lt; for <, &quot; for ", &amp; for &

Formatting Options:
- <strong> for important actions, buttons, field names
- <em> for alternative methods or notes
- <strong><em> for critical emphasis
- <ul><li> for bullet points in actions or results
- <ol><li> for numbered sequences
- <br>• for simple multi-line expected results

Required Step Fields (handled automatically):
- step_number: String ("1", "2", "3", etc.)
- actions: String with proper HTML formatting
- expected_results: String with proper HTML formatting
- active: Integer (always 1)
- execution_type: Integer (1 = manual, 2 = automated)

Best Practices:
✅ Use <strong> for UI elements like buttons, menus, fields
✅ Use <em> for alternatives or clarifications
✅ Use <br>• for simple multi-line expected results
✅ Use <ul><li> for complex validation lists
✅ Apply HTML entities for all special characters
✅ Keep actions clear and concise with proper formatting
✅ Make expected results specific and measurable
```