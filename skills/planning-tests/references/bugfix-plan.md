# Bug Fix Test Plan Reference (Type B)

## Purpose

Create a focused test plan for bug fixes:
- Problem context and reproduction steps
- Fix verification scope
- Edge case prevention
- Focused test scenarios (2-4 typical)

AUDIENCE: QA Engineers, Developers, Product Team

---

## Information Gathering Priority

**PRIMARY SOURCES (Required):**
1. **Bug Ticket Comments** (`00_Main_Task_*.md` comments section) - Reproduction steps, customer reports
2. **Main Ticket Description** - Problem statement, expected vs actual behavior
3. **README.md** - Problem summary synthesized by /receiving-tickets

**SECONDARY SOURCES (If Available):**
4. **Related Bug Tickets** - Similar issues, patterns, linked defects
5. **Developer Comments** - Fix approach, root cause analysis
6. **Confluence Docs** - If problem relates to documented feature

**NOTE:** Bug fixes typically do NOT have HLD, UX designs, or full stakeholder info. This is normal!

---

## Step-by-Step Workflow

### Step 1: Understand the Problem
Extract into template:
```markdown
### 1.1 Problem Overview
**Customer Issue:** [Brief description]
**Reported By:** [Customer name/ID or Internal reporter]
**Ticket Type:** Bug / Defect / Customer Issue
**Impact:** [Severity: Critical/High/Medium/Low]
**Frequency:** [Always/Intermittent/Edge case]
**Affected Users:** [All users/Specific role/Specific scenario]

**Problem Behavior:**
- **Expected:** [What should happen]
- **Actual:** [What currently happens]
- **Root Cause:** [If known from dev investigation]
```

### Step 2: Extract Reproduction Steps
```markdown
### 1.2 Reproduction Context

**Environment:** [Where problem occurs]
**Preconditions:** [State/data/configuration needed to reproduce]

**Steps to Reproduce:**
1. [Step 1 - extracted from comments]
2. [Step 2]
3. [Step 3]
**Result:** [What happens - the bug]

**Expected Result:** [What should happen instead]
**Current Workaround:** [If any - check comments]
```

### Step 3: Understand the Fix
- What code/component was changed?
- What is the fix approach?
- Are there related areas that might be affected?

### Step 4: Create Test Scenarios (2-4 focused)
```markdown
| ID | Test Scenario | Focus | Est. Cases | Test Activities |
|----|---------------|-------|------------|-----------------|
| **TS-01** | Defect Verification | Verify fix | 2-3 | • Exact reproduction steps<br>• Variations of reported scenario |
| **TS-02** | Regression Testing | Prevent breaks | 2-3 | • Related functionality<br>• Adjacent features |
| **TS-03** | Edge Cases & Prevention | Prevent recurrence | 2-4 | • Boundary values<br>• Large/small volumes |
```

---

## Decision Trees

### No Clear Reproduction Steps
```
IF no reproduction steps in bug ticket:
  1. Check all comments for "repro", "steps", "reproduce"
  2. Check README.md problem summary
  3. Check related bug tickets for similar patterns
  4. Ask user: "I don't see reproduction steps. Can you provide?"
  5. If user doesn't know: create general test approach
  6. Continue with broader test coverage
```

### No Fix Details
```
IF no fix approach documented:
  1. Check for linked code commits in ticket
  2. Check developer comments for technical details
  3. Make reasonable assumption based on component
  4. Create broad test coverage:
     - Test the reported problem (defect verification)
     - Test related areas (regression)
  5. Note in test plan: "Fix details not documented"
```

---

## Output Format

Save to `test_plan/README.md`:

```markdown
# Test Plan: [Bug Description] ([Bug Ticket ID])

**Test Plan Type:** Bug Fix Validation
**Test Plan Version:** 1.0
**Created:** [Date]
**QA Engineer:** [Name]
**Bug Ticket:** [TICKET-123](link)
**Severity:** [Critical/High/Medium/Low]

## 1. Problem Context

### 1.1 Problem Overview
### 1.2 Reproduction Context
### 1.3 Fix Summary
**Component:** [What was fixed]
**Fix Approach:** [How it was fixed]

## 2. Test Scope

### 2.1 Defect Verification
### 2.2 Regression Testing
### 2.3 Edge Case Coverage

## 3. Test Strategy

### 3.1 Test Approach

### 3.2 Test Scenarios

| ID | Test Scenario | Focus | Est. Cases | Test Activities |
|----|---------------|-------|------------|-----------------|
| **TS-01** | Defect Verification | Verify fix | 2-3 | • [Activities] |
| **TS-02** | Regression Testing | Prevent breaks | 2-3 | • [Activities] |
| **TS-03** | Edge Cases | Prevention | 2-4 | • [Activities] |

**Total:** [N] test scenarios, ~[N] test cases

## 4. References & Resources

## 5. Document Revision History
```
