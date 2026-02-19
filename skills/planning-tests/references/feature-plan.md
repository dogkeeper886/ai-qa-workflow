# Feature Test Plan Reference (Type A)

## Purpose

Create a comprehensive test plan for new features:
- Business context and stakeholder alignment
- Feature definition and scope
- High-level test strategy and approach
- Test scenarios (5-8 scenarios typical)

AUDIENCE: Stakeholders, management, project team, Confluence reviewers

---

## Information Gathering Priority

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

## Step-by-Step Workflow

### Step 1: Understand the Feature
- What feature is being tested?
- What problem does it solve?
- What is the Epic/Story/Feature Request ID?

### Step 2: Identify Stakeholders
- Who designed it? (UX Designer)
- Who implemented it? (Developers)
- Who requested it? (Product Owner, Customer)
- Who will test it? (QA Engineer)

### Step 3: Define Scope
- What behaviors are in scope?
- What is explicitly excluded?

### Step 4: Identify Test Operations
- What user operations will trigger the feature?
- What test data is needed?
- What volumes should be tested? (small, medium, large)

### Step 5: Create Test Scenarios
- Group related test activities together
- Each scenario becomes a Test Suite (TS-XX)
- Focus on WHAT to test, not HOW to test
- Target 5-8 scenarios for features

---

## Decision Trees

### No Confluence HLD Found
```
IF no HLD in confluence/ folder:
  1. Check Main Ticket description for technical details
  2. Check UX ticket for feature definition
  3. Check README.md for feature summary
  4. Ask user: "I don't see an HLD document. Can you provide:
     - Confluence HLD link, OR
     - Feature definition and acceptance criteria?"
  5. Continue with available information
  6. Note in test plan: "HLD not available - based on ticket descriptions"
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

## Output Format

Save to `test_plan/README.md`:

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

## 1. Project & Business Context
### 1.1 Product Overview
### 1.2 Business Value
### 1.3 Stakeholders

## 2. Feature Definition
### 2.1 Core Functionality
### 2.2 Feature Control
### 2.3 Non-Functional Requirements

## 3. Scope & Boundaries
### 3.1 In-Scope Testing
### 3.2 Out of Scope

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

## 5. References & Resources
### 5.1 Design & Documentation

## 6. Document Revision History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | YYYY-MM-DD | [Name] | Initial test plan |
```

---

## Common Sense Guidelines

1. **Don't Block on Minor Details** - Use "[TBD]" and continue
2. **Prioritize Actionable Information** - Focus on WHAT to test
3. **Make Reasonable Assumptions** - Document them clearly
4. **Be Specific in Test Scenarios** - "Threshold Testing (9, 10, 11 items)" not "Test various amounts"
