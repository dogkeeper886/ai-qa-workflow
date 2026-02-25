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

**SOURCE ROLES — Content vs Structure:**

Different sources inform different aspects of the test plan. No single
document should determine both the content AND the structure of test
scenarios.

| Source | Informs Test... | Does NOT Determine... |
|--------|----------------|----------------------|
| **HLD** | **Content** — values to test, constraints, validation rules | Scenario grouping, naming, sequencing |
| **UX/Figma** | **Structure** — scenario grouping, sequencing, naming | Specific field validation rules, API constraints |
| **Live product** | **Baseline** — what actually exists today | Future behavior (that's in the HLD/UX) |
| **Jira tickets** | **Context** — why the feature exists, acceptance criteria | Technical implementation details |

When UX mockups exist (Tier 2-3), use them to organize scenarios even
though HLD (Tier 1) remains the primary source for test content.

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

Define high-level test scenarios (5-8 typical). Each scenario becomes a
Test Suite (TS-XX). Focus on WHAT to test, not HOW to test.

**IMPORTANT:** Follow Steps 5a-5f below to derive scenarios from user
journeys rather than mirroring the HLD's technical architecture.

#### Step 5a: Extract the State Model

Before grouping test activities, discover what states the feature has
and what user actions are available in each state.

**Sources (check in order):**
1. Figma/UX mockups — often annotate states and available actions
2. HLD — state diagrams, workflow sections, status field definitions
3. Main ticket — acceptance criteria often imply state transitions

**Output a state table:**

| State | How user gets here | Available user actions |
|-------|-------------------|----------------------|
| [Initial state] | Default / entry point | [Action 1], [Action 2] |
| [State B] | After [Action] from [State A] | [Action 3], [Action 4] |
| [State C] | System auto-triggers from [State B] | [Action 5] |

This table is the foundation for scenario organization.

#### Step 5b: Map User Journeys

From the state table, identify distinct user journeys — sequences of
decisions and actions a user takes to accomplish a goal.

**Format:**
```
Journey 1: "[User goal, e.g., Set up feature for the first time]"
  State A -> user chooses [Action] -> picks sub-options -> State B

Journey 2: "[User goal, e.g., Check current status]"
  State B -> user views display -> reads information

Journey 3: "[User goal, e.g., Modify existing settings]"
  State B -> user edits config -> settings updated
```

**Key question:** What decisions does the user make? Where does the user
choose between options? Each decision point with sub-options belongs in
the same journey (same scenario), not split across scenarios.

#### Step 5c: Trace Data Flow for Each Journey

For each journey, trace where data goes after the user acts. Separate
user-observable verification points from technical-only ones.

**Format:**
```
Journey N data flow:
  User action -> API call -> backend persists -> outcome

  User-observable verification:
  - UI shows confirmation
  - Status display reflects new state

  Technical-only verification (separate scenario):
  - API response contains correct fields
  - Backend job registered correctly
```

**Rule:** User-observable verification points go into the user journey
scenario. Technical-only verification points go into dedicated technical
scenarios (backward compat, API contract, etc.).

**Anti-pattern:** Do NOT create a scenario called "Data Flow Verification"
that traces the full backend pipeline. Each user journey scenario includes
its own verification steps at the user-observable points.

#### Step 5d: Build User Decision Tree

For journeys with many options, map the user's decision tree:

```
User enters feature
  +-- [Mode A]
  |   +-- [Option X] -> configure -> done
  |   +-- [Option Y] -> configure -> done
  |   +-- Set expiry? -> yes/no -> done
  +-- [Mode B]
  |   +-- Configure -> done
  |   +-- Repeat? -> yes/no -> done
  +-- [Default] -> always on -> done
```

**Rule:** One scenario per top-level branch of the decision tree.
Sub-decisions within a branch stay in the same scenario as test cases,
not as separate scenarios.

**Anti-pattern:** Do NOT split one branch into multiple scenarios based on
how many enum values it has. That is data-model-driven splitting, not
user-journey-driven.

#### Step 5e: Classify Journeys

Separate user-initiated from system-initiated behavior:

| Category | Covers | Scenario naming |
|----------|--------|-----------------|
| **User-initiated** | User takes action, sees result | "First-Time Setup", "Modifying Settings" |
| **System-initiated** | System acts automatically (timers, triggers) | "Auto-Behavior", "Scheduled Triggers" |
| **Error/validation** | User makes mistakes, system prevents bad input | "Input Validation & Error Handling" |
| **Technical** | Not user-visible (backward compat, feature flags, API contract) | "Backward Compatibility", "Feature Flag" |

**Rule:** Never mix user-initiated and system-initiated actions in the same
scenario. If an early draft has a "Lifecycle" scenario with both "user
reschedules" and "system auto-deactivates", split them.

#### Step 5f: Sequence by Execution Order

Organize scenarios in the order a user would naturally encounter them:

```
Phase 1: Creation journeys (user sets up feature for the first time)
Phase 2: Observation journeys (user monitors status)
Phase 3: Modification journeys (user changes existing settings)
Phase 4: System auto-behavior (what happens without user action)
Phase 5: Edge cases & validation (user hits boundaries)
Phase 6: Technical verification (backward compat, feature flags)
```

This makes the test plan read like a user story.

#### Multi-Source Cross-Reference

Before finalizing scenario organization, cross-reference at least 2
sources. No single document should determine both structure and content.

```
IF only HLD available (no UX mockups):
  -> Extract user states and journeys FROM the HLD, but consciously
     separate them from the HLD's technical architecture
  -> Ask: "If I remove all API/backend details, what user workflows remain?"
  -> Ask: "What states can the user observe? What actions are available?"
  -> Flag in the test plan: "Scenario structure derived from HLD —
     review with UX team for user journey accuracy"

IF HLD + UX mockups both available:
  -> Use UX for scenario STRUCTURE (states, journeys, decision points)
  -> Use HLD for scenario CONTENT (values, constraints, validation rules)
  -> When they conflict, UX wins for structure (it represents what users see)

IF live product environment available:
  -> Check current baseline BEFORE reading HLD
  -> Note what exists today vs what's new
  -> Ground the test plan in reality, not just documents
```

#### Document Conflict Resolution

When sources disagree:

| Conflict | Resolution |
|----------|-----------|
| HLD says N modes, UX shows fewer | UX wins for structure; note discrepancy |
| HLD describes field, UX has no UI control | Field goes into technical verification scenario |
| Live product differs from HLD and UX | Document as baseline; test plan covers target behavior |
| Acceptance criteria mentions workflow not in HLD/UX | Add as scenario; flag for UX verification |

#### Persona/Role Check

```
IF feature has multiple user roles (e.g., admin vs operator):
  -> Each role may have different available states and actions
  -> Consider role-specific journeys as separate scenarios
  -> At minimum, note which role each scenario applies to

IF single-role:
  -> Note the assumed role in test plan preconditions
```

#### Anti-Patterns Checklist

Before finalizing scenarios, verify NONE of these apply:
- Scenarios split by enum values or data model groupings instead of user intent
- User-initiated and system-initiated actions mixed in one scenario
- Scenarios named after HLD components or architecture layers
- API payload validation promoted to a top-level user journey scenario
- A "Lifecycle" catch-all mixing user actions with system triggers
- Internal system behavior mixed with user actions in a single scenario
- Missing state-based coverage when UX defines distinct states

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
