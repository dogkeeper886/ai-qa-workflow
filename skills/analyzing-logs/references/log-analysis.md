# Robot Framework Log Analysis Reference

## Supported Log Formats

| Format | Description |
|--------|-------------|
| XML output (`output.xml`) | Machine-readable Robot Framework output |
| HTML log (`log.html`) | Human-readable Robot Framework log |
| Directory | Folder containing multiple output/log files |

---

## Step 1: Identify Log Format

1. Check input for file path or directory
2. Determine format:
   - `.xml` extension → XML output format
   - `.html` extension → HTML log format
   - Directory → scan for `output.xml` or `log.html` files
3. Report what was found before proceeding

---

## Step 2: Extract Test Results from XML

For XML output files:

```
- Search for <testsuite> and </testsuite> tags (with line numbers)
- Extract: test case names, status (PASS/FAIL), failure messages
- Use Grep to search for specific patterns in large files
- Use Read with offset/limit for large files
```

Key XML patterns:
- `<test name="...">` - Test case boundary
- `<status status="PASS">` - Test passed
- `<status status="FAIL">` - Test failed
- `<msg level="FAIL">` - Failure message

---

## Step 3: Extract Test Results from HTML

For HTML log files:

```
- Search for window.output in HTML (Robot Framework stores results as JS object)
- Look for PASS/FAIL status markers
- Extract test names and failure messages from the JS data
```

---

## Step 4: Process Results

For each extracted test case:
- Record: test name, PASS/FAIL status, failure message (if any)
- Build a structured list of all test cases

---

## Step 5: Group Failures

Group failing tests by failure type/pattern:

```
Group 1: Connection failures
  - Tests that fail with "Connection refused" or "Timeout"
  - Likely cause: [environment issue]

Group 2: Assertion failures
  - Tests that fail with "Expected: X but got: Y"
  - Likely cause: [feature change or bug]

Group 3: Setup failures
  - Tests that fail in setup phase
  - Likely cause: [missing dependency or configuration]
```

---

## Output Format

```markdown
# Robot Framework Log Analysis Report

## Overview
- **Total Tests:** N
- **Passed:** N (XX%)
- **Failed:** N (XX%)
- **Skipped/Not Run:** N

## Test Results

| # | Test Name | Status | Failure Message |
|---|-----------|--------|-----------------|
| 1 | [Name] | PASS | - |
| 2 | [Name] | FAIL | [message] |

## Failure Analysis

### Group 1: [Failure Type]
**Tests affected:** N
**Root cause:** [Analysis]
**Suggested fix:** [Recommendation]

- [Test 1]: [specific failure message]
- [Test 2]: [specific failure message]

### Group 2: [Failure Type]
[same structure]

## Suggested Actions

1. [Priority action 1]
2. [Priority action 2]
```

---

## Key Tools for Analysis

- **Grep**: Search for specific patterns in large files
- **Read**: Examine file contents with offset/limit for large files
- Focus on: test case names and PASS/FAIL results, failure messages, patterns

## Success Factors

- Start broad (get counts), then narrow focus based on patterns
- Use appropriate tools for file size and complexity
- Focus on actual findings rather than theoretical gaps
- List specific test cases found with names and results
- Adapt presentation style based on user preferences (lists vs paragraphs)
