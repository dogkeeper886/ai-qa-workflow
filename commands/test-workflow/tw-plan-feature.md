# Test Plan: New Feature (Type A)

Create a comprehensive test plan for new feature testing.

```
Use this command for new features with full documentation (HLD, designs, etc.)
This creates test_plan/README.md + test_plan/sections/*.md with 5-8 test scenarios.

{{input}}

## PURPOSE

Create a comprehensive test plan for new features:
- Business context and stakeholder alignment
- Feature definition and scope
- High-level test strategy and approach
- Test scenarios (5-8 scenarios typical)

AUDIENCE: Stakeholders, management, project team, Confluence reviewers

---

## INFORMATION GATHERING PRIORITY

**TIER 1 (Required - Must Have):**
1. **Confluence HLD** (`confluence/HLD_*.md`) - Core feature definition, acceptance criteria
2. **Main Ticket** (`00_Main_Task_*.md`) - Epic summary, business context
3. **README.md** - Problem summary, solution overview

**TIER 2 (Important - Should Have):**
4. **UX/UI Design Tickets** (`01_*UX*.md`, `01_*UI*.md`) - User interface specs
5. **Feature Request Ticket** (`01_*Feature_Request*.md`) - Original customer need
6. **API/Backend Tickets** (`01_*API*.md`, `01_*Backend*.md`) - Integration details

**TIER 3 (Optional - Nice to Have):**
7. **Figma/Design Links** - Visual mockups (if in Confluence docs)
8. **Feature Flag Tickets** (`01_*Feature_Flag*.md`) - Control mechanism
9. **Comments sections** - Additional context, team discussions

---

## STEP-BY-STEP WORKFLOW

### Step 1: Understand the Feature
Ask the user or review documentation to understand:
- What feature is being tested?
- What problem does it solve?
- What is the Epic/Story/Feature Request ID?

**Sources to check:**
- Jira Epic/Story tickets
- Confluence HLD (High-Level Design) documents
- Feature request tickets
- Product requirements documents

### Step 2: Identify Stakeholders
Determine who is involved:
- Who designed it? (UX Designer)
- Who implemented it? (Developers)
- Who requested it? (Product Owner, Customer)
- Who will test it? (QA Engineer)

### Step 3: Define Scope
Clarify what will and won't be tested:
- What behaviors are in scope?
- What is explicitly excluded?

### Step 4: Identify Test Operations
Determine how to test the feature:
- What user operations will trigger the feature?
- What test data is needed?
- What volumes should be tested? (small, medium, large)

### Step 5: Create Test Scenarios
Define high-level test scenarios (5-8 typical):
- Group related test activities together
- Each scenario becomes a Test Suite (TS-XX)
- Focus on WHAT to test, not HOW to test

---

## DECISION TREES: HANDLING MISSING INFORMATION

### No Confluence HLD Found
```
IF no HLD in confluence/ folder:
  1. Check Main Ticket description for technical details
  2. Check UX ticket for feature definition
  3. Check README.md for feature summary
  4. Ask user: "I don't see an HLD document. Can you provide:
     - Confluence HLD link, OR
     - Feature definition and acceptance criteria?"
  5. If user provides link: Use WebFetch to retrieve
  6. If user says "proceed without it":
     - Use ticket descriptions as primary source
     - Note in test plan: "HLD not available - based on ticket descriptions"
  7. Continue with available information
```

### Unclear Feature Scope
```
IF feature scope is ambiguous:
  1. Check HLD "In Scope" / "Out of Scope" sections
  2. Check acceptance criteria in Main Ticket
  3. Ask user specific clarifying questions
  4. Document assumptions clearly with "ASSUMPTION:" prefix
  5. Continue with documented assumptions
```

---

## COMMON SENSE GUIDELINES

1. **Don't Block on Minor Details** - Use "[TBD]" and continue
2. **Prioritize Actionable Information** - Focus on WHAT to test
3. **Make Reasonable Assumptions** - Document them clearly
4. **Be Specific in Test Scenarios** - "Threshold Testing (9, 10, 11 items)" not "Test various amounts"

---

## OUTPUT FORMAT

### File Structure

```
test_plan/
├── README.md                              # Index with metadata + linked TOC
└── sections/
    ├── 01_Project_Business_Context.md     # § 1.1-1.3
    ├── 02_Feature_Definition.md           # § 2.1-2.3
    ├── 03_Scope_Boundaries.md             # § 3.1-3.2
    ├── 04_Test_Strategy.md                # § 4.1-4.5 (includes scenarios table)
    ├── 05_References_Resources.md         # § 5
    └── 06_Revision_History.md             # § 6
```

### test_plan/README.md

```markdown
# Test Plan: [Feature Name] ([Epic ID])

**Test Plan Type:** New Feature Validation
**Test Plan Version:** 1.0
**Created:** [Date]
**Last Updated:** [Date]
**QA Engineer:** [Name]
**Epic:** [Link]
**Feature Request:** [Link]
**Target Release:** [Date]
**Feature Flag:** `[flag-name]` (if applicable)

---

## Test Plan Sections

1. [Project & Business Context](sections/01_Project_Business_Context.md)
2. [Feature Definition](sections/02_Feature_Definition.md)
3. [Scope & Boundaries](sections/03_Scope_Boundaries.md)
4. [Test Strategy](sections/04_Test_Strategy.md)
5. [References & Resources](sections/05_References_Resources.md)
6. [Revision History](sections/06_Revision_History.md)

---

## Quick Reference

- **Total Test Scenarios:** [N]
- **Estimated Test Cases:** [N]
```

### test_plan/sections/01_Project_Business_Context.md

```markdown
## 1. Project & Business Context
### 1.1 Product Overview
### 1.2 Business Value
### 1.3 Stakeholders
```

### test_plan/sections/02_Feature_Definition.md

```markdown
## 2. Feature Definition
### 2.1 Core Functionality
### 2.2 Feature Control
### 2.3 Non-Functional Requirements
```

### test_plan/sections/03_Scope_Boundaries.md

```markdown
## 3. Scope & Boundaries
### 3.1 In-Scope Testing
### 3.2 Out of Scope
```

### test_plan/sections/04_Test_Strategy.md

```markdown
## 4. Test Strategy
### 4.1 Test Levels
### 4.2 Test Types
### 4.3 Test Approach
### 4.4 Test Scenarios

| ID | Test Scenario | Focus | Est. Cases | Test Activities |
|----|---------------|-------|------------|-----------------|
| **TS-01** | [Name] | [Focus] | [N] | • [Activity 1]<br>• [Activity 2] |
| **TS-02** | [Name] | [Focus] | [N] | • [Activity 1]<br>• [Activity 2] |

**Total Test Coverage:**
- **[N] Test Suites**
- **[N] Test Cases** (estimated)

### 4.5 Test Data Setup (if applicable)
```

### test_plan/sections/05_References_Resources.md

```markdown
## 5. References & Resources
### 5.1 Design & Documentation
```

### test_plan/sections/06_Revision_History.md

```markdown
## 6. Document Revision History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | YYYY-MM-DD | [Name] | Initial test plan |
```

---

## NEXT STEP

After creating the test plan, run `/tw-plan-review` to verify coverage before creating test cases.

```
┌─────────────────────────────────────────────────────────────────┐
│                    WORKFLOW CONTINUATION                         │
└─────────────────────────────────────────────────────────────────┘

/tw-plan-init
    └── Detected Type A: New Feature
                              ↓
/tw-plan-feature  ◄── YOU ARE HERE
    └── Creates test_plan/README.md + test_plan/sections/*.md
                              ↓
/tw-plan-review
    └── Reviews test plan for gaps, generates coverage matrix
                              ↓
/tw-case-init
    └── Routes to appropriate test case workflow
```
```
