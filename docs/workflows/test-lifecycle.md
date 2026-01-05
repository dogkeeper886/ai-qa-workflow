# Complete Test Lifecycle Workflow

This document describes the end-to-end QA workflow powered by AI coding agents and MCP (Model Context Protocol) integrations.

## Philosophy: Single Source of Truth

Everything starts with a **single source of truth** idea. Instead of manually copying information between systems, we use AI coding agents with MCP integrations to:

1. **Access** documentation systems directly (Jira, Confluence)
2. **Trace** requirements and related information automatically
3. **Generate** test plans and test cases from requirements
4. **Create** tests in test management systems (TestLink)
5. **Execute** automated tests with the test framework
6. **Report** results back to the source systems

This eliminates duplication, reduces human error, and maintains traceability from requirement to test execution.

## Workflow Overview

| Phase | Name | Tool | Output |
|-------|------|------|--------|
| 1 | Discover | MCP Atlassian, /jira-trace | Requirements folder |
| 2 | Plan | /test-planning-checklist | TEST_PLAN.md |
| 3 | Design | /test-case-design-checklist | TEST_CASES.md |
| 4 | Manage | MCP TestLink | TestLink entries |
| 5 | Automate | test-framework-template | YAML test files |
| 6 | Execute | npm test, CI/CD | Test results |

## Prerequisites

### Required MCP Integrations

| Integration | Purpose | Repository |
|-------------|---------|------------|
| **MCP Atlassian** | Access Jira and Confluence | [sooperset/mcp-atlassian](https://github.com/sooperset/mcp-atlassian) |
| **MCP TestLink** | Manage tests in TestLink | [dogkeeper886/testlink-mcp](https://github.com/dogkeeper886/testlink-mcp) |
| **MCP Playwright** | Browser automation (optional) | [microsoft/playwright-mcp](https://github.com/microsoft/playwright-mcp) |

### Required Tools

| Tool | Purpose | Repository |
|------|---------|------------|
| **AI QA Workflow** | Commands for each phase | [dogkeeper886/ai-qa-workflow](https://github.com/dogkeeper886/ai-qa-workflow) |
| **Test Framework Template** | Dual-judge test execution | [dogkeeper886/test-framework-template](https://github.com/dogkeeper886/test-framework-template) |

### Setup

1. Install MCP integrations (see [docs/integrations/](../integrations/))
2. Install AI QA Workflow commands: make install
3. Install test framework to your project (see Phase 5)

## Phase 1: Discover Requirements

**Goal:** Gather all relevant information from documentation systems.

### Using MCP Atlassian

The MCP Atlassian integration provides direct access to Jira and Confluence:

- jira_get_issue - Get issue details with comments
- jira_search - Search issues with JQL
- confluence_get_page - Get page content
- confluence_search - Search pages

### Using the Trace Command

The /jira-trace command automates requirement gathering:

    /jira-trace PROJ-123

This command:
1. Fetches the main ticket with all fields and comments
2. Finds related tickets (parent, children, linked issues)
3. Detects and fetches linked Confluence documents
4. Creates organized folder structure with all information

**Output Structure:**

    PROJ-123_Feature_Name/
      00_Main_Task_PROJ-123.md
      01_Parent_PROJ-100.md
      01_Child_PROJ-124.md
      confluence/
        Design_Document.md
        confluence_links.md
      README.md
      Ticket_Relationship_Diagram.md

## Phase 2: Create Test Plan

**Goal:** Develop a strategic test plan based on requirements.

### Using the Test Planning Command

    /test-planning-checklist

This command guides you through creating a comprehensive TEST_PLAN.md:

1. **Detect Context Type:** New Feature (A), Bug Fix (B), or Enhancement (C)
2. **Gather Information:** Scope, environment, resources, timeline
3. **Define Test Strategy:** Test levels, types, entry/exit criteria, risks

### Human Review Point

**Important:** The test plan should be reviewed by QA Lead, Dev Lead, and Product Owner.

*Future: An assistant command will help automate this review process.*

## Phase 3: Design Test Cases

**Goal:** Create detailed test cases from the test plan.

### Using the Test Case Design Command

    /test-case-design-checklist

This command transforms TEST_PLAN.md into detailed TEST_CASES.md with:
- Unique IDs (e.g., TC-BUILD-001)
- Clear titles and descriptions
- Preconditions and step-by-step instructions
- Expected results and priority

### Test Case Naming Convention

    TC-[SUITE]-[OPERATION]-[VARIANT]
    
    Examples:
    - TC-BUILD-001-INSTALL-DEPS
    - TC-API-002-CREATE-USER
    - TC-GUI-003-LOGIN-SUCCESS

### Identify Test Type

Use /identify-test-type to categorize:
- **[GUI]**: UI validation tests
- **[API]**: API operation tests
- **[Other]**: Database, performance, security tests

## Phase 4: Manage Tests in TestLink

**Goal:** Import test cases into TestLink for tracking and execution.

### TestLink Commands

**Project and Suite Management:**
- /list-projects - List all projects
- /list-test-suites - List suites in project
- /create-test-suite - Create new suite

**Test Case Management:**
- /create-test-case - Create test case
- /get-test-case - Retrieve test case
- /update-test-case - Update test case

**Test Plan Management:**
- /create-test-plan - Create test plan
- /add-test-case-to-test-plan - Assign case to plan

**Execution:**
- /create-test-execution - Record execution result
- /read-test-execution - Get execution details

## Phase 5: Automate with Test Framework

**Goal:** Create executable test scripts using the dual-judge test framework.

### Install Test Framework

    # Clone the template
    git clone https://github.com/dogkeeper886/test-framework-template
    
    # Install to your project
    cd test-framework-template
    make install TARGET=/path/to/your/project NAME=your-project
    
    # Setup in your project
    cd /path/to/your/project/cicd/tests
    npm install

### Create YAML Test Cases

Map TestLink test cases to YAML format:

    # cicd/tests/testcases/build/TC-BUILD-001.yml
    
    id: TC-BUILD-001
    name: Project Build Verification
    suite: build
    priority: 1
    timeout: 120000
    dependencies: []
    
    steps:
      - name: Install dependencies
        command: npm install
        timeout: 60000
    
      - name: Run build
        command: npm run build
        timeout: 90000
        rejectPatterns:
          - "error"
          - "failed"
    
    criteria: |
      Verify that the project builds successfully:
      - npm install completes without errors
      - npm run build completes without errors

### Test Framework Features

| Feature | Description |
|---------|-------------|
| **Dual-Judge System** | Simple (exit codes, patterns) + LLM (semantic analysis) |
| **YAML-Driven** | Tests defined as configuration, not code |
| **Dependencies** | Tests can depend on other tests |
| **Log Collection** | Docker log collection with markers |
| **CI/CD Ready** | GitHub Actions workflows included |

### Mapping TestLink to YAML

| TestLink Field | YAML Field |
|----------------|------------|
| Test Case ID | id |
| Test Case Name | name |
| Test Suite | suite |
| Priority | priority |
| Preconditions | dependencies |
| Test Steps | steps |
| Expected Results | criteria + expectPatterns |

## Phase 6: Execute and Report

**Goal:** Run tests and report results back to systems.

### Run Tests Locally

    cd your-project/cicd/tests
    
    # Run all tests with LLM judge
    npm test
    
    # Run without LLM (faster)
    npm test -- --no-llm
    
    # Run specific suite
    npm test -- --suite build
    
    # Output as JSON
    npm test -- --format json

### Run in CI/CD

The framework includes GitHub Actions workflows:
- .github/workflows/test-pipeline.yml - Runs: build -> integration -> e2e
- .github/workflows/test-suite.yml - Runs individual suite

### Report Results to TestLink

After execution, record results:

    /create-test-execution

Provide: Test case ID, Test plan ID, Build ID, Status (p/f/b), Notes

## Complete Workflow Example

### Scenario: New Feature "User Authentication"

**1. Discover (Phase 1)**

    /jira-trace AUTH-100

Creates folder with requirements, design docs, related tickets

**2. Plan (Phase 2)**

    /test-planning-checklist

Creates TEST_PLAN.md with strategy for auth testing

**3. Design (Phase 3)**

    /test-case-design-checklist

Creates TEST_CASES.md with detailed test cases

**4. Manage (Phase 4)**

    /create-test-suite    -> Create "Authentication Tests" suite
    /create-test-case     -> Create TC-AUTH-001, TC-AUTH-002, etc.
    /create-test-plan     -> Create "Auth Release 1.0" plan
    /add-test-case-to-test-plan -> Assign cases to plan

**5. Automate (Phase 5)**

    # Create YAML test files
    vim cicd/tests/testcases/integration/TC-AUTH-001.yml
    vim cicd/tests/testcases/e2e/TC-AUTH-002.yml

**6. Execute (Phase 6)**

    npm test -- --suite integration
    npm test -- --suite e2e
    /create-test-execution  -> Record results in TestLink

## Summary

| Phase | Action | Tool/Command |
|-------|--------|--------------|
| 1. Discover | Gather requirements | MCP Atlassian, /jira-trace |
| 2. Plan | Create test strategy | /test-planning-checklist |
| 3. Design | Write test cases | /test-case-design-checklist |
| 4. Manage | Import to TestLink | MCP TestLink, /create-test-case |
| 5. Automate | Create YAML tests | test-framework-template |
| 6. Execute | Run and report | npm test, /create-test-execution |

This workflow maintains **traceability** from requirement to execution, eliminates **duplication** through MCP integrations, and enables **automation** with the dual-judge test framework.
