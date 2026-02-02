# Test Cases: New Feature (Type A)

Create detailed test cases for new feature testing.

```
Use this command to expand new feature test scenarios into detailed test cases.
Creates separate files for each test scenario (TS-XX_*.md).

{{input}}

## PURPOSE

Create comprehensive test cases for new features:
- Step-by-step test execution procedures
- TestLink-ready format
- One file per test scenario
- Expected: 20-40 test cases across 5-8 scenarios

AUDIENCE: QA Engineers, Test Execution Team, TestLink Users

---

## INFORMATION SOURCES

**PRIMARY SOURCE (Required):**
1. **TEST_PLAN.md § 4.4** - Test scenarios to expand into test cases
2. **TEST_PLAN.md § 4.3** - Priority operations (example test operations)
3. **TEST_PLAN.md § 3.1** - In-scope testing categories

**SECONDARY SOURCES (Reference):**
4. **Confluence HLD** (`confluence/HLD_*.md`) - For detailed acceptance criteria
5. **UX Design Tickets** (`01_*UX*.md`) - For exact UI element names
6. **README.md** - For feature behavior clarification

---

## OUTPUT FILE STRUCTURE

```
test_cases/
├── README.md                        # Index and summary
├── TS-01_[Scenario_Name].md         # First test scenario
├── TS-02_[Scenario_Name].md         # Second test scenario
└── TS-XX_[Scenario_Name].md         # Additional scenarios
```

---

## STEP-BY-STEP WORKFLOW

### Step 1: Parse TEST_PLAN.md
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

### Step 2: Create Directory and README.md
```
1. Create test_cases/ directory if it doesn't exist

2. Create test_cases/README.md with:
   # Test Cases: [Feature Name] ([Ticket ID])

   **Version:** 1.0
   **Created:** [Date]
   **QA Engineer:** [Name]

   ## Default Test Assumptions
   [Copy from test plan § 4.3]

   ## Test Scenarios Index
   | File | Scenario | Test Cases |
   |------|----------|------------|
   | [TS-01_*.md] | [Name] | TC-01 to TC-XX |
```

### Step 3: Create Separate File for Each Test Scenario

**FOR EACH test scenario in test plan § 4.4:**

1. **Create new file:** `test_cases/TS-XX_[Scenario_Name].md`
   - Replace spaces with underscores in filename
   - Example: `TS-01_Basic_Configuration.md`

2. **Add file header:**
   ```markdown
   # TS-XX: [Scenario Name]

   **Objective:** [Copy from test plan]
   **Focus:** [From "Focus" column]
   **Test Cases:** [Count]
   **Test Plan Reference:** test_plan/README.md § 4.4, TS-XX
   ```

3. **FOR EACH test activity, create test case variations:**

   a. Identify the operation being tested
   b. Create variations based on:
      - Volume (small, medium, large)
      - State (enabled, disabled, empty, full)
      - Data type (valid, invalid, boundary)

   c. Write each test case:
   ```markdown
   ## TC-XX: [Descriptive Name]

   **Objective:**
   [Specific behavior validated]

   **Preconditions:**
   - [Only non-default requirements]
   - [Specific test data needed]

   **Test Steps:**

   | Step | Action | Expected Result |
   |------|--------|-----------------|
   | 1 | [Specific action] | [Measurable result] |
   | 2 | [Next action] | [Expected outcome] |

   **Execution Type:** Manual
   ```

4. **Add Summary table at end of file:**
   ```markdown
   ## Summary

   | TC ID | Name | Priority | Type |
   |-------|------|----------|------|
   | TC-01 | ... | P0 | Functional |
   ```

5. **SAVE file before moving to next scenario**

6. **Update README.md index**

7. **Move to next scenario**

### Step 4: Finalize README.md

After all scenario files are created:
1. Complete Test Scenario Index table
2. Add Test Type Summary section
3. Add Priority Summary section
4. Add Execution Summary with totals

---

## QUALITY GUIDELINES

### Be Specific, Not Vague
- **Bad:** "Enter data" → **Good:** "Enter 'test@example.com' in Email field"
- **Bad:** "Verify result" → **Good:** "Message displays: 'Success'"

### Appropriate Test Case Counts
- Simple scenario: 2-4 test cases
- Moderate scenario: 5-8 test cases
- Complex scenario: 8-12 test cases
- If creating 20+: Split into 2 scenarios

### Priority Assignment
- **P0 (Critical):** Core functionality, happy path
- **P1 (High):** Important variations, common scenarios
- **P2 (Medium):** Edge cases, rare scenarios

### Test Variations
Create variations based on:
- **Volume:** small (2-3), medium (10-20), large (50-100+)
- **State:** enabled, disabled, partial, full
- **Data:** valid, invalid, boundary, special characters

---

## DECISION TREES

### Vague Test Activity
```
IF test activity is vague (e.g., "Test notification grouping"):
  1. Identify the operation
  2. Create volume variations (below, at, above threshold)
  3. Create data variations (single type, multiple types)
  4. Create edge cases (empty, maximum)
  Result: 1 vague activity → 5-6 specific test cases
```

### No Volume Guidance
```
IF test plan doesn't specify volumes:
  1. Check HLD for thresholds
  2. Use defaults: Small=2-3, Medium=10-20, Large=50-100+
  3. Document assumption
```

---

## NEXT STEP

After creating test cases, run `/tw-case-review` to verify quality before TestLink sync.

```
┌─────────────────────────────────────────────────────────────────┐
│                    WORKFLOW CONTINUATION                         │
└─────────────────────────────────────────────────────────────────┘

/tw-case-init
    └── Detected Type A: New Feature
                              ↓
/tw-case-feature  ◄── YOU ARE HERE
    └── Creates test_cases/README.md + TS-XX_*.md files
                              ↓
/tw-case-review
    └── Reviews test case quality
                              ↓
/tl-sync
    └── Syncs to TestLink
```
```
