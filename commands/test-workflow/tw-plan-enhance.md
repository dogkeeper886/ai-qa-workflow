# Test Plan: Enhancement (Type C)

Create a test plan for enhancement/improvement testing.

```
Use this command for enhancements and improvements to existing features.
This creates test_plan/README.md + test_plan/sections/*.md with 4-6 test scenarios.

{{input}}

## PURPOSE

Create a hybrid test plan for enhancements:
- Enhancement context and changes
- New/changed functionality validation
- Integration impact assessment
- Moderate test scenarios (4-6 typical)

AUDIENCE: QA Engineers, Developers, Product Team

---

## INFORMATION GATHERING PRIORITY

**PRIMARY SOURCES:**
1. **Enhancement Ticket** (`00_Main_Task_*.md`) - What's being improved
2. **README.md** - Enhancement summary
3. **Confluence Docs** (if any) - Enhancement specs

**SECONDARY SOURCES:**
4. **Original Feature Docs** - Existing functionality documentation
5. **Related Tickets** - Original feature implementation
6. **Comments** - Enhancement rationale, design decisions

---

## HYBRID APPROACH

Enhancements require testing BOTH:
- **New/Changed Functionality** → Use Type A approach (feature testing)
- **Existing Functionality Impact** → Use Type B approach (regression testing)

---

## STEP-BY-STEP WORKFLOW

### Step 1: Understand the Enhancement

**Questions to ask:**
- What existing feature is being enhanced?
- What is new or changed?
- Why is this enhancement needed?
- What is the expected impact on users?

**Extract into template:**
```markdown
### 1.1 Enhancement Overview
**What's Being Enhanced:** [Existing feature name]
**Enhancement Summary:** [What's changing/being added]
**Business Value:** [Why this enhancement]
**Requested By:** [Customer/Internal]
```

### Step 2: Identify What's New vs Changed

**Questions to ask:**
- What behaviors are completely new?
- What existing behaviors are modified?
- What stays the same?
- What configuration options changed?

**Extract into template:**
```markdown
### 2.1 New/Changed Functionality
**What's New:**
- [New behavior 1]
- [New behavior 2]

**What's Changed:**
- [Changed behavior 1]
- [Changed behavior 2]

**What's Unchanged:**
- [Existing behavior 1]
- [Existing behavior 2]
```

### Step 3: Assess Integration Impact

**Questions to ask:**
- What components interact with this feature?
- What API changes are involved?
- What downstream effects might occur?
- What backward compatibility concerns exist?

### Step 4: Define Test Scope

**Enhancement Validation:**
- Test new functionality works as specified
- Test changed functionality behaves correctly
- Test configuration changes are applied

**Integration Impact:**
- Test component interactions
- Test API compatibility
- Test backward compatibility

**Regression Testing:**
- Test unchanged functionality still works
- Test adjacent features not affected

### Step 5: Create Test Scenarios

For enhancements, typically create 4-6 scenarios:

```markdown
| ID | Test Scenario | Focus | Est. Cases | Test Activities |
|----|---------------|-------|------------|-----------------|
| **TS-01** | Enhancement Verification | New behavior | 4-6 | • New functionality<br>• Changed behavior |
| **TS-02** | Configuration Changes | Settings | 2-4 | • New options<br>• Migration |
| **TS-03** | Integration Impact | Component interactions | 2-4 | • API changes<br>• Dependencies |
| **TS-04** | Backward Compatibility | Existing behavior | 2-3 | • Old workflows<br>• Data migration |
```

**Scenario organization note:** When the enhancement is substantial
(adding new user workflows), apply the user-journey methodology from
`/tw-plan-feature` Step 5 to organize scenarios around user journeys
rather than technical components.

---

## DECISION TREES: HANDLING MISSING INFORMATION

### No Original Feature Documentation
```
IF original feature docs not available:
  1. Check README.md for feature summary
  2. Check related tickets for context
  3. Ask user: "Can you describe the existing functionality being enhanced?"
  4. Create test plan based on enhancement ticket + user input
  5. Note: "Original feature documentation not available"
```

### Unclear Enhancement Scope
```
IF enhancement scope is ambiguous:
  1. Check enhancement ticket acceptance criteria
  2. Check for design documents
  3. Ask user specific questions:
     - "What specific behaviors are changing?"
     - "What should remain unchanged?"
  4. Document assumptions clearly
```

---

## OUTPUT FORMAT

### File Structure

```
test_plan/
├── README.md                              # Index with metadata + linked TOC
└── sections/
    ├── 01_Enhancement_Context.md          # § 1.1-1.2
    ├── 02_Enhancement_Definition.md       # § 2.1-2.2
    ├── 03_Test_Scope.md                   # § 3.1-3.3
    ├── 04_Test_Strategy.md                # § 4.1-4.2 (includes scenarios table)
    ├── 05_References_Resources.md         # § 5
    └── 06_Revision_History.md             # § 6
```

### test_plan/README.md

```markdown
# Test Plan: [Enhancement Name] ([Ticket ID])

**Test Plan Type:** Enhancement Validation
**Test Plan Version:** 1.0
**Created:** [Date]
**Last Updated:** [Date]
**QA Engineer:** [Name]
**Enhancement Ticket:** [TICKET-123](link)
**Target Release:** [Date]
**Feature Flag:** `[flag-name]` (if applicable)

---

## Test Plan Sections

1. [Enhancement Context](sections/01_Enhancement_Context.md)
2. [Enhancement Definition](sections/02_Enhancement_Definition.md)
3. [Test Scope](sections/03_Test_Scope.md)
4. [Test Strategy](sections/04_Test_Strategy.md)
5. [References & Resources](sections/05_References_Resources.md)
6. [Revision History](sections/06_Revision_History.md)

---

## Quick Reference

- **Total Test Scenarios:** [N]
- **Estimated Test Cases:** [N]
```

### test_plan/sections/01_Enhancement_Context.md

```markdown
## 1. Enhancement Context

### 1.1 Enhancement Overview
**What's Being Enhanced:** [Existing feature being improved]
**Enhancement Summary:** [What's changing/being added]
**Business Value:** [Why this enhancement]

### 1.2 Stakeholders
[Key people - may be limited compared to new features]
```

### test_plan/sections/02_Enhancement_Definition.md

```markdown
## 2. Enhancement Definition

### 2.1 New/Changed Functionality
**What's New:**
- [New behavior 1]
- [New behavior 2]

**What's Changed:**
- [Changed behavior 1]
- [Changed behavior 2]

### 2.2 Integration Impact
**Affected Components:**
- [Component 1]
- [Component 2]

**API Changes:**
- [Change 1]
- [Change 2]
```

### test_plan/sections/03_Test_Scope.md

```markdown
## 3. Test Scope

### 3.1 Enhancement Validation
[Tests for new/changed functionality]

### 3.2 Integration Impact
[Tests for component interactions]

### 3.3 Backward Compatibility
[Tests for existing functionality]
```

### test_plan/sections/04_Test_Strategy.md

```markdown
## 4. Test Strategy

### 4.1 Test Approach
**Focus:** Validate enhancement works as specified + no regression

### 4.2 Test Scenarios

| ID | Test Scenario | Focus | Est. Cases | Test Activities |
|----|---------------|-------|------------|-----------------|
| **TS-01** | Enhancement Verification | New/changed behavior | 4-6 | • [Activities] |
| **TS-02** | Configuration Changes | Settings | 2-4 | • [Activities] |
| **TS-03** | Integration Impact | Component interactions | 2-4 | • [Activities] |
| **TS-04** | Backward Compatibility | Existing behavior | 2-3 | • [Activities] |

**Total:** [N] test scenarios, ~[N] test cases
```

### test_plan/sections/05_References_Resources.md

```markdown
## 5. References & Resources

| Resource | Link |
|----------|------|
| **Enhancement Ticket** | [Link] |
| **Original Feature Documentation** | [Link if available] |
| **Related Tickets** | [Links] |
```

### test_plan/sections/06_Revision_History.md

```markdown
## 6. Document Revision History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | YYYY-MM-DD | [Name] | Initial enhancement test plan |
```

---

## NEXT STEP

After creating the test plan, run `/tw-plan-review` to verify coverage.

```
┌─────────────────────────────────────────────────────────────────┐
│                    WORKFLOW CONTINUATION                         │
└─────────────────────────────────────────────────────────────────┘

/tw-plan-init
    └── Detected Type C: Enhancement
                              ↓
/tw-plan-enhance  ◄── YOU ARE HERE
    └── Creates test_plan/README.md + test_plan/sections/*.md
                              ↓
/tw-plan-review
    └── Reviews test plan for gaps
                              ↓
/tw-case-init
    └── Routes to /tw-case-enhance
```
```
