# Test Planning Checklist

```
Use this checklist to gather information and create a strategic TEST_PLAN.md document.
This creates a HIGH-LEVEL test strategy for stakeholders and management.
For detailed test cases, use the /test-case-design-checklist command.

{{input}}

## PURPOSE
Create a strategic TEST_PLAN.md with:
- Business context and stakeholder alignment
- Feature definition and scope
- High-level test strategy and approach
- Test scenarios (what to test, not how to test)

AUDIENCE: Stakeholders, management, project team, Confluence reviewers

---

## AI AGENT WORKFLOW

This section provides step-by-step guidance for AI code agents to autonomously gather information and create TEST_PLAN.md.

### Pre-Check: Verify Context Availability
Before starting, verify these files exist (created by /jira-trace command):
- [ ] `00_Main_Task_*.md` - Main ticket file
- [ ] `README.md` - Project overview
- [ ] Related ticket files (`01_*.md`)

**Optional but helpful:**
- [ ] `confluence/*.md` - Confluence documentation (HLD, designs)

If `00_Main_Task_*.md` is missing, ask user: "Please run `/jira-trace [TICKET]` first to gather all documentation."

---

### Step 0: Detect Testing Context Type

Read the main ticket file (`00_Main_Task_*.md`) and determine the testing context:

**Type A: New Feature Testing**
- **Indicators:** Ticket type = Epic, Feature, Story
- **Has:** HLD in confluence/ folder, child tickets (UX, UI, API stories)
- **Focus:** Validate new functionality works as designed
- **Workflow:** Use comprehensive feature testing approach

**Type B: Customer Problem Testing (Bug Fix)**
- **Indicators:** Ticket type = Bug, Defect, Customer Issue
- **Has:** Comments with reproduction steps, customer reports
- **May lack:** HLD, design docs, stakeholder info
- **Focus:** Verify fix works, prevent regression
- **Workflow:** Use problem-focused testing approach

**Type C: Enhancement/Improvement Testing**
- **Indicators:** Ticket type = Enhancement, Improvement, Task
- **Has:** Partial design docs, describes changes to existing features
- **Focus:** Validate enhancement + existing functionality
- **Workflow:** Hybrid approach (new functionality + regression)

**Detection Logic:**
```
READ 00_Main_Task_*.md header section

IF ticket_type in ['Epic', 'Feature', 'Story']:
  → Use Type A workflow (New Feature Testing)
  
ELSE IF ticket_type in ['Bug', 'Defect'] OR title contains 'customer issue':
  → Use Type B workflow (Customer Problem Testing)
  
ELSE IF ticket_type in ['Enhancement', 'Improvement', 'Task']:
  → Use Type C workflow (Enhancement Testing)
  
ELSE:
  → Ask user: "Is this for: (A) New feature testing, (B) Bug fix testing, or (C) Enhancement testing?"
```

---

### WORKFLOW TYPE A: NEW FEATURE TESTING

Use this workflow for new features with full documentation (HLD, designs, etc.)

#### Information Gathering Priority

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

#### Step 1: Understand the Feature
Ask the user or review documentation to understand:
- What feature is being tested?
- What problem does it solve?
- What is the Epic/Story/Feature Request ID?

**Sources to check:**
- Jira Epic/Story tickets
- Confluence HLD (High-Level Design) documents
- Feature request tickets
- Product requirements documents

#### Step 2: Identify Stakeholders
Determine who is involved:
- Who designed it? (UX Designer)
- Who implemented it? (Developers)
- Who requested it? (Product Owner, Customer)
- Who will test it? (QA Engineer)

#### Step 3: Define Scope
Clarify what will and won't be tested:
- What behaviors are in scope?
- What is explicitly excluded?
- What existing features need regression testing?

#### Step 4: Identify Test Operations
Determine how to test the feature:
- What user operations will trigger the feature?
- What test data is needed?
- What volumes should be tested? (small, medium, large)

#### Step 5: Create Test Scenarios
Define high-level test scenarios:
- Group related test activities together
- Each scenario becomes a Test Suite (TS-XX)
- Focus on WHAT to test, not HOW to test

---

### WORKFLOW TYPE B: CUSTOMER PROBLEM TESTING (BUG FIX)

Use this workflow for bug fixes, customer issues, and defects.

#### Information Gathering Priority

**PRIMARY SOURCES (Required):**
1. **Bug Ticket Comments** (`00_Main_Task_*.md` comments section) - Reproduction steps, customer reports
2. **Main Ticket Description** - Problem statement, expected vs actual behavior
3. **README.md** - Problem summary synthesized by jira-trace

**SECONDARY SOURCES (If Available):**
4. **Related Bug Tickets** - Similar issues, patterns, linked defects
5. **Developer Comments** - Fix approach, root cause analysis
6. **Confluence Docs** - If problem relates to documented feature

**NOTE:** Bug fixes typically do NOT have HLD, UX designs, or full stakeholder info. This is normal!

#### Step 1: Understand the Problem

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

#### Step 2: Extract Reproduction Steps

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

#### Step 3: Understand the Fix

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

**Extract into template:**
```markdown
### 2.1 Fix Summary
**Component:** [What was fixed - e.g., "Notification UI component"]
**Fix Approach:** [How it was fixed - from dev comments]
**Code Changes:** [Link to PR/commit if available, or "Not documented"]
**Related Areas:** [What else might be affected]
**Fix Version:** [When deployed/planned]
```

#### Step 4: Define Test Scope (Bug Fix Focus)

For bug fixes, focus on THREE areas:

**4.1 Defect Verification**
```markdown
| Test Category | Test Items |
|---------------|------------|
| **Defect Verification** | • Verify original problem is fixed<br>• Test exact reproduction steps<br>• Confirm expected behavior now occurs<br>• Validate in same environment/conditions as bug report |
```

**4.2 Regression Testing**
```markdown
| Test Category | Test Items |
|---------------|------------|
| **Regression Testing** | • Verify related functionality still works<br>• Test similar scenarios in same component<br>• Validate workaround no longer needed<br>• Test adjacent features |
```

**4.3 Edge Case Prevention**
```markdown
| Test Category | Test Items |
|---------------|------------|
| **Edge Case Testing** | • Test boundary conditions<br>• Test with different data volumes<br>• Test in different user contexts<br>• Prevent similar issues in related areas |
```

#### Step 5: Create Test Scenarios (Bug Fix)

For bug fixes, typically create 3-4 focused scenarios:

```markdown
| ID | Test Scenario | Focus | Est. Cases | Test Activities |
|----|---------------|-------|------------|-----------------|
| **TS-01** | Defect Verification | Verify fix | 2-3 | • Exact reproduction steps<br>• Variations of reported scenario<br>• Confirm expected behavior |
| **TS-02** | Regression Testing | Related functionality | 3-5 | • Adjacent features in same component<br>• Similar operations<br>• Integration points |
| **TS-03** | Edge Cases & Prevention | Prevent recurrence | 2-4 | • Boundary values<br>• Large/small volumes<br>• Error conditions<br>• Different user contexts |
```

**Note:** Bug fix test plans are typically SHORTER than feature test plans. Focus on quality over quantity.

---

### WORKFLOW TYPE C: ENHANCEMENT TESTING

Use this workflow for enhancements and improvements to existing features.

#### Information Gathering Priority

**PRIMARY SOURCES:**
1. **Enhancement Ticket** (`00_Main_Task_*.md`) - What's being improved
2. **README.md** - Enhancement summary
3. **Confluence Docs** (if any) - Enhancement specs

**SECONDARY SOURCES:**
4. **Original Feature Docs** - Existing functionality documentation
5. **Related Tickets** - Original feature implementation
6. **Comments** - Enhancement rationale, design decisions

#### Hybrid Approach

Enhancements require testing BOTH:
- **New/Changed Functionality** → Use Type A workflow (feature testing)
- **Existing Functionality Impact** → Use Type B workflow (regression testing)

**Split your test plan into two parts:**

**Part 1: Enhancement Validation** (Type A approach)
- What's new or changed?
- How does the enhancement work?
- What are the new behaviors?

**Part 2: Regression Validation** (Type B approach)
- What existing functionality must still work?
- What might be affected by the change?
- What should remain unchanged?

**Test Scenario Split (Typical):**
```markdown
| ID | Test Scenario | Focus | Est. Cases |
|----|---------------|-------|------------|
| **TS-01** | Enhancement Verification | New/changed behavior | 4-6 |
| **TS-02** | Existing Functionality | Unchanged behavior | 3-5 |
| **TS-03** | Integration Impact | Component interactions | 2-4 |
```

---

### DECISION TREES: HANDLING MISSING INFORMATION

Use these decision trees when information is incomplete or unclear.

#### Scenario 1: No Confluence HLD Found (Type A)
```
IF no HLD in confluence/ folder:
  1. Check Main Ticket description for technical details
  2. Check UX ticket for feature definition  
  3. Check README.md for feature summary
  4. Ask user: "I don't see an HLD document. Can you provide:
     - Confluence HLD link, OR
     - Feature definition and acceptance criteria, OR
     - Jira ticket with detailed requirements?"
  5. If user provides link: Use WebFetch to retrieve
  6. If user says "proceed without it":
     - Use ticket descriptions and README as primary source
     - Note in test plan: "HLD not available - based on ticket descriptions"
     - Focus on observable behaviors from tickets
  7. Continue with available information
```

#### Scenario 2: No Clear Reproduction Steps (Type B)
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
       • TS-02: Regression test (ensure nothing else broke)
       • TS-03: Edge case coverage (prevent related issues)
  6. Continue with broader test coverage
```

#### Scenario 3: No Fix Details (Type B)
```
IF no fix approach documented:
  1. Check for linked code commits in ticket
  2. Check developer comments for technical details
  3. Check ticket status changes for clues
  4. Make reasonable assumption based on component:
     "Fix applied to [component mentioned in ticket title/description]"
  5. Create broad test coverage:
     - Test the reported problem (defect verification)
     - Test all operations in affected component (regression)
     - Test related areas (prevention)
  6. Note in test plan: "Fix details not documented - created comprehensive test coverage"
  7. Continue without blocking
```

#### Scenario 4: No Test Environment Info
```
IF no test environment details found:
  1. Check confluence docs for "Test Environment" or "QA Environment"
  2. Check README.md for environment references
  3. Check comments for environment mentions
  4. Use reasonable defaults:
     - Environment: "QA/Staging environment"
     - Browser: "Chrome latest, resolution 1920x1080+"
     - User: "QA test account with standard permissions"
  5. Note in test plan: "Test environment details TBD - update before execution"
  6. Continue without blocking
```

#### Scenario 5: No Stakeholder Information
```
IF no stakeholder info in tickets:
  1. Extract from ticket fields:
     - Assignee field → Developer
     - Reporter field → Product Owner or Customer
     - QA/Tester custom field → QA Engineer
  2. Check README.md for team assignments
  3. Check comments for @mentions of team members
  4. If still missing, use placeholders:
     - "QA Engineer: [TBD - assign before test execution]"
     - "Product Owner: [See ticket reporter]"
     - "Developer: [See ticket assignee]"
  5. Continue without blocking - stakeholders can be added later
```

#### Scenario 6: Unclear Feature Scope
```
IF feature scope is ambiguous:
  1. Check HLD "In Scope" / "Out of Scope" sections
  2. Check acceptance criteria in Main Ticket
  3. Check for feature flag (if exists, scope = when flag is ON)
  4. Ask user specific clarifying questions:
     "I need clarification on scope:
     - Does this feature apply to [X scenario]?
     - Are we testing [Y integration]?
     - Should we validate [Z behavior]?"
  5. Make reasonable assumptions based on feature purpose:
     - Document assumptions clearly
     - Example: "ASSUMPTION: Feature only applies to active users. Verify with PM."
  6. Continue with documented assumptions
```

#### Scenario 7: No Performance Requirements
```
IF no performance requirements specified:
  1. Check HLD for performance/NFR section
  2. Check for volume mentions ("handle 100+ items", "support thousands")
  3. Check comments for performance discussions
  4. Use common-sense defaults:
     - UI response time: < 500ms for user actions
     - Animation: smooth, no flickering or lag
     - Large volume: 100+ items (typical stress test)
     - Load time: < 2 seconds for page loads
  5. Note in test plan: "Performance criteria estimated based on industry standards - confirm with development team"
  6. Continue with estimated criteria
```

#### Scenario 8: No Feature Flag Information
```
IF uncertain about feature flag:
  1. Search all files for "feature flag", "flag", "toggle"
  2. Check for tickets with "Feature Flag" in title
  3. Ask user: "Is there a feature flag controlling this feature?"
  4. If yes: Get flag name and create flag validation tests
  5. If no: Omit feature flag section from test plan
  6. If unknown: Note "Feature flag status TBD - check with dev team"
```

---

### COMMON SENSE GUIDELINES FOR AI AGENTS

#### 1. Don't Block on Minor Details
- Missing stakeholder name? Use "[TBD]" and continue
- Missing performance numbers? Estimate reasonably
- No design link? Describe expected behavior from text descriptions
- **Principle:** Create complete test plan with documented gaps, rather than incomplete plan waiting for info

#### 2. Prioritize Actionable Information
- Focus on WHAT to test (operations, behaviors, scenarios)
- Test scenarios should be concrete: "Threshold Testing (9, 10, 11 items)" not "Test various amounts"
- Specific examples better than vague descriptions
- **Principle:** QA should understand exactly what to test after reading your plan

#### 3. Make Reasonable Assumptions (Document Them)
- If HLD mentions "notifications" → assume UI, API, and persistence testing needed
- If feature has user settings → assume persistence testing required
- If API involved → assume integration testing needed
- **Principle:** Always document assumptions clearly with "ASSUMPTION:" prefix

**Examples:**
- ✅ "ASSUMPTION: Feature only affects logged-in users - verify with PM"
- ✅ "TBD: Performance requirements - check with dev team before test execution"
- ✅ "Note: No accessibility specs found - applying WCAG 2.1 AA baseline standards"

#### 4. Adapt Test Depth to Context Type
- **Type A (New Feature):** Comprehensive testing - 5-8 test scenarios
- **Type B (Bug Fix):** Focused testing - 3-4 test scenarios
- **Type C (Enhancement):** Moderate testing - 4-6 test scenarios
- **Principle:** Match effort to risk and complexity

#### 5. Practical Test Operations (Type A)
- ✅ Good: "Create 100+ notifications to test grouping threshold behavior"
- ❌ Bad: "Test various notification scenarios"
- ✅ Good: "Delete notification group, verify individual items remain accessible"
- ❌ Bad: "Test deletion feature"
- **Principle:** Specific, measurable operations that trigger the feature

#### 6. Focus Test Scenarios (Type B - Bug Fix)
- Always include defect verification scenario (reproduce original bug, confirm fixed)
- Always include regression scenario (related functionality still works)
- Include edge case scenario (prevent similar bugs)
- **Principle:** Bug fix testing is focused, not comprehensive

---

## SECTION 1: PROJECT & BUSINESS CONTEXT

### 1.1 Product Overview
Gather basic project information:

**Questions to ask:**
- What is the product name?
- What is this feature called?
- When is the target release?
- What version/milestone is this for?

**Template:**
```markdown
**Product:** [Product name]
**Feature:** [Feature name]
**Release Version:** [e.g., v2.5.0, Q4 2024]
**Target Release Date:** [YYYY-MM-DD]
```

### 1.2 Business Value
Understand WHY this feature exists:

**Questions to ask:**
- What business problem does this solve?
- What pain points does it address?
- What benefits do users get?
- Are there compliance or regulatory requirements?

**Template:**
```markdown
### Business Value
[Description of the problem being solved]

**User Benefits:**

| Benefit | Description |
|---------|-------------|
| [Benefit name] | [How it helps users] |
| [Benefit name] | [How it helps users] |
| [Benefit name] | [How it helps users] |
```

**Sources:**
- Feature request tickets
- Product requirements
- Customer feedback
- Confluence HLD documents

### 1.3 Stakeholders
Identify key people involved:

**Questions to ask:**
- Who designed the UX/UI? (UX Designer, UI Designer)
- Who implemented it? (Frontend/Backend Developers)
- Who is the QA Engineer?
- Who is the Product Owner?
- What is the customer reference or feature request ID?

**Template:**
```markdown
| Role | Name | Responsibility |
|------|------|----------------|
| UX Designer | [Name] | Design specifications and user experience |
| UI Developer | [Name] | Frontend implementation |
| Backend Developer | [Name] | Backend/API implementation |
| QA Engineer | [Name] | Test planning and execution |
| Product Owner | [Name] | Requirements and prioritization |
| Customer Reference | [Ticket ID] | Original feature request |
```

---

## SECTION 2: FEATURE DEFINITION

### 2.1 Core Functionality
Define WHAT the feature does:

**Questions to ask:**
- What is the Epic/Story ID?
- What is the Feature Request ID?
- What are the main features or sub-features?
- What are the acceptance criteria?
- Are there design mockups? (Figma, Adobe XD, Sketch)
- Is there an HLD document?

**Template:**
```markdown
**Epic:** [EPIC-12345](link)
**Feature Request:** [FR-1234](link)

#### Feature 1: [Feature Name]
- [Key behavior 1]
- [Key behavior 2]
- [When does this apply? What triggers it?]

#### Feature 2: [Feature Name]
- [Key behavior 1]
- [Key behavior 2]
```

**Sources:**
- Jira Epic/Story tickets
- Confluence HLD
- Figma designs
- Product requirements

### 2.2 Feature Control
Understand feature flags and settings:

**Questions to ask:**
- Is there a feature flag controlling this?
- What happens when the flag is ON?
- What happens when the flag is OFF?
- How do you enable/disable it?
- Are there user settings involved?
- Do settings persist across sessions?

**Template:**
```markdown
**Feature Flag:** `[feature-flag-name]`
- **When enabled:** [Behavior description]
- **When disabled:** [Behavior description]
- **Rollback mechanism:** [How to safely disable]

**User Settings:** [Yes/No]
- [Setting name]: [Description]
- **Persistence:** [Across browser sessions? Across devices?]
```

### 2.3 Non-Functional Requirements
Define quality attributes:

**Questions to ask:**
- What are the performance requirements?
- What are the usability requirements?
- Are there accessibility requirements?
- Are there security or scalability requirements?

**Template:**
```markdown
**Performance:**

| Requirement | Criteria |
|-------------|----------|
| Response time | [e.g., < 200ms] |
| Throughput | [e.g., handle 100+ items] |
| Animation quality | [e.g., smooth, no flickering] |

**Usability:**

| Requirement | Criteria |
|-------------|----------|
| Visual clarity | [e.g., clear state indicators] |
| Accessibility | [e.g., WCAG 2.1 AA compliance] |
| User control | [e.g., intuitive controls] |

**Other:**
- Security: [Requirements if any]
- Scalability: [Requirements if any]
```

---

## SECTION 3: SCOPE & BOUNDARIES

### 3.1 In-Scope Testing
Define what WILL be tested:

**Questions to ask:**
- What functional behaviors need testing?
- What UI/UX aspects need validation?
- What integrations need testing?
- Does the feature flag need testing?
- Are there performance requirements to validate?
- Are there accessibility requirements?

**Template:**
```markdown
| Test Category | Test Items |
|---------------|------------|
| **Functional Testing** | • [Behavior 1]<br>• [Behavior 2]<br>• [Behavior 3] |
| **UI/UX Testing** | • [Visual aspect 1]<br>• [Interaction 2] |
| **Integration Testing** | • [Component A + Component B]<br>• [System integration] |
| **Feature Flag Validation** | • [Flag ON behavior]<br>• [Flag OFF behavior] |
| **Performance Testing** | • [Performance requirement 1] |
| **Accessibility Testing** | • [WCAG requirement 1] |
```

### 3.2 Out of Scope
Define what will NOT be tested:

**Questions to ask:**
- What is explicitly excluded?
- Why is it excluded?
- Is it covered elsewhere?
- Are there known limitations?

**Template:**
```markdown
| Category | Excluded Items | Reason/Justification |
|----------|----------------|----------------------|
| [Category] | [Specific items] | [Why excluded] |
| [Category] | [Specific items] | [Covered by Epic XXX] |
```

### 3.3 Regression Testing
Define what existing features must still work:

**Questions to ask:**
- What existing features might be affected?
- What should remain unchanged when feature flag is OFF?
- What critical workflows must still function?

**Template:**
```markdown
**Regression Testing Requirements:**
- [Existing feature 1 that must still work]
- [Existing feature 2 that must still work]
- [Critical workflow that must remain intact]

**When feature flag is disabled:**
- [Behavior 1 should remain unchanged]
- [Behavior 2 should remain unchanged]
```

---

## SECTION 4: TEST STRATEGY

### 4.1 Test Levels
Define which test levels apply:

**Template:**
```markdown
| Level | Focus Areas |
|-------|-------------|
| **Component Testing** | • [Individual component behaviors] |
| **Integration Testing** | • [Component interactions]<br>• [System integrations] |
| **System Testing** | • [End-to-end workflows]<br>• [Complete user scenarios] |
| **User Acceptance Testing (UAT)** | • [Real-world scenarios]<br>• [Stakeholder validation] |
```

### 4.2 Test Types
Define test coverage priorities:

**Template:**
```markdown
| Test Type | Coverage | Priority |
|-----------|----------|----------|
| Functional | [Core feature behaviors] | High/Medium/Low |
| UI/UX | [Visual and interaction validation] | High/Medium/Low |
| Integration | [Component/system interactions] | High/Medium/Low |
| Regression | [Existing functionality] | High/Medium/Low |
| Performance | [Speed, responsiveness, scalability] | High/Medium/Low |
| Accessibility | [WCAG compliance, keyboard nav] | High/Medium/Low |
| Exploratory | [Edge cases, usability issues] | High/Medium/Low |
```

### 4.3 Test Approach
Define HOW testing will be performed:

#### Test Environment
**Questions to ask:**
- What is the test environment URL?
- What test account should be used?
- What test data is available or needed?
- What browser/resolution requirements exist?

**Template:**
```markdown
**Test Environment:**

| Parameter | Value |
|-----------|-------|
| URL | [Test environment URL] |
| Test Account | [username or role] |
| Test Data | [Available data or creation requirements] |
| Browser/Resolution | [Requirements, e.g., 1920x1080+] |
```

#### Critical Understanding
**Questions to ask:**
- What is the key principle for testing this feature?
- What operations are best suited for testing?
- What operations should be avoided? Why?

**Template:**
```markdown
**Critical Understanding:**
- [Key testing principle for this feature]
- [What makes a good test operation vs. poor test operation]
- [Any constraints or limitations to be aware of]
```

#### Priority Test Operations
**Questions to ask:**
- What are the 3-5 most important operations to test?
- How do users navigate to these operations?
- What is the expected behavior?
- What test volumes are appropriate? (small, medium, large)

**Template for each operation:**
```markdown
#### Operation #[N]: [Operation Name] ⭐⭐⭐⭐⭐

| Aspect | Details |
|--------|---------|
| **Operation** | [What user operation is this] |
| **Navigation** | [Step-by-step UI path: Menu → Submenu → Page] |
| **Expected Behavior** | [What should happen when user performs this operation] |
| **Why This Works** | [Why this operation is good for testing this feature] |
| **Example** | [Concrete example with specific values] |

**Test Volumes:**

| Scenario | Item Count | Threshold Status | Expected Behavior |
|----------|------------|------------------|-------------------|
| Below Threshold | [N items] | Below ([comparison]) | [Expected behavior] |
| At Threshold | [N items] | At threshold ([comparison]) | [Expected behavior] |
| Above Threshold | [N items] | Above ([comparison]) | [Expected behavior] |
```

### 4.4 Test Scenarios
Define high-level test scenarios (these become Test Suites):

**Questions to ask:**
- What are the major testing focuses?
- How should tests be grouped logically?
- What test activities belong in each scenario?
- How many test cases are expected per scenario?

**Template:**
```markdown
| ID | Test Scenario | Focus | Test Cases | Test Activities |
|----|---------------|-------|------------|-----------------|
| **TS-01** | [Scenario name] | [Focus area] | [Estimated #] | • [Activity 1]<br>• [Activity 2]<br>• [Activity 3] |
| **TS-02** | [Scenario name] | [Focus area] | [Estimated #] | • [Activity 1]<br>• [Activity 2] |
| **TS-03** | [Scenario name] | [Focus area] | [Estimated #] | • [Activity 1]<br>• [Activity 2] |

**Total Test Coverage:**
- **[N] Test Suites**
- **[N] Test Cases** (estimated)
- **Estimated Execution Time:** ~[N] minutes
- **Priority Distribution:** [N] P0 (Critical), [N] P1 (High), [N] P2 (Medium)
```

**Note:** These test scenarios will be expanded into detailed test cases in TEST_CASES.md

### 4.5 Test Data Setup (Optional)
If tests require special data preparation:

**Questions to ask:**
- Can test data be created via UI or API?
- Are there API endpoints for bulk data creation?
- What test data is needed for each test scenario?

**Template:**
```markdown
#### [Data Type] Setup for Testing

**Method 1: API Creation (Recommended)**

**API Endpoint:**
```
[HTTP METHOD] /api/path
```

**Request Payload Example:**
```json
{
  "field1": "value1",
  "field2": "value2"
}
```

**Test Data Guidelines:**
- [Guideline 1: e.g., naming convention]
- [Guideline 2: e.g., volume requirements]
- [Guideline 3: e.g., specific configurations]

**Method 2: UI Creation (Fallback)**
[Step-by-step manual creation process]
```

---

## SECTION 5: REFERENCES & RESOURCES

### 5.1 Design & Documentation
Gather all reference links:

**Questions to ask:**
- Where is the HLD document?
- Where are the design mockups? (Figma, Adobe XD)
- Is there a prototype?
- Where is the API documentation?
- What are the related Epic/Story tickets?

**Template:**
```markdown
| Resource | Link |
|----------|------|
| **Confluence HLD** | [Link to high-level design] |
| **Figma Design** | [Link to design specs] |
| **Figma Prototype** | [Link to interactive prototype] |
| **API Documentation** | [Link to API docs] |
| **Related Epic/Stories** | [Links to Jira tickets] |
```

### 5.2 Related Documentation (Optional)
**Template:**
```markdown
| Document | Link/Reference |
|----------|----------------|
| TEST_CASES.md | [Link when created] |
| Confluence Test Plan Page | [Page ID] |
| Confluence Test Cases Page | [Page ID] |
```

---

## OPTIONAL SECTIONS

### 6. Scheduling & Milestones (Optional)
If timeline is important:

**Template:**
```markdown
**Feature Availability:** [Date feature ready for testing]

**Key Milestones:**
- Test plan review: [Date]
- Test cases created: [Date]
- Test execution start: [Date]
- Test completion: [Date]
- Sign-off: [Date]
```

### 7. Entry & Exit Criteria (Optional)
If formal criteria are needed:

**Template:**
```markdown
**Entry Criteria:**
- [ ] Feature development complete
- [ ] Feature flag enabled in test environment
- [ ] Test environment accessible and stable
- [ ] Test data available or creatable

**Exit Criteria:**
- [ ] [X%] test pass rate achieved
- [ ] Critical defects (P0): 0 open
- [ ] High defects (P1): [N or fewer] open
- [ ] Test coverage: [X%] of requirements
- [ ] Stakeholder sign-off obtained
```

### 8. Risks & Contingency (Optional)
If risk assessment is needed:

**Template:**
```markdown
**Top Risks:**

| Risk | Impact | Probability | Mitigation Plan |
|------|--------|-------------|-----------------|
| [Risk 1] | High/Med/Low | High/Med/Low | [How to mitigate] |
| [Risk 2] | High/Med/Low | High/Med/Low | [How to mitigate] |

**Rollback Plan:**
- How to disable feature: [e.g., Toggle feature flag OFF]
- Communication plan: [Who to notify, how to notify]
- Verification steps: [How to verify rollback successful]
```

---

## OUTPUT FORMAT

The output format varies based on testing context type. Use the appropriate template:

---

### FORMAT A: NEW FEATURE TEST PLAN

Use this format for Type A (New Feature Testing):

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
### 3.3 Regression Testing

## 4. Test Strategy
### 4.1 Test Levels
### 4.2 Test Types
### 4.3 Test Approach
### 4.4 Test Scenarios
### 4.5 Test Data Setup (if applicable)

## 5. References & Resources
### 5.1 Design & Documentation
### 5.2 Related Documentation (optional)

## 6. Document Revision History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | YYYY-MM-DD | [Name] | Initial test plan |
```

---

### FORMAT B: BUG FIX TEST PLAN

Use this format for Type B (Bug Fix/Customer Problem Testing):

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
[Tests to ensure related functionality still works]

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
| **TS-02** | Regression Testing | Related functionality | 3-5 | • [Activities] |
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

### FORMAT C: ENHANCEMENT TEST PLAN

Use this format for Type C (Enhancement/Improvement Testing):

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

## 1. Enhancement Context

### 1.1 Enhancement Overview
**What's Being Enhanced:** [Existing feature being improved]
**Enhancement Summary:** [What's changing/being added]
**Business Value:** [Why this enhancement]

### 1.2 Stakeholders
[Key people - may be limited compared to new features]

## 2. Enhancement Definition

### 2.1 New/Changed Functionality
**What's New:**
- [New behavior 1]
- [New behavior 2]

**What's Changed:**
- [Changed behavior 1]
- [Changed behavior 2]

### 2.2 Existing Functionality (Unchanged)
**What Must Still Work:**
- [Existing behavior 1 that must remain intact]
- [Existing behavior 2 that must remain intact]

## 3. Test Scope

### 3.1 Enhancement Validation
[Tests for new/changed functionality]

### 3.2 Regression Validation
[Tests for existing functionality]

### 3.3 Integration Impact
[Tests for component interactions]

## 4. Test Strategy

### 4.1 Test Approach
**Dual Focus:**
1. Validate enhancement works as specified
2. Ensure existing functionality unaffected

### 4.2 Test Scenarios

| ID | Test Scenario | Focus | Est. Cases | Test Activities |
|----|---------------|-------|------------|-----------------|
| **TS-01** | Enhancement Verification | New/changed behavior | 4-6 | • [Activities] |
| **TS-02** | Existing Functionality | Unchanged behavior | 3-5 | • [Activities] |
| **TS-03** | Integration Impact | Component interactions | 2-4 | • [Activities] |

**Total:** [N] test scenarios, ~[N] test cases

## 5. References & Resources

| Resource | Link |
|----------|------|
| **Enhancement Ticket** | [Link] |
| **Original Feature Documentation** | [Link if available] |
| **Related Tickets** | [Links] |

## 6. Document Revision History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | YYYY-MM-DD | [Name] | Initial enhancement test plan |
```

---

## TIPS FOR AI AGENTS

### 1. Start with Documentation
- Ask user for Confluence HLD link first
- Look for Figma design links
- Review Jira Epic/Story tickets
- Gather all context before asking detailed questions

### 2. Ask Clarifying Questions
When information is unclear or missing:
- "I don't see information about [X] in the HLD. Can you provide details?"
- "Are there performance requirements for this feature?"
- "What operations trigger this feature?"

### 3. Prioritize Information
Focus on essential information first:
1. What is the feature?
2. What problem does it solve?
3. What operations test it?
4. What are the test scenarios?

Less critical information can come later.

### 4. Use Tables
Present information in tables for clarity:
- Stakeholders table
- Business benefits table
- Test types table
- Test scenarios table

### 5. Be Specific in Test Scenarios
Don't write vague scenarios like "Test the feature"
Instead write specific scenarios:
- "Threshold Testing (below, at, above threshold)"
- "High Volume Testing (100+ items)"
- "Feature Flag Validation (ON vs OFF)"

### 6. Think About Test Variations
For each test operation, consider:
- Small volume (below threshold)
- Medium volume (moderate scale)
- Large volume (stress test)
- Edge cases (empty, maximum, boundary values)
- Error conditions (invalid input, permissions)

### 7. Connect Test Plan to Test Cases
Remember that § 4.4 Test Scenarios will become Test Suites in TEST_CASES.md:
- Each TS-XX = one Test Suite
- Test Activities = high-level description of test cases
- Keep test scenarios high-level (WHAT to test)
- Save detailed steps for TEST_CASES.md (HOW to test)
```
