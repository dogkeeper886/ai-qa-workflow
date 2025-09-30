# Test Planning Checklist

```
Use this comprehensive checklist to gather all information needed for a robust test plan:

{{input}}

## 1. Project & Business Context
- What is the product name and target release version?
- What business value or user benefit does this feature deliver?
- Are there any regulatory or compliance requirements?
- Who are the primary stakeholders and sign-off process?

## 2. Feature Definition
- What is the user story/epic ID and acceptance criteria?
- What are the high-level functional flows?
- What are the non-functional expectations (performance, scalability, security, accessibility)?
- Has a risk register been created for this feature?

## 3. Scope & Boundaries
- Which parts of the system are in-scope for testing?
- What is explicitly out of scope?
- Will regression testing be required on previously released features?

## 4. Test Strategy
- Which test levels will be executed: unit, integration, system, acceptance?
- What test types will be applied: functional, regression, performance, security, usability?
- Will you automate any portion of the tests? Which tools/approaches?
- Will exploratory or ad-hoc testing be part of the plan?

## 5. Environment & Setup
- What environment(s) will be used (dev, stg, UAT, prod-clone)?
- What configuration or feature flags must be enabled/disabled?
- Do you have a copy-of-production data set or way to seed test data?
- Are any external services (payment gateways, APIs) mocked or stubbed?

## 6. Resources & Roles
- Who will be writing, reviewing, and executing test cases?
- What tools will the team need (test-management, defect tracker, CI, monitoring)?
- Do you have a RACI matrix for test-related responsibilities?

## 7. Scheduling & Milestones
- When does the feature become available for testing?
- What are the key milestones (test-case review, test-data setup, execution, defect triage, sign-off)?
- Do you require daily/weekly status report cadence?

## 8. Entry & Exit Criteria
- What pre-conditions must be met before tests can start?
- What constitutes a "complete" test cycle (pass rate, defect closure, coverage)?

## 9. Defect Management
- What is the defect severity/priority matrix?
- How will defects be logged, tracked, and closed?
- Who owns defect investigation and resolution?

## 10. Risks & Contingency
- What are the top three risks you foresee (technical, schedule, resource)?
- What mitigations are in place, and what is the rollback plan?

## 11. Metrics & Reporting
- Which metrics will you track (test case coverage, defect density, defect aging, pass rate)?
- Who will receive status reports, and through what channel?

Answer these questions to create a clear, actionable test plan that keeps everyone aligned and the feature on track.
```
