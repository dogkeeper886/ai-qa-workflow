# Test Plan Review

Review test plan for completeness, gaps, and overlaps before creating test cases.

## Purpose

Analyze the test plan to:
1. Identify coverage gaps in test scenarios
2. Identify overlaps and redundancies
3. Generate coverage matrix
4. **Generate diagrams for features with 5+ scenarios**
5. Recommend improvements BEFORE test case creation

## Prerequisites

- `test_plan/README.md` exists (created by `/tw-plan-*` commands)
- OR `TEST_PLAN.md` exists in project root

**If test plan is missing:**
```
Ask user: "Please run /tw-plan-init first to create the test plan."
STOP - Cannot proceed without test plan
```

## When to Use

- **After** running `/tw-plan-feature`, `/tw-plan-bugfix`, or `/tw-plan-enhance`
- **Before** running `/tw-case-init`
- When updating an existing test plan
- When test suite feels incomplete or bloated

## Agent Instructions

### Step 1: Read Test Plan

Read the test plan and extract key information:

```
1. Read test_plan/README.md (or TEST_PLAN.md)
2. Identify test plan type from header:
   - "New Feature Validation" → Comprehensive review
   - "Bug Fix Validation" → Focused review
   - "Enhancement Validation" → Hybrid review
3. Extract all test scenarios (TS-XX)
4. For each scenario, note:
   - Scenario ID and name
   - Focus area
   - Estimated test case count
   - Test activities listed
```

### Step 2: Analyze Coverage

For each test scenario, identify which aspects it covers:

| Coverage Aspect | Description |
|-----------------|-------------|
| UI Configuration | Tests that configure via user interface |
| API Configuration | Tests that configure via API |
| Data Flow | How data moves through the system |
| Error Handling | Invalid inputs, edge cases, failures |
| Backward Compatibility | Existing functionality still works |
| Client/End-user Validation | End-to-end user scenarios |
| Feature Flags | ON/OFF state behavior |
| Edge Cases | Boundary conditions, empty/max states |
| Performance | Response time, throughput |
| Accessibility | WCAG compliance, keyboard navigation |

### Step 3: Generate Coverage Matrix

Create an ASCII coverage matrix showing what each scenario covers:

```
┌────────────────────────┬───────┬───────┬───────┬───────┬───────┐
│ Test Aspect            │ TS-01 │ TS-02 │ TS-03 │ TS-04 │ TS-05 │
├────────────────────────┼───────┼───────┼───────┼───────┼───────┤
│ UI Configuration       │   ✓   │       │       │   ✓   │       │
│ API Configuration      │       │       │   ✓   │       │       │
│ Error Handling         │       │   ✓   │       │       │       │
│ Backward Compatibility │       │       │       │   ✓   │       │
│ Edge Cases             │       │       │       │       │   ✓   │
└────────────────────────┴───────┴───────┴───────┴───────┴───────┘
```

**Note:** This coverage matrix is the SINGLE source of truth. It should NOT be recreated in test case design.

### Step 4: Generate Diagrams (For 5+ Scenarios)

**IMPORTANT:** For features with 5 or more test scenarios, automatically generate the following diagrams:

#### 4.1 Configuration Flow Diagram

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         FEATURE CONFIGURATION FLOW                          │
└─────────────────────────────────────────────────────────────────────────────┘

                              ┌─────────────────┐
                              │  Entry Point    │
                              └────────┬────────┘
                                       │
                                       ▼
                    ┌──────────────────────────────────────┐
                    │         Decision Point               │
                    └──────────────────┬───────────────────┘
                                       │
         ┌─────────────────────────────┼─────────────────────────────┐
         ▼                             ▼                             ▼
    ┌─────────┐                  ┌─────────┐                  ┌─────────┐
    │Option A │                  │Option B │                  │Option C │
    └────┬────┘                  └────┬────┘                  └────┬────┘
```

#### 4.2 Data Flow Diagram

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           DATA FLOW PATHS                                   │
└─────────────────────────────────────────────────────────────────────────────┘

    ┌──────────┐                                           ┌──────────────┐
    │  Source  │                                           │   Target     │
    └────┬─────┘                                           └──────▲───────┘
         │                                                        │
         │ Protocol/Format                                        │
         ▼                                                        │
    ┌──────────┐         ┌─────────────────────────────────┐     │
    │ Process  │────────►│     Data Transformation         │─────┘
    └──────────┘         └─────────────────────────────────┘
```

#### 4.3 Modular Test Design Diagram

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                    MODULAR TEST SCENARIO DESIGN                             │
│              (Each module tests one variable/aspect)                        │
└─────────────────────────────────────────────────────────────────────────────┘

                              ┌───────────────────┐
                              │   CORE FEATURE    │
                              │     TS-01         │
                              └─────────┬─────────┘
                                        │
        ┌───────────────────────────────┼───────────────────────────────┐
        │                               │                               │
        ▼                               ▼                               ▼
┌───────────────────┐         ┌───────────────────┐         ┌───────────────────┐
│   INTEGRATION     │         │   COMPATIBILITY   │         │   CONTROL         │
├───────────────────┤         ├───────────────────┤         ├───────────────────┤
│  TS-02, TS-03     │         │  TS-04, TS-05     │         │  TS-06            │
└───────────────────┘         └───────────────────┘         └───────────────────┘
```

**Diagram Selection Guide:**

| Scenario Count | Diagrams to Generate |
|----------------|---------------------|
| 1-3 scenarios | Coverage Matrix only |
| 4 scenarios | Coverage Matrix + one flow diagram |
| 5+ scenarios | All diagram types (configuration, data flow, modular design) |

### Step 5: Identify Issues

Report any issues found:

**Gaps:**
- Aspects not covered by any test scenario
- Missing error handling tests
- Missing edge case coverage
- Missing integration tests

**Overlaps:**
- Multiple scenarios testing the same aspect
- Redundant test activities
- Duplicated coverage

**Recommendations:**
- Scenarios to consolidate
- New scenarios to add
- Test activities to move or remove

### Step 6: Apply Hybrid Depth Strategy

Check if the feature has variants (multiple types, modes, configurations):

1. Identify the **representative case** for full verification
   - This scenario gets deep, comprehensive testing

2. Identify **variants** for lightweight validation
   - These get configuration + basic functionality tests

3. Recommend which scenarios should be "deep" vs "wide"

### Step 7: Provide Recommendations

Based on analysis, provide specific recommendations:

1. **Immediate fixes** - Issues to address before creating test cases
2. **Scenario adjustments** - Merge, split, or reorder scenarios
3. **Coverage additions** - Missing aspects to add
4. **Optimization** - Ways to reduce overlap

---

## Output Format

```markdown
# Test Plan Review: [Feature Name]

## Summary
- **Test Plan Type:** [New Feature / Bug Fix / Enhancement]
- **Total Scenarios:** X
- **Total Estimated Test Cases:** Y
- **Coverage Score:** Good / Fair / Needs Improvement

## Coverage Matrix

```
┌────────────────────────┬───────┬───────┬───────┐
│ Test Aspect            │ TS-01 │ TS-02 │ TS-03 │
├────────────────────────┼───────┼───────┼───────┤
│ [Aspect 1]             │   ✓   │       │   ✓   │
│ [Aspect 2]             │       │   ✓   │       │
│ [Aspect 3]             │   ✓   │   ✓   │       │
└────────────────────────┴───────┴───────┴───────┘
```

## Diagrams (For 5+ Scenarios)

[Include Configuration Flow, Data Flow, and Modular Design diagrams]

## Gaps Identified

| Gap | Impact | Recommendation |
|-----|--------|----------------|
| [Gap 1] | [High/Medium/Low] | [How to address] |
| [Gap 2] | [High/Medium/Low] | [How to address] |

## Overlaps Found

| Overlap | Scenarios | Recommendation |
|---------|-----------|----------------|
| [Overlap 1] | TS-01, TS-03 | [Consolidate/Remove] |

## Modular Design Assessment

| Category | Scenarios | Purpose |
|----------|-----------|---------|
| **Core** | TS-XX | Primary functionality validation |
| **Integration** | TS-XX, TS-XX | Component interactions |
| **Compatibility** | TS-XX | Backward compatibility |
| **Edge Cases** | TS-XX | Boundary conditions |

## Recommendations

### Immediate Actions (Before Test Case Creation)
1. [Specific recommendation with scenario reference]
2. [Specific recommendation with scenario reference]

### Optional Improvements
1. [Nice-to-have improvement]
2. [Nice-to-have improvement]

## Hybrid Depth Strategy

| Scenario | Depth | Rationale |
|----------|-------|-----------|
| TS-01 | Deep | Representative case - full verification |
| TS-02 | Wide | Variant - lightweight validation |
| TS-03 | Deep | Critical path - comprehensive |

## Overall Assessment

**Status:** READY FOR TEST CASES / NEEDS REVISION

[Brief summary of overall test plan quality and readiness]

---

## Next Steps

1. Address immediate action items (if any)
2. Run `/tw-case-init` to start creating detailed test cases
3. After test cases created, run `/tw-case-review` to verify quality
```

---

## Example Usage

```
User: /tw-plan-review

Agent:
1. Reads test_plan/README.md
2. Extracts all test scenarios (TS-01, TS-02, etc.)
3. Analyzes coverage of each scenario
4. Generates coverage matrix
5. For 5+ scenarios: Generates configuration, data flow, and modular design diagrams
6. Identifies gaps and overlaps
7. Provides specific recommendations
8. Assesses readiness for test case creation
```

---

## Workflow Position

```
┌─────────────────────────────────────────────────────────────────┐
│                    TEST DOCUMENTATION WORKFLOW                   │
└─────────────────────────────────────────────────────────────────┘

/jr-trace [TICKET]
    └── Creates project structure and gathers documentation

/tw-plan-init → /tw-plan-[feature|bugfix|enhance]
    └── Creates test_plan/README.md with test scenarios
                              ↓
              ┌───────────────────────────────┐
              │  /tw-plan-review  ◄── YOU     │
              │  Reviews test plan quality    │
              │  Generates diagrams for 5+    │
              └───────────────────────────────┘
                              ↓
/tw-case-init → /tw-case-[feature|bugfix|enhance]
    └── Creates test_cases/README.md + TS-XX_*.md files

/tw-case-review
    └── Reviews test case quality before sync

/tl-sync
    └── Syncs test cases to TestLink
```

---

## Tips for Reviewers

### 1. Check for Complete Coverage
- Every major feature should have at least one scenario
- Error handling should be explicitly covered
- Edge cases should not be afterthoughts

### 2. Check for Appropriate Depth
- Bug fix test plans: 2-4 focused scenarios
- Enhancement test plans: 4-6 scenarios
- New feature test plans: 5-8+ scenarios

### 3. Check Test Activity Quality
- Activities should be specific, not vague
- Good: "Test grouping threshold at 9, 10, 11 items"
- Bad: "Test various amounts"

### 4. Check Scenario Organization
- Related activities should be grouped together
- Each scenario should have a clear focus
- Avoid "catch-all" scenarios with unrelated tests
