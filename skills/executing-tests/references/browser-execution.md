# Browser Execution Reference

## Setup

### Step 1: Read Test Case from TestLink

- Use `testlink-mcp:read_test_case` with test case ID
- Extract: name, summary, preconditions, steps
- Understand test objective and expected behavior

### Step 2: Browser Initialization

```
- Navigate to application URL using playwright-mcp:browser_navigate
- Resize browser to minimum 1280px width if needed
- Take initial snapshot using playwright-mcp:browser_snapshot
- Wait for page to fully load
```

### Step 3: Authentication (if required)

```
- Locate login form elements via snapshot
- Enter credentials using playwright-mcp:browser_type
- Click login button using playwright-mcp:browser_click
- Wait for authentication to complete
- Verify successful login (check for dashboard/main page)
```

---

## Browser MCP Tools

| Tool | Purpose |
|------|---------|
| `playwright-mcp:browser_navigate` | Navigate to URL |
| `playwright-mcp:browser_snapshot` | Capture page state/structure |
| `playwright-mcp:browser_click` | Click buttons/elements |
| `playwright-mcp:browser_type` | Enter text in fields |
| `playwright-mcp:browser_select_option` | Select dropdown options |
| `playwright-mcp:browser_hover` | Hover over elements |
| `playwright-mcp:browser_press_key` | Press keyboard keys |
| `playwright-mcp:browser_wait_for` | Wait for text/elements/time |
| `playwright-mcp:browser_resize` | Resize browser window |
| `playwright-mcp:browser_take_screenshot` | Capture screenshots |
| `playwright-mcp:browser_console_messages` | Get console messages |
| `playwright-mcp:browser_network_requests` | Get network requests |

---

## Step Execution Pattern

For each test step:

```
1. Read step action and expected result
2. Take snapshot to understand current page state
3. Locate UI elements using snapshot references
4. Perform the action (click, type, select, etc.)
5. Wait for action to complete
6. Take new snapshot to verify result
7. Compare actual result with expected result
8. Document pass/fail status
9. Take screenshot at key verification points
```

---

## Element Interaction Patterns

**Clicking Elements:**
```
- Take browser_snapshot to get element reference
- Use browser_click with element ref
- Wait for action to complete
- Verify expected change occurred
```

**Typing Text:**
```
- Locate textbox/input field via snapshot
- Use browser_type with element ref and text
- Verify text was entered correctly
```

**Selecting Options:**
```
- Locate dropdown/combobox
- Use browser_select_option with element ref and values
- Verify selection was applied
```

---

## Verification Strategies

**Verify Page Display:**
- Check URL matches expected path
- Verify page title or heading
- Confirm key elements are visible

**Verify Form Fields:**
- Check field values match expected input
- Verify validation messages (if any)

**Verify Table/List Content:**
- Locate table/list in snapshot
- Find target row/item
- Verify column values match expected

**Verify Messages/Notifications:**
- Look for success/error notifications
- Verify message text matches expected

---

## Common Issues

| Issue | Solution |
|-------|----------|
| "Screen width too low" warning | Use browser_resize to set width to 1280px |
| Element not found in snapshot | Wait for page load, take new snapshot |
| Form validation errors | Check field requirements, clear and re-enter |
| Login fails | Verify credentials, check for error messages |
| Expected result doesn't match | Document discrepancy, take screenshot, continue |

---

## Best Practices

- ✅ Resize browser to at least 1280px width
- ✅ Wait for page loads between actions (2-3 seconds)
- ✅ Take snapshots frequently to understand page state
- ✅ Always take snapshot before interacting with elements
- ✅ Execute steps in sequential order
- ✅ Verify each step before proceeding to next
- ✅ Document actual vs expected results
- ✅ Capture screenshots at key verification points
