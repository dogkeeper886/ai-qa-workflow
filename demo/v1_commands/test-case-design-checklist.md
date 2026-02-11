# Test Case Design Checklist

## PURPOSE
Create detailed TEST_CASES.md from TEST_PLAN.md test scenarios with:
- Step-by-step test execution procedures for QA engineers
- TestLink-ready format and organization
- Test type categorization and traceability
- Clear mapping from test plan strategy to test execution

AUDIENCE: QA Engineers, Test Execution Team, TestLink Users

For strategic test planning, use the /test-planning-checklist command.

---

## AI AGENT WORKFLOW

This section provides step-by-step guidance for AI code agents to autonomously create detailed TEST_CASES.md from TEST_PLAN.md.

### Pre-Check: Verify Prerequisites
Before starting, verify these files exist:
- [ ] `TEST_PLAN.md` - Must exist (created by /test-planning-checklist)
- [ ] Test scenarios defined in TEST_PLAN.md (§ 3.2 for bug fixes, § 4.4 for features)
- [ ] Priority operations or reproduction steps identified in TEST_PLAN.md

**If TEST_PLAN.md is missing:**
```
Ask user: "Please run /test-planning-checklist first to create the test plan."
STOP - Cannot proceed without TEST_PLAN.md
```

---

### Step 0: Detect Test Plan Type

Read TEST_PLAN.md header to determine test plan type:

**Type A: New Feature Test Cases**
- **Indicator:** TEST_PLAN.md header shows "Test Plan Type: New Feature Validation"
- **Source:** TEST_PLAN.md § 4.4 Test Scenarios
- **Approach:** Expand test activities into comprehensive test cases
- **Typical volume:** 5-8 test scenarios → 20-40 test cases

**Type B: Bug Fix Test Cases**
- **Indicator:** TEST_PLAN.md header shows "Test Plan Type: Bug Fix Validation"
- **Source:** TEST_PLAN.md § 3.2 Test Scenarios (bug fix plans use different section)
- **Approach:** Focus on defect verification, regression, edge cases
- **Typical volume:** 3-4 test scenarios → 8-15 test cases

**Type C: Enhancement Test Cases**
- **Indicator:** TEST_PLAN.md header shows "Test Plan Type: Enhancement Validation"
- **Source:** TEST_PLAN.md § 4.2 Test Scenarios
- **Approach:** Hybrid - new functionality + regression testing
- **Typical volume:** 4-6 test scenarios → 15-25 test cases

**Detection Logic:**
```
READ TEST_PLAN.md header
FIND "Test Plan Type:" field

IF "New Feature Validation":
  → Use Type A workflow
  → Read § 4.4 for test scenarios
  → Create comprehensive test cases
  
ELSE IF "Bug Fix Validation":
  → Use Type B workflow
  → Read § 3.2 for test scenarios
  → Focus on defect verification + regression
  
ELSE IF "Enhancement Validation":
  → Use Type C workflow
  → Read § 4.2 for test scenarios
  → Hybrid approach
  
ELSE:
  → Default to Type A workflow
  → Read § 4.4 (most common location)
```

---

### WORKFLOW TYPE A: NEW FEATURE TEST CASES

Use this workflow for expanding new feature test scenarios into detailed test cases.

#### Information Sources Priority

**PRIMARY SOURCE (Required):**
1. **TEST_PLAN.md § 4.4** - Test scenarios to expand into test cases
2. **TEST_PLAN.md § 4.3** - Priority operations (example test operations)
3. **TEST_PLAN.md § 3.1** - In-scope testing categories

**SECONDARY SOURCES (Reference):**
4. **Confluence HLD** (`confluence/HLD_*.md`) - For detailed acceptance criteria
5. **UX Design Tickets** (`01_*UX*.md`) - For exact UI element names, navigation paths
6. **README.md** - For feature behavior clarification

#### Step-by-Step Execution (Type A)

**Step 1: Parse TEST_PLAN.md (5 min)**
```
1. Read TEST_PLAN.md § 4.4 (Test Scenarios table)
2. Count test scenarios (TS-01, TS-02, etc.)
3. For each scenario, extract:
   - Scenario ID (TS-XX)
   - Scenario name
   - Focus area
   - Estimated test case count
   - Test activities (bullet points)
4. Note priority operations from § 4.3 (use as examples)
```

**Step 2: Create Document Structure (3 min)**
```
1. Create document header
   - Title: "Test Cases: [Feature Name] ([Ticket ID])"
   - Based on: TEST_PLAN.md v1.0
   - Copy metadata from TEST_PLAN.md header
   
2. Create Default Test Assumptions section
   - Copy from TEST_PLAN.md § 4.3 (test environment)
   - Add feature flag state (if applicable from TEST_PLAN.md § 2.2)
   - Add browser/resolution requirements
   
3. Create TestLink Mapping table
   - One row per test scenario from TEST_PLAN.md § 4.4
```

**Step 3: Expand Each Test Scenario into Test Suite (20-30 min)**
```
FOR EACH test scenario in TEST_PLAN.md § 4.4:
  
  1. Create Test Suite section
     ## Test Suite: TS-XX - [Name from TEST_PLAN.md]
     **Objective:** [Copy from TEST_PLAN.md]
     **Test Type:** [From "Focus" column]
     **Priority:** [Assign P0/P1/P2 based on importance]
  
  2. FOR EACH test activity in that scenario:
     
     a. Identify the operation being tested
        - Example: "Validate grouping threshold" → Operation = GROUPING
     
     b. Create test case variations based on:
        - Volume (small, medium, large)
        - State (enabled, disabled, empty, full)
        - Data type (valid, invalid, boundary)
        
     c. Write test case:
        ### TC-XX-[OPERATION]-[VARIANT]: [Descriptive Name]
        
        **Objective:**
        [Specific behavior validated by this test case]
        
        **Preconditions:**
        - [Only non-default requirements]
        - [Specific test data needed]
        
        **Test Steps:**
        | Step | Action | Expected Result |
        |------|--------|-----------------|
        | 1 | [Specific action with exact values] | [Measurable result] |
        | 2 | [Next action] | [Expected outcome] |
        
     d. Assign priority: P0 (critical), P1 (high), P2 (medium)
  
  3. Move to next scenario
```

**Step 4: Create Appendices (10 min)**
```
1. Appendix A: Map test case IDs to test types
   - List all TC-XX-XXX-XX under each category
   
2. Appendix B: Count test cases per suite
   - Calculate total test cases
   - Estimate execution time (~2-3 min per test case)
   
3. Appendix C: Group by priority (P0, P1, P2)
   
4. Appendix D: Revision history (v1.0, current date)
```

---

### WORKFLOW TYPE B: BUG FIX TEST CASES

Use this workflow for creating test cases from bug fix test plans.

#### Information Sources Priority

**PRIMARY SOURCE (Required):**
1. **TEST_PLAN.md § 3.2** - Test scenarios (bug fix plans use section 3, not section 4)
2. **TEST_PLAN.md § 1.2** - Reproduction steps (critical for defect verification)
3. **TEST_PLAN.md § 2.1-2.3** - Test scope (defect verification, regression, edge cases)

**SECONDARY SOURCES (Reference):**
4. **Bug Ticket** (`00_Main_Task_*.md`) - Original reproduction steps, comments
5. **README.md** - Problem summary

#### Step-by-Step Execution (Type B)

**Step 1: Parse Bug Fix Test Plan (5 min)**
```
1. Read TEST_PLAN.md § 1.2 - Extract reproduction steps
   - These become the basis for TS-01 (Defect Verification)
   
2. Read TEST_PLAN.md § 3.2 - Test scenarios
   - Typically 3 scenarios:
     • TS-01: Defect Verification
     • TS-02: Regression Testing
     • TS-03: Edge Cases
     
3. Read TEST_PLAN.md § 1.3 - Fix summary
   - Identify component/area affected
   - Use to determine regression scope
```

**Step 2: Create Defect Verification Test Cases (TS-01)**
```
FROM TEST_PLAN.md § 1.2 reproduction steps:

1. Create TC-01-DEFECT-REPRO: Reproduce Original Bug
   **Objective:** Verify original bug no longer occurs
   **Preconditions:** [From TEST_PLAN.md § 1.2]
   **Test Steps:** [Copy exact reproduction steps from § 1.2]
   **Expected Result:** Expected behavior (not the bug)
   
2. Create TC-01-DEFECT-VAR1: Variation of reproduction
   - Slightly different data
   - Same scenario, different user role
   - Same operation, different volume
   
3. Create TC-01-DEFECT-VAR2: Another variation
   - Edge case related to bug
   - Boundary condition
```

**Step 3: Create Regression Test Cases (TS-02)**
```
BASED ON component from TEST_PLAN.md § 1.3:

1. Identify related operations in same component
   - If bug was in "Notification grouping", test:
     • Individual notification display
     • Notification deletion
     • Notification settings
     
2. Create TC-02-[COMPONENT]-[OP1]: Test related operation 1
3. Create TC-02-[COMPONENT]-[OP2]: Test related operation 2
4. Create TC-02-[COMPONENT]-[OP3]: Test related operation 3

Typical count: 3-5 regression test cases
```

**Step 4: Create Edge Case Test Cases (TS-03)**
```
THINK about what could cause similar bugs:

1. Boundary conditions
   - TC-03-EDGE-BOUNDARY: Test at limits
   
2. Volume variations
   - TC-03-EDGE-EMPTY: Test with empty/zero
   - TC-03-EDGE-LARGE: Test with large volume
   
3. Error conditions
   - TC-03-EDGE-ERROR: Test error handling
   
4. Different contexts
   - TC-03-EDGE-CONTEXT: Test in different user context

Typical count: 2-4 edge case test cases
```

**Step 5: Keep It Focused**
```
Bug fix test cases should be FOCUSED, not comprehensive:
- Total: 8-15 test cases (not 40+)
- Priority: Most should be P0 or P1
- Depth over breadth: Thorough testing of affected area
```

---

### WORKFLOW TYPE C: ENHANCEMENT TEST CASES

Use this workflow for enhancement test case creation.

#### Hybrid Approach

Enhancements require BOTH:
1. **New functionality test cases** (Type A approach)
2. **Regression test cases** (Type B approach)

**Typical split:**
- TS-01 to TS-02: Enhancement verification (use Type A workflow)
- TS-03: Existing functionality regression (use Type B workflow)
- TS-04: Integration impact (combination approach)

**Step-by-Step:**
```
1. Read TEST_PLAN.md § 4.2 test scenarios
2. Split scenarios into two groups:
   - Enhancement scenarios → Apply Type A workflow
   - Regression scenarios → Apply Type B workflow
3. Create test cases for each group
4. Combine in single TEST_CASES.md document
```

---

### DECISION TREES: HANDLING MISSING/UNCLEAR INFORMATION

#### Scenario 1: Vague Test Activity in TEST_PLAN.md
```
IF test activity is vague (e.g., "Test notification grouping"):

THEN expand into specific test cases based on common patterns:
  
  1. Identify the operation: "notification grouping"
  
  2. Create volume variations:
     TC-XX-GROUP-BELOW → Below threshold
     TC-XX-GROUP-AT → At threshold
     TC-XX-GROUP-ABOVE → Above threshold
     
  3. Create data variations:
     TC-XX-GROUP-SINGLE → Single type
     TC-XX-GROUP-MULTI → Multiple types
     
  4. Create edge cases:
     TC-XX-GROUP-EMPTY → Empty state
     TC-XX-GROUP-MAX → Maximum volume

  Result: 1 vague activity → 5-6 specific test cases
```

#### Scenario 2: No Volume Guidance in TEST_PLAN.md
```
IF test plan doesn't specify test volumes:

1. Check HLD (confluence/) for thresholds or limits
2. Check TEST_PLAN.md § 4.3 for example volumes
3. Use common-sense defaults:
   - Small: 2-3 items (basic functionality)
   - Medium: 10-20 items (typical usage)
   - Large: 50-100+ items (stress test)
   - Edge: 0 items (empty), 1 item (minimum), max limit
   
4. Document assumption:
   "Volume based on typical usage patterns - adjust if different thresholds exist"
   
5. Continue with estimated volumes
```

#### Scenario 3: Missing Navigation Details
```
IF exact navigation path unknown:

1. Check UX design ticket (`01_*UX*.md`) for page structure
2. Check HLD for feature location
3. Use general pattern in test steps:
   "Navigate to [Feature Area] page"
   
4. Add note to test case:
   "Note: Exact navigation path TBD - verify with UX documentation"
   
5. Focus on functional steps (what to test, not how to navigate)

6. Continue - navigation details can be added later
```

#### Scenario 4: Unclear Expected Results
```
IF expected behavior is ambiguous:

1. Check HLD acceptance criteria for specifics
2. Check UX ticket for visual specifications
3. Check TEST_PLAN.md § 2.1 for feature behaviors

4. Make reasonable assumption based on feature purpose:
   - Notification feature → "Display success notification with message: '[Expected text]'"
   - Grouping feature → "Items grouped by [criteria], count displayed as (N)"
   - Save operation → "Data persisted, confirmation message shown"
   
5. Document assumption:
   "Expected result based on standard patterns - verify exact wording/behavior"
   
6. Continue with reasonable expected results
```

#### Scenario 5: No Reproduction Steps (Bug Fix)
```
IF TEST_PLAN.md § 1.2 has no clear reproduction steps:

1. Check original bug ticket (`00_Main_Task_*.md`) comments
2. Check README.md problem description

3. If still unclear:
   - Create general test cases:
     TC-01-VERIFY-BASIC: Basic functionality works
     TC-01-VERIFY-SCENARIO1: Common usage scenario
     TC-01-VERIFY-SCENARIO2: Another usage scenario
     
4. Note in TEST_CASES.md:
   "Original reproduction steps not available - created general verification tests"
   
5. Continue with broader coverage
```

---

### COMMON SENSE GUIDELINES FOR AI AGENTS

#### 1. Expand Test Activities 3-5x
- TEST_PLAN.md activity: "Validate grouping" (1 line)
- TEST_CASES.md: 3-5 test cases (volume variations, data types, edge cases)
- **Principle:** One high-level activity becomes multiple detailed test cases

#### 2. Create Variations Based On:
- **Volume:** small (2-3), medium (10-20), large (50-100+), empty (0), max
- **State:** enabled, disabled, partial, full, loading
- **Data:** valid, invalid, boundary, special characters, null
- **Timing:** immediate, delayed, timeout, concurrent
- **User context:** different roles, permissions, states

#### 3. Be Specific, Not Vague

**Bad examples:**
- ❌ Action: "Enter data"
- ❌ Expected: "Verify result"
- ❌ Precondition: "Setup test data"

**Good examples:**
- ✅ Action: "Enter username 'testuser@example.com' in Username field"
- ✅ Expected: "Success message displays: 'Login successful' and redirects to Dashboard"
- ✅ Precondition: "3 notifications of type 'System Update' exist in notification panel"

#### 4. Use Exact UI Element Names
- If UX ticket says "Save Changes button" → Use "Save Changes button"
- If HLD says "Notification Center" → Use "Notification Center"
- If unknown: Use descriptive: "[Save] button", "[Notification panel]", "[Settings menu]"

#### 5. Reasonable Test Case Counts Per Scenario
- **Simple scenario** (display, read-only): 2-4 test cases
- **Moderate scenario** (CRUD, settings): 5-8 test cases
- **Complex scenario** (workflows, integrations): 8-12 test cases
- **If creating 20+ for one scenario:** Split into 2 scenarios

#### 6. Execution Time Estimates
- **Simple test** (2-3 steps): ~1-2 min
- **Standard test** (5-7 steps): ~3-5 min
- **Complex test** (10+ steps, data setup): ~8-10 min
- **Use for Appendix B** total time calculation

#### 7. Priority Assignment (P0/P1/P2)
- **P0 (Critical - Must Pass):**
  - Core functionality
  - Defect verification (for bug fixes)
  - Feature flag ON behavior
  - Happy path scenarios
  
- **P1 (High - Should Pass):**
  - Important variations
  - Regression tests
  - Common user scenarios
  - Feature flag OFF behavior
  
- **P2 (Medium - Nice to Have):**
  - Edge cases
  - Rare scenarios
  - Nice-to-have validations

#### 8. Test Independence
- Each test should run standalone
- Don't rely on previous test's data or state
- Include all setup in preconditions
- Add cleanup in postconditions if needed

---

## WORKFLOW: FROM TEST PLAN TO TEST CASES

This checklist helps you expand **TEST_PLAN.md test scenarios** into detailed, executable test cases:

1. **Read TEST_PLAN.md** - Understand test scenarios, test operations, and test volumes
2. **Map Test Scenarios to Test Suites** - Each TS-XX becomes a Test Suite folder in TestLink
3. **Expand Test Activities into Test Cases** - Convert high-level activities into detailed step-by-step procedures
4. **Define Test Variations** - Create test cases for different volumes, edge cases, and scenarios
5. **Add Validation Details** - Specify exact expected results for each step

---

## PREREQUISITES
Before creating TEST_CASES.md:
- [ ] TEST_PLAN.md exists with defined test scenarios
- [ ] Business requirements are documented (in TEST_PLAN.md)
- [ ] Test environment setup is understood (from TEST_PLAN.md)
- [ ] Priority test operations identified (from TEST_PLAN.md)

---

## DOCUMENT STRUCTURE

### 1. Document Header
```markdown
# Test Cases: [Feature Name] ([Ticket ID])

**Based on:** TEST_PLAN.md v1.0
**TestLink Project:** [Project Name]
**Created:** YYYY-MM-DD
**QA Engineer:** [Name]
**Epic:** [Link]
**Feature Flag:** [flag-name if applicable]
```

### 2. Document Overview
Include:
- [ ] **Purpose statement** - What these test cases cover
- [ ] **Default test assumptions** - Baseline conditions for all tests
- [ ] **TestLink mapping table** - Maps test scenarios to test suites

**Default Assumptions Template:**
```markdown
### Default Test Assumptions

Unless explicitly stated otherwise in test preconditions, the following baseline conditions apply:

- **Feature flag** `[flag-name]` is **[ON/OFF]** (if applicable)
- **User** is logged in as **[username/role]**
- **Environment** is **[URL]**
- **Browser resolution** is **[e.g., 1920x1080 or higher]**
- [Add other common conditions specific to your test environment]

**Note:** Test cases that deviate from these defaults will explicitly state different conditions in their preconditions.
```

**TestLink Mapping Format:**
```markdown
| Test Suite (Folder) | Test Plan Reference | Test Cases | Description |
|---------------------|---------------------|------------|-------------|
| **TS-01: [Name from TEST_PLAN.md]** | TEST_PLAN.md § 4.4, TS-01 | TC-01-XXX-YY, ... | [Brief description] |
| **TS-02: [Name from TEST_PLAN.md]** | TEST_PLAN.md § 4.4, TS-02 | TC-02-XXX-YY, ... | [Brief description] |
```

### 3. Test Type Categories Table
Define what each category means in your project context:

```markdown
| Category | Definition | Examples from This Feature |
|----------|------------|----------------------------|
| **Functional** | Core feature behavior validation | [Your specific examples] |
| **UI/UX** | Visual appearance and user interactions | [Your specific examples] |
| **Integration** | Component/system interactions | [Your specific examples] |
| **Non-Functional** | Quality attributes (performance, usability) | [Your specific examples] |
| **Feature Flag** | Feature flag behavior validation | [If applicable] |
| **Regression** | Existing functionality remains intact | [Your specific examples] |
```

---

## TEST SUITES & TEST CASES

### Deriving Test Suites from TEST_PLAN.md

**For each Test Scenario in TEST_PLAN.md § 4.4:**

1. Create a corresponding Test Suite in TEST_CASES.md
2. Use the same TS-XX identifier (TS-01, TS-02, etc.)
3. Expand "Test Activities" into individual test cases

**Test Suite Template:**
```markdown
## Test Suite: TS-XX - [Suite Name from TEST_PLAN.md]

**Objective:** [Copy from TEST_PLAN.md or expand with more detail]
**Test Type:** [Categories - derived from test plan's "Focus" column]
**Priority:** [Critical/High/Medium/Low (P0/P1/P2)]
```

### Creating Test Cases from Test Activities

**For each test case derived from test activities:**

```markdown
### TC-XX-[OPERATION]-[VARIANT]: [Descriptive Test Case Name]

**Objective:**
[What specific behavior/condition does this test validate?]

**Preconditions:**
- [List only non-default requirements]
- [Specific test data needed]
- [Special configuration or setup]
- [Omit default assumptions already defined in Document Overview]

**Test Steps:**

| Step | Action | Expected Result |
|------|--------|-----------------|
| 1 | [Action verb + specific details] | [Specific, measurable expected behavior] |
| 2 | [Action verb + specific details] | [Specific, measurable expected behavior] |
| ... | ... | ... |
```

**Guidelines for Writing Test Steps:**
- **Action verbs**: Navigate, Click, Select, Enter, Verify, Observe, Wait
- **Specific inputs**: Use exact values (e.g., "Select 3 items" not "Select some items")
- **Measurable results**: Define observable, verifiable outcomes
- **One action per step**: Keep steps atomic and sequential
- **Combine action + result**: Single table format for clarity

**Optional Sections:**
- **Postconditions:** Cleanup steps required after test execution
- **Dependencies:** Prerequisites or tests that must run first
- **Tags:** Keywords for filtering (e.g., `functional`, `high-priority`, `api-test`)

---

## TEST CASE NAMING CONVENTION

### Recommended Format
`TC-[Suite#]-[OPERATION]-[VARIANT]`

**Components:**
- **TC**: Test Case prefix
- **Suite#**: Two-digit test suite number (01, 02, 03...) matching TS-XX
- **OPERATION**: Short code representing the operation under test
- **VARIANT**: Distinguishes variations (volume, state, edge case)

### Choosing Operation Codes
Base operation codes on your **Priority Test Operations** from TEST_PLAN.md § 4.3:

**Examples:**
- For "User Management" operations: USER, ROLE, PERM
- For "Order Processing" operations: ORDER, CART, CHECKOUT
- For "Data Import" operations: IMPORT, EXPORT, SYNC
- For "Configuration" operations: CONFIG, SETUP, DEPLOY

### Choosing Variants
Variants distinguish different test conditions:

**Volume-based variants:**
- Number + Unit (e.g., 2U = 2 users, 10O = 10 orders, 100I = 100 items)

**State-based variants:**
- Descriptive codes (e.g., ENABLED, DISABLED, EMPTY, FULL)

**Scenario-based variants:**
- Behavior codes (e.g., PERSIST, TIMEOUT, ERROR, SUCCESS)

**Examples:**
```
TC-01-USER-2U       # Test Suite 01, User operation, 2 users
TC-01-USER-10U      # Test Suite 01, User operation, 10 users
TC-02-ORDER-EMPTY   # Test Suite 02, Order operation, empty cart
TC-03-IMPORT-100R   # Test Suite 03, Import operation, 100 records
TC-04-CONFIG-PERSIST # Test Suite 04, Configuration, persistence test
```

---

## APPENDICES

### Appendix A: Test Type Mapping
Map test case IDs to their test categories:

```markdown
| Test Category (from TEST_PLAN.md § 3.1) | Test Cases |
|------------------------------------------|------------|
| **Functional Testing** | [List all functional test case IDs] |
| **UI/UX Testing** | [List all UI/UX test case IDs] |
| **Integration Testing** | [List all integration test case IDs] |
| **Non-Functional Testing** | [List all non-functional test case IDs] |
| **Feature Flag Validation** | [List feature flag test case IDs] |
| **Regression Testing** | [List regression test case IDs] |
```

### Appendix B: Test Execution Summary
Summarize test suites with execution metrics:

```markdown
| Test Suite | Test Cases | Total | Priority | Estimated Time |
|------------|------------|-------|----------|----------------|
| TS-01 | [List IDs] | X | P0/P1/P2 | ~XX min |
| TS-02 | [List IDs] | Y | P0/P1/P2 | ~YY min |
| **TOTAL** | | **Z** | | **~ZZ min** |
```

### Appendix C: Test Execution Priority
Group by priority level for test execution planning:

```markdown
**P0 (Critical - Must Pass):**
- TC-XX-XXX-XX: [Brief name]
- [List all P0 test cases]

**P1 (High - Should Pass):**
- TC-XX-XXX-XX: [Brief name]
- [List all P1 test cases]

**P2 (Medium - Nice to Have):**
- TC-XX-XXX-XX: [Brief name]
- [List all P2 test cases]
```

### Appendix D: Document Revision History
```markdown
| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | YYYY-MM-DD | [Name] | Initial test cases document created |
| 1.1 | YYYY-MM-DD | [Name] | [Description of changes] |
```

---

## QUALITY CHECKLIST

Before finalizing TEST_CASES.md:
- [ ] All test cases have unique IDs following naming convention
- [ ] Each test case maps to a test scenario in TEST_PLAN.md § 4.4
- [ ] Test types are correctly categorized (match TEST_PLAN.md § 3.1)
- [ ] Default assumptions clearly defined in Document Overview
- [ ] Preconditions list only non-default requirements
- [ ] Test steps use combined Action + Expected Result format
- [ ] Test steps are clear, actionable, and numbered
- [ ] Expected results are specific and measurable (no vague terms)
- [ ] Priority levels (P0/P1/P2) are assigned consistently
- [ ] All appendices are complete and accurate
- [ ] TestLink mapping table matches TEST_PLAN.md test scenarios
- [ ] No ambiguous language ("some", "maybe", "should work")
- [ ] Test case count in Appendix B matches actual test cases

---

## TESTLINK IMPORT PREPARATION

To prepare for TestLink import:
- [ ] Verify test suite folder structure matches TS-XX naming
- [ ] Ensure test case IDs are unique across entire project
- [ ] Validate that preconditions can be converted to TestLink format
- [ ] Check that test steps have clear action/expected result pairs
- [ ] Confirm tag format (if used) matches TestLink keyword structure
- [ ] Review execution order for dependencies
- [ ] Verify all required fields are populated (ID, Suite, Type, Priority)

---

## BEST PRACTICES

### 1. Derive from TEST_PLAN.md
- Start with test scenarios from TEST_PLAN.md § 4.4
- Each test scenario becomes a test suite (TS-XX)
- Expand test activities into detailed test cases
- Use priority operations from TEST_PLAN.md § 4.3 as test basis

### 2. Be Specific
- ❌ Vague: "Enter some data"
- ✅ Specific: "Enter 3 values: Value1, Value2, Value3"
- ❌ Vague: "Verify the result"
- ✅ Specific: "Verify success message displays: 'Operation completed successfully'"

### 3. One Action Per Step
- ❌ Combined: "Navigate to settings page and click submit button"
- ✅ Atomic: 
  - Step 1: "Navigate to Settings page"
  - Step 2: "Click Submit button"

### 4. Measurable Expected Results
- ❌ Subjective: "Page looks correct"
- ✅ Objective: "Page displays header: 'Dashboard', navigation menu with 5 items, and user profile in top-right"
- ❌ Vague: "Data is saved"
- ✅ Specific: "Database record created with status='ACTIVE', timestamp='[current time]', and user_id='[logged-in user]'"

### 5. Use Default Assumptions
- Define common conditions once in "Document Overview"
- Only list exceptions in test case preconditions
- Example: If all tests use same environment and user, don't repeat in every test case

### 6. Combined Steps Format
- Use single table: Step | Action | Expected Result
- Makes test execution faster and clearer
- Easier to follow during manual testing
- Reduces document length

### 7. Test Independence
- Each test should run standalone
- Include all setup in preconditions
- Don't rely on data or state from previous tests
- Add cleanup in postconditions if needed

### 8. Consider Test Variations
Create variations based on:
- **Volume**: Small (below threshold), medium, large, edge case
- **State**: Empty, partial, full, maximum
- **Timing**: Sequential, concurrent, delayed
- **Error conditions**: Invalid input, missing data, permission denied
- **Feature flags**: ON vs OFF (if applicable)

### 9. Traceability
- Each test case should trace back to:
  - A test scenario in TEST_PLAN.md § 4.4
  - A business requirement (via TEST_PLAN.md)
  - A test type category (from TEST_PLAN.md § 3.1)
- Use Appendix A (Test Type Mapping) to maintain traceability

### 10. Execution Guidance
Include practical details:
- Exact navigation paths (Menu → Submenu → Page)
- Exact button/link names (not "click the button" but "click 'Save' button")
- Exact expected text/values (not "shows message" but "displays: 'Error: Invalid input'")
- Timing considerations (wait times, auto-dismiss timers)
