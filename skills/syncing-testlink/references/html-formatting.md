# TestLink HTML Formatting Reference

## Formatting Rules

### Summary Formatting
- Wrap in `<p>` tags
- Use `<strong>` for key actions and important terms

**Example:**
```html
<p>Verify that users can <strong>perform action</strong> and validate behavior</p>
```

### Preconditions Formatting
- Convert bullet points to `<ul><li>` lists
- Each item in separate `<li>` tag

**Example:**
```html
<ul>
  <li>Admin access with Advanced Permissions &gt; Feature &gt; Setting</li>
  <li>Required configuration: Parameter &quot;value&quot;</li>
</ul>
```

### Actions Formatting
- Main action in `<p>` tags
- Use `<strong>` for buttons, menus, field names
- Use `<em>` for alternatives or clarifications
- Sub-steps in `<ul><li>` or `<ol><li>` format

**Examples:**
```html
<p>Click button and click &quot;<strong>Edit</strong>&quot;</p>
<ul><li>Alternatively, click name then click &quot;<strong>Configure</strong>&quot;</li></ul>
```

```html
<p>Navigate to page and click &quot;<strong><em>Edit</em></strong>&quot;</p>
<ol><li><em>Use Configure button method</em></li><li><em>Or access via direct URL</em></li></ol>
```

### Expected Results Formatting
- Simple results: Use `<br>•` for multi-line items
- Complex results: Use `<p>` with `<ul><li>` for validation lists

**Simple:**
```
User can perform action successfully<br>• First validation point<br>• Second validation point
```

**Complex:**
```html
<p>Action completes successfully</p>
<ul>
  <li>Success notification appears</li>
  <li>Settings persist after save</li>
  <li>User redirected to correct page</li>
</ul>
```

---

## HTML Entities Required

| Character | Entity |
|-----------|--------|
| `>` | `&gt;` |
| `<` | `&lt;` |
| `"` | `&quot;` |
| `&` | `&amp;` |
| `'` | `&apos;` |
| non-breaking space | `&nbsp;` |

---

## HTML Tags Available

| Tag | Use |
|-----|-----|
| `<p>` | Paragraphs |
| `<strong>` | Bold/important text (UI elements, buttons, fields) |
| `<em>` | Italic/alternative text |
| `<strong><em>` | Bold italic/critical emphasis |
| `<ul><li>` | Bullet lists |
| `<ol><li>` | Numbered lists |
| `<br>` | Line breaks |

---

## Common Mistakes to Avoid

- ❌ Don't use `\n` for line breaks (shows as literal 'n')
- ❌ Don't forget HTML entities for special characters
- ❌ Don't use numeric-only external IDs
- ❌ Don't skip required step fields
- ❌ Don't mix HTML and plain text formatting

---

## Best Practices

- ✅ Use `<strong>` for UI elements like buttons, menus, fields
- ✅ Use `<em>` for alternatives or clarifications
- ✅ Use `<br>•` for simple multi-line expected results
- ✅ Use `<ul><li>` for complex validation lists
- ✅ Apply HTML entities for all special characters
- ✅ Keep actions clear and concise with proper formatting
- ✅ Make expected results specific and measurable
