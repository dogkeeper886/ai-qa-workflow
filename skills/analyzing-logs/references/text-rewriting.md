# Text Rewriting Reference

## Purpose

Rewrite cryptic technical error messages and Robot Framework failure output into plain English that QA engineers and stakeholders can understand without deep technical knowledge.

---

## When to Rewrite

Rewrite failure messages when they contain:
- Stack traces and exception class names
- Internal variable names or memory addresses
- Framework-specific jargon
- Encoded or escaped characters
- Overly verbose technical output

---

## Rewriting Guidelines

### Keep the Core Meaning
- Preserve what actually failed
- Preserve what the expected vs actual behavior was
- Preserve any relevant values (URLs, file paths, data)

### Simplify Technical Jargon

| Technical | Plain English |
|-----------|---------------|
| `AssertionError: Expected: True but got: False` | "The test expected this to be enabled, but it was disabled" |
| `ConnectionRefusedError: [Errno 111] Connection refused` | "Could not connect to the server — it may be down or unreachable" |
| `TimeoutException: Element not clickable after 30s` | "The button/element didn't appear within 30 seconds — page may not have loaded" |
| `NoSuchElementException: Unable to locate element` | "The expected UI element was not found on the page" |
| `AttributeError: 'NoneType' object has no attribute 'text'` | "A required element was missing — the page returned no data for this field" |

---

## Format for Rewritten Messages

```
Original: [paste original error message]

Plain English: [rewritten explanation]

What this means: [what the test was trying to verify]
Why it failed: [likely cause]
```

---

## Example

**Original:**
```
FAIL: AssertionError: Expected '<status>active</status>' to contain 'enabled'
    at test_user_session.robot:142
    ...
```

**Rewritten:**
```
Plain English: The user session status shows 'active' but the test expected it to show 'enabled'.

What this means: The test was checking that after configuring the session, the status field updates to 'enabled'.
Why it failed: The status text in the API response uses a different value than what the test expects — this may be a test update needed or an API change.
```

---

## Batch Rewriting for Reports

When including rewritten messages in the analysis report:

1. Only rewrite messages that are unclear or cryptic
2. For simple, self-explanatory failures, keep as-is with brief context
3. Group similar failures — rewrite once, apply to all in group
4. Focus on actionable language: what happened, what to check
