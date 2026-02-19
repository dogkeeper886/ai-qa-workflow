# Project Initialization Reference

## Optional: Initialize Test Scaffolding

After the core project structure is created, optionally scaffold test planning folders:

```
[TICKET]_[Short_Description]/
├── test_plan/
│   ├── README.md             # Test plan index
│   └── sections/
│       ├── 01_Project_Business_Context.md
│       ├── 02_Feature_Definition.md
│       ├── 03_Scope_Boundaries.md
│       ├── 04_Test_Strategy.md
│       ├── 05_References_Resources.md
│       └── 06_Revision_History.md
└── test_cases/
    └── README.md             # Test case index
```

## test_plan/README.md Template

```markdown
# Test Plan: [JIRA-ID] - [Short Description]

**Test Plan Type:** New Feature Validation
**Test Plan Version:** 1.0
**Created:** [Date]
**Last Updated:** [Date]
**QA Engineer:** [Name]

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

- **Total Test Scenarios:** TBD
- **Estimated Test Cases:** TBD
- **Feature Flag:** TBD
- **Minimum Firmware:** TBD
```

## test_cases/README.md Template

```markdown
# Test Cases: [JIRA-ID] - [Short Description]

**Version:** 1.0
**Created:** [Date]
**QA Engineer:** [Name]

---

## Test Scenarios

| File | Test Scenario | Test Cases |
|------|---------------|------------|
| TS-01_*.md | TBD | TC-01 to TC-XX |
| TS-02_*.md | TBD | TC-01 to TC-XX |

---

## Test Case Numbering

- Each scenario file uses independent TC numbering (TC-01, TC-02, etc.)
- Full ID format: `TS-XX-TC-YY` (e.g., TS-01-TC-01)

---

## Related Documentation

- [Test Plan](../test_plan/README.md)
- [HLD Document](../confluence/)
```

## Notes

- Only scaffold these folders when the user explicitly requests project initialization
- Do NOT create empty scenario files (TS-XX_*.md) — these are created during /designing-cases
- Update README.md as project progresses
- Use `/planning-tests` to fill in the test plan sections
