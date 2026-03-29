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

### Step 2.5: Visual Baseline Check

Before assessing impact, verify the current UI for the area being enhanced.

**Ask the user:** "Can I open the browser to see the current state of the feature being enhanced?"

```
IF live environment available:
  → Open browser and navigate to the affected UI area
  → Capture screenshots of the CURRENT state (before enhancement)
  → This becomes the baseline for "what changed" verification
  → Save to test_plan/visual_baseline/

IF wireframes/mockups exist in HLD:
  → Review embedded images to understand the target state
  → Compare current vs target to identify visual changes

IF neither available:
  → Flag: "No visual baseline captured — verify UI changes manually during test case design"
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

## BEST PRACTICE SECTIONS (Standard Profile)

After finalizing test scenarios (Step 5), add the following sections. These
align with what `/tw-plan-review` checks at the Standard profile level.

### Step 6: Coverage Matrix

For each test scenario, identify which coverage aspects it addresses.
Include only aspects relevant to the enhancement — omit aspects that do
not apply.

| Coverage Aspect | Description |
|-----------------|-------------|
| UI Configuration | Tests that configure via user interface |
| API Configuration | Tests that configure via API |
| Data Flow | How data moves through the system |
| Error Handling | Invalid inputs, edge cases, failures |
| Backward Compatibility | Existing functionality still works |
| Client/End-user Validation | End-to-end user scenarios |
| Edge Cases | Boundary conditions, empty/max states |

Output an ASCII coverage matrix in `04_Test_Strategy.md` after the
scenarios table.

### Step 7: Hybrid Depth Strategy

If the enhancement has variants:

1. **Identify the representative case** — the scenario covering the most
   coverage aspects. This gets deep testing.
2. **Identify variants** — scenarios differing by only 1-2 parameters.
   These get lightweight validation only.
3. Document which scenarios are "deep" vs "wide" in `04_Test_Strategy.md`.

### Step 8: Requirements Traceability

Map each requirement/acceptance criterion to test scenarios:

```
1. List requirements from:
   - Enhancement Definition (§ 2.1-2.2)
   - Test Scope (§ 3.1-3.3)
   - Enhancement ticket acceptance criteria
2. For each requirement, note which scenario(s) cover it
3. Flag uncovered requirements
```

Add a traceability table to `04_Test_Strategy.md`:

```markdown
### Requirements Traceability

| Requirement | Source | Covered By |
|-------------|--------|------------|
| [Requirement 1] | Enhancement ticket AC #1 | TS-01 |
| [Requirement 2] | § 2.1 New Functionality | TS-01, TS-02 |
| [Requirement 3] | § 3.3 Backward Compat | TS-04 |
```

### Step 9: Entry/Exit Criteria

Add to `04_Test_Strategy.md`:

```markdown
### Entry/Exit Criteria

**Entry Criteria:**
- [ ] Enhancement deployed to test environment
- [ ] Existing feature baseline verified
- [ ] Test data provisioned

**Exit Criteria:**
- [ ] 100% P0 test cases pass
- [ ] ≥90% P1 test cases pass
- [ ] No regression in existing functionality
```

### Step 10: Risk Assessment (Lite)

Flag only high-risk scenarios. For enhancements, pay special attention to:
- Backward compatibility risks
- Integration breakage risks
- Data migration risks

Add a brief risk note to `04_Test_Strategy.md`:

```markdown
### Risk Assessment

| Scenario | Risk Level | Notes |
|----------|-----------|-------|
| TS-XX | High | [Why this is high risk] |
```

### Step 11: Diagrams (5+ Scenarios)

If the test plan has 5 or more scenarios, run `/tw-diagrams` to generate
Configuration Flow, Data Flow, and Modular Test Design diagrams.

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
    ├── 04_Test_Strategy.md                # § 4.1-4.6 (includes scenarios, coverage matrix, traceability, entry/exit, risk)
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

### 4.3 Coverage Matrix

┌────────────────────────┬───────┬───────┬───────┬───────┐
│ Test Aspect            │ TS-01 │ TS-02 │ TS-03 │ TS-04 │
├────────────────────────┼───────┼───────┼───────┼───────┤
│ [Relevant aspect 1]   │   ✓   │       │       │   ✓   │
│ [Relevant aspect 2]   │       │   ✓   │   ✓   │       │
└────────────────────────┴───────┴───────┴───────┴───────┘

### 4.3.1 Hybrid Depth Strategy

| Scenario | Depth | Rationale |
|----------|-------|-----------|
| TS-XX | Deep | Representative case — covers most aspects |
| TS-XX | Wide | Variant — differs by 1-2 parameters |

### 4.4 Requirements Traceability

| Requirement | Source | Covered By |
|-------------|--------|------------|
| [Req 1] | [Source] | TS-XX |

### 4.5 Entry/Exit Criteria

**Entry Criteria:**
- [ ] Enhancement deployed to test environment
- [ ] Existing feature baseline verified

**Exit Criteria:**
- [ ] 100% P0 pass, ≥90% P1 pass
- [ ] No regression in existing functionality

### 4.6 Risk Assessment

| Scenario | Risk Level | Notes |
|----------|-----------|-------|
| TS-XX | [High/Medium/Low] | [Details] |
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
