# Test Plan: Bug Fix (Type B)

Create a focused test plan for bug fix validation.

```
Use this command for bug fixes, customer issues, and defects.
This creates a focused TEST_PLAN.md with 2-4 test scenarios.

{{input}}

## PURPOSE

Create a focused test plan for bug fixes:
- Problem context and reproduction steps
- Fix verification scope
- Edge case prevention
- Focused test scenarios (2-4 typical)

AUDIENCE: QA Engineers, Developers, Product Team

---

## INFORMATION GATHERING PRIORITY

**PRIMARY SOURCES (Required):**
1. **Bug Ticket Comments** (`00_Main_Task_*.md` comments section) - Reproduction steps, customer reports
2. **Main Ticket Description** - Problem statement, expected vs actual behavior
3. **README.md** - Problem summary synthesized by /jr-trace

**SECONDARY SOURCES (If Available):**
4. **Related Bug Tickets** - Similar issues, patterns, linked defects
5. **Developer Comments** - Fix approach, root cause analysis
6. **Confluence Docs** - If problem relates to documented feature

**NOTE:** Bug fixes typically do NOT have HLD, UX designs, or full stakeholder info. This is normal!

---

## STEP-BY-STEP WORKFLOW

### Step 1: Understand the Problem

**Questions to ask:**
- What is the customer-reported problem?
- What is expected behavior vs. actual behavior?
- What are the reproduction steps?
- What is the customer impact (severity, frequency)?
- What is the affected component/feature?

**Sources to check:**
- Main ticket description
- All comments (especially customer/reporter comments)
- README.md problem summary
- Related bug tickets

**Extract into template:**
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
- **Root Cause:** [If known from dev investigation - check comments]
```

### Step 2: Extract Reproduction Steps

**Questions to ask:**
- What exact steps reproduce the problem?
- What environment/conditions are needed?
- What test data is required?
- Are there workarounds?

**Sources to check:**
- Comments section (look for "Steps to reproduce", "Repro steps")
- Developer investigation notes
- Customer reports

**Extract into template:**
```markdown
### 1.2 Reproduction Context

**Environment:** [Where problem occurs - production, staging, specific version]
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

**Questions to ask:**
- What code/component was changed?
- What is the fix approach?
- Are there related areas that might be affected?
- When is/was the fix deployed?

**Sources to check:**
- Developer comments
- Linked code commits (if mentioned)
- Related tickets
- Status/resolution comments

### Step 4: Define Test Scope (Bug Fix Focus)

For bug fixes, focus on THREE areas:

**4.1 Defect Verification**
- Verify original problem is fixed
- Test exact reproduction steps
- Confirm expected behavior now occurs
- Validate in same environment/conditions as bug report

**4.2 Regression Testing**
- Test related functionality
- Verify fix didn't break other features
- Test adjacent code paths

**4.3 Edge Case Prevention**
- Test boundary conditions
- Test with different data volumes
- Test in different user contexts
- Prevent similar issues in related areas

### Step 5: Create Test Scenarios (Bug Fix)

For bug fixes, typically create 2-4 focused scenarios:

```markdown
| ID | Test Scenario | Focus | Est. Cases | Test Activities |
|----|---------------|-------|------------|-----------------|
| **TS-01** | Defect Verification | Verify fix | 2-3 | • Exact reproduction steps<br>• Variations of reported scenario<br>• Confirm expected behavior |
| **TS-02** | Regression Testing | Prevent breaks | 2-3 | • Related functionality<br>• Adjacent features |
| **TS-03** | Edge Cases & Prevention | Prevent recurrence | 2-4 | • Boundary values<br>• Large/small volumes<br>• Error conditions |
```

**Note:** Bug fix test plans are typically SHORTER than feature test plans. Focus on quality over quantity.

---

## DECISION TREES: HANDLING MISSING INFORMATION

### No Clear Reproduction Steps
```
IF no reproduction steps in bug ticket:
  1. Check all comments thoroughly for "repro", "steps", "reproduce"
  2. Check README.md problem summary
  3. Check related bug tickets for similar patterns
  4. Ask user: "I don't see reproduction steps. Can you provide:
     - Steps to reproduce this issue, OR
     - Description of when/how the problem occurs?"
  5. If user doesn't know:
     - Note: "Reproduction steps not documented"
     - Create general test approach:
       • TS-01: Basic functionality test (ensure component works)
       • TS-02: Edge case coverage (prevent related issues)
  6. Continue with broader test coverage
```

### No Fix Details
```
IF no fix approach documented:
  1. Check for linked code commits in ticket
  2. Check developer comments for technical details
  3. Check ticket status changes for clues
  4. Make reasonable assumption based on component:
     "Fix applied to [component mentioned in ticket title/description]"
  5. Create broad test coverage:
     - Test the reported problem (defect verification)
     - Test related areas (regression)
  6. Note in test plan: "Fix details not documented - created comprehensive test coverage"
  7. Continue without blocking
```

---

## OUTPUT FORMAT

```markdown
# Test Plan: [Bug Description] ([Bug Ticket ID])

**Test Plan Type:** Bug Fix Validation
**Test Plan Version:** 1.0
**Created:** [Date]
**Last Updated:** [Date]
**QA Engineer:** [Name]
**Bug Ticket:** [TICKET-123](link)
**Related Tickets:** [Links to related bugs if any]
**Target Fix Version:** [Version]
**Severity:** [Critical/High/Medium/Low]

## 1. Problem Context

### 1.1 Problem Overview
**Customer Issue:** [Brief description]
**Reported By:** [Customer/User identifier]
**Impact:** [Who is affected and how]
**Frequency:** [Always/Intermittent/Edge case]

**Problem Behavior:**
- **Expected:** [What should happen]
- **Actual:** [What currently happens]
- **Root Cause:** [If known]

### 1.2 Reproduction Context
**Environment:** [Where problem occurs]
**Preconditions:** [Setup needed to reproduce]

**Steps to Reproduce:**
1. [Step 1]
2. [Step 2]
3. [Step 3]

**Expected Result:** [Correct behavior]
**Current Workaround:** [If any]

### 1.3 Fix Summary
**Component:** [What was fixed]
**Fix Approach:** [How it was fixed]
**Code Changes:** [Link to PR/commit or "Not documented"]
**Fix Version:** [When deployed/planned]

## 2. Test Scope

### 2.1 Defect Verification
[Tests to verify the original problem is fixed]

### 2.2 Regression Testing
[Tests to verify fix didn't break other features]

### 2.3 Edge Case Coverage
[Tests to prevent similar issues]

## 3. Test Strategy

### 3.1 Test Approach
**Test Environment:** [QA/Staging environment details]
**Test Focus:** Defect verification, regression, edge cases

### 3.2 Test Scenarios

| ID | Test Scenario | Focus | Est. Cases | Test Activities |
|----|---------------|-------|------------|-----------------|
| **TS-01** | Defect Verification | Verify fix | 2-3 | • [Activities] |
| **TS-02** | Regression Testing | Prevent breaks | 2-3 | • [Activities] |
| **TS-03** | Edge Cases | Prevention | 2-4 | • [Activities] |

**Total:** [N] test scenarios, ~[N] test cases

## 4. References & Resources

| Resource | Link |
|----------|------|
| **Bug Ticket** | [Link] |
| **Related Bugs** | [Links] |
| **Component Documentation** | [If available] |

## 5. Document Revision History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | YYYY-MM-DD | [Name] | Initial bug fix test plan |
```

---

## NEXT STEP

After creating the test plan, run `/tw-plan-review` to verify coverage.

```
┌─────────────────────────────────────────────────────────────────┐
│                    WORKFLOW CONTINUATION                         │
└─────────────────────────────────────────────────────────────────┘

/tw-plan-init
    └── Detected Type B: Bug Fix
                              ↓
/tw-plan-bugfix  ◄── YOU ARE HERE
    └── Creates focused test_plan/README.md
                              ↓
/tw-plan-review
    └── Reviews test plan for completeness
                              ↓
/tw-case-init
    └── Routes to /tw-case-bugfix
```
```
