# Command Review — Quality Audit for Slash Commands

```
Review one or more slash command files against industry best practices and project conventions.

Arguments: {{input}}
  - (empty)           Review ALL commands in .claude/commands/
  - <path>            Review a specific command file (e.g., test-workflow/tw-case-review.md)
  - <folder>          Review all commands in a subfolder (e.g., test-workflow, testlink)
  - --fix             Auto-fix issues after presenting the report (with user confirmation)

Examples:
  /command-review
  /command-review test-workflow/tw-case-review.md
  /command-review testlink
  /command-review --fix
```

## Purpose

Audit slash command files for quality, consistency, and alignment with industry best practices (IEEE 829, ISTQB, ISO/IEC 29119). Ensures commands are clear, scannable, complete, and maintainable.

## Review Profile

Like test reviews, command reviews scale by scope:

| Scope | Profile | Depth |
|-------|---------|-------|
| Single file | **Deep** | All 8 quality dimensions, line-level issues |
| Subfolder | **Standard** | All 8 dimensions, file-level summary per command |
| All commands | **Overview** | Aggregate scores, cross-cutting issues, top offenders |

---

## Agent Instructions

### Step 1: Determine Scope and Profile

```
1. Parse arguments:
   - No arguments → Overview profile, scan all .claude/commands/**/*.md
   - Path to file → Deep profile, audit that single file
   - Folder name → Standard profile, audit all *.md in that subfolder

2. Collect target files:
   - Glob: .claude/commands/<scope>/**/*.md or .claude/commands/<scope>/*.md
   - Count total files to review
   - Announce: "Reviewing X command(s) — Profile: [Deep/Standard/Overview]"
```

### Step 2: Read Command Files

```
Deep profile:    Read the full target file
Standard profile: Read all files in the target subfolder
Overview profile: Read all files across all subfolders
```

### Step 3: Evaluate Quality Dimensions

Evaluate each command against **8 quality dimensions**. Each dimension has checklist items and is scored: Pass / Partial / Fail.

---

#### D1: Structure & Sections

Every command should have a consistent, scannable structure.

**Required sections** (in order):

| # | Section | Purpose | Required? |
|---|---------|---------|-----------|
| 1 | **Title** | `# Command Name` — clear, descriptive | Always |
| 2 | **Purpose** | What this command does and why | Always |
| 3 | **When to Use** | Trigger conditions, prerequisites | Always |
| 4 | **Agent Instructions** | Step-by-step processing logic | Always |
| 5 | **Output Format** | Expected output structure/template | Always |
| 6 | **Example Usage** | Concrete input → output example | Always |
| 7 | **Common Issues** | Error handling, known pitfalls | When integrating external tools/APIs |
| 8 | **Workflow Position** | Where this command fits in the lifecycle | When part of a multi-step workflow |

**Checklist:**
- [ ] All required sections present
- [ ] Sections appear in the standard order
- [ ] Section headers use consistent capitalization (Title Case or Sentence case — not mixed)
- [ ] No orphan content outside of a section

---

#### D2: Clarity & Specificity

Instructions must be precise enough for an AI agent to execute without ambiguity.

**Checklist:**
- [ ] Steps use specific file paths, field names, and tool names (not "read the file" but "read test_plan/sections/04_Test_Strategy.md § 4.4")
- [ ] Conditional logic is explicit ("IF type is Feature THEN..." not "handle accordingly")
- [ ] Vague verbs are avoided: "handle", "process", "deal with", "manage", "address"
- [ ] Each step produces a clear, verifiable output
- [ ] MCP tool names are spelled out when the command calls external tools

**Good:** "Read `test_plan/sections/04_Test_Strategy.md` § 4.4 and extract the Test Scenarios table"
**Bad:** "Read the test plan and find the relevant scenarios"

---

#### D3: Decision Logic

Commands with conditional paths must document their decision trees explicitly.

**Checklist:**
- [ ] Every IF/ELSE branch is documented (not left implicit)
- [ ] Decision criteria are specific and testable
- [ ] Fallback/default paths are defined
- [ ] No hidden assumptions ("if the user wants..." — what triggers this?)

**When to flag:**
- Command has 2+ conditional paths but no decision tree or IF/THEN blocks
- Steps say "depending on..." without specifying the conditions
- Output varies by input type but only one output template is shown

---

#### D4: Examples & Templates

Concrete examples prevent misinterpretation and reduce errors.

**Checklist:**
- [ ] At least one complete input → output example
- [ ] Example uses realistic data (not "foo", "bar", "test123")
- [ ] Output template shows the actual structure (not just a description)
- [ ] For commands with multiple modes/types, each mode has an example or template

**Good:** Full markdown output template with placeholder values that mirror real usage
**Bad:** "Output will be a summary of the findings"

---

#### D5: Error Handling

Commands that interact with external systems must handle failures gracefully.

**Checklist:**
- [ ] Common error scenarios are listed with solutions
- [ ] Missing prerequisite handling is defined (what to do if input doesn't exist)
- [ ] Partial failure paths are handled (e.g., 3 of 5 pages created successfully)
- [ ] User-facing error messages are clear and actionable

**Applicability:**
- **Required** for: TestLink (`tl-*`), Confluence (`cf-*`), Jira (`jr-*`), GitHub (`gh-*`), browser automation
- **Optional** for: Pure documentation commands (`tw-*`, `pm-*`) that only read/write local files

---

#### D6: Consistency with Project Conventions

Commands must follow the project's established patterns.

**Checklist:**
- [ ] File naming follows the `prefix-name.md` convention
- [ ] References to other commands use the correct `/prefix-name` format
- [ ] Ticket ID formats match project conventions (PROJ-NNNNN, FR-NNNN)
- [ ] File path references match the repository structure documented in CLAUDE.md
- [ ] HTML formatting rules followed for TestLink content (no `\n`, use `<p>`, entities)
- [ ] Terminology is consistent with CLAUDE.md and other commands in the same domain

---

#### D7: Scannability & Navigation

Commands are long reference documents — they must be easy to scan.

**Checklist:**
- [ ] Steps are numbered, not buried in prose
- [ ] Tables are used for structured data (not bullet lists of key-value pairs)
- [ ] Code blocks are used for file paths, tool calls, and output templates
- [ ] Visual separators (`---`) between major sections
- [ ] Long commands (>100 lines) have a workflow position diagram or table of contents

---

#### D8: Maintainability

Commands should be easy to update as the project evolves.

**Checklist:**
- [ ] No hardcoded values that will drift (specific page IDs, user names, dates)
- [ ] References to other commands/files use relative paths
- [ ] No duplicated content that exists in another command (reference it instead)
- [ ] Version or revision date noted for complex commands
- [ ] Single-responsibility: command does one thing well, not multiple unrelated tasks

---

### Step 4: Score and Classify Issues

For each command, assign a dimension score:

| Score | Meaning |
|-------|---------|
| **Pass** | All checklist items satisfied |
| **Partial** | Most items satisfied, minor gaps |
| **Fail** | Key items missing, impacts usability |

Classify each issue by severity:

| Severity | Definition | Action |
|----------|-----------|--------|
| **Critical** | Command will produce wrong output or fail silently | Must fix |
| **Major** | Command works but is ambiguous, inconsistent, or hard to follow | Should fix |
| **Minor** | Style, formatting, or nice-to-have improvements | Optional |

### Step 5: Cross-Cutting Analysis (Standard / Overview only)

For multi-file reviews, identify patterns across commands:

```
1. Section naming consistency — are headers capitalized the same way?
2. Example coverage — which commands lack examples?
3. Error handling gaps — which integration commands lack error handling?
4. Workflow position coverage — which workflow commands lack position diagrams?
5. Terminology drift — same concept described differently across commands?
6. Duplicated content — same instructions copy-pasted in multiple commands?
```

### Step 6: Generate Report

---

## Output Format

### Deep Profile (Single Command)

```markdown
# Command Review: [command-name]

**File:** `.claude/commands/[path]`
**Lines:** XXX
**Profile:** Deep

## Dimension Scores

| Dimension | Score | Issues |
|-----------|-------|--------|
| D1: Structure & Sections | Pass / Partial / Fail | X issues |
| D2: Clarity & Specificity | Pass / Partial / Fail | X issues |
| D3: Decision Logic | Pass / Partial / Fail | X issues |
| D4: Examples & Templates | Pass / Partial / Fail | X issues |
| D5: Error Handling | Pass / Partial / Fail | X issues |
| D6: Project Conventions | Pass / Partial / Fail | X issues |
| D7: Scannability | Pass / Partial / Fail | X issues |
| D8: Maintainability | Pass / Partial / Fail | X issues |

## Issues Found

### Critical

| # | Dimension | Location | Issue | Suggested Fix |
|---|-----------|----------|-------|---------------|
| 1 | D2 | Step 3 | "Process the data accordingly" — ambiguous | Specify exact processing steps |

### Major

| # | Dimension | Location | Issue | Suggested Fix |
|---|-----------|----------|-------|---------------|
| 1 | D1 | — | Missing "When to Use" section | Add trigger conditions |
| 2 | D4 | — | No example usage | Add input → output example |

### Minor

| # | Dimension | Location | Issue | Suggested Fix |
|---|-----------|----------|-------|---------------|
| 1 | D7 | Line 45 | Data in bullet list, better as table | Convert to table |

## Overall Assessment

**Quality:** Good / Fair / Needs Work
**Recommendation:** APPROVED / NEEDS REVISION

[Summary with specific next steps]
```

### Standard Profile (Subfolder)

```markdown
# Command Review: [folder-name]/ (X commands)

**Profile:** Standard

## Summary Scorecard

| Command | D1 | D2 | D3 | D4 | D5 | D6 | D7 | D8 | Issues |
|---------|----|----|----|----|----|----|----|----|--------|
| cmd-a   | ✓  | ✓  | ~  | ✗  | —  | ✓  | ✓  | ✓  | 2 |
| cmd-b   | ✓  | ~  | ✓  | ✓  | ✗  | ✓  | ~  | ✓  | 3 |

Legend: ✓ Pass, ~ Partial, ✗ Fail, — Not applicable

## Cross-Cutting Issues

[Patterns found across multiple commands in this folder]

## Per-Command Issues

### [command-a]

| Severity | Dimension | Issue | Fix |
|----------|-----------|-------|-----|
| Major | D4 | No example | Add example |

### [command-b]
...

## Recommendations

1. [Highest-impact fix across the folder]
2. [Second-highest-impact fix]
```

### Overview Profile (All Commands)

```markdown
# Command Review: All Commands (X total)

**Profile:** Overview

## Health Summary

| Folder | Commands | Avg Score | Critical | Major | Minor |
|--------|----------|-----------|----------|-------|-------|
| test-workflow | 14 | 85% | 0 | 3 | 5 |
| testlink | 18 | 78% | 1 | 5 | 4 |
| confluence | 6 | 80% | 0 | 2 | 3 |
| jira | 7 | 82% | 0 | 2 | 2 |
| project | 8 | 72% | 0 | 4 | 3 |
| github | 4 | 75% | 0 | 2 | 1 |
| utility | 4 | 70% | 0 | 3 | 2 |

## Dimension Heatmap

| Dimension | test-workflow | testlink | confluence | jira | project | github | utility |
|-----------|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| D1: Structure | ✓ | ~ | ✓ | ✓ | ~ | ~ | ~ |
| D2: Clarity | ✓ | ✓ | ~ | ✓ | ~ | ✓ | ~ |
| D3: Decisions | ✓ | ~ | ~ | ✓ | ✗ | ~ | ✓ |
| D4: Examples | ~ | ✓ | ~ | ~ | ✗ | ✗ | ~ |
| D5: Errors | — | ✓ | ~ | ✓ | — | ~ | — |
| D6: Conventions | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| D7: Scannability | ✓ | ~ | ~ | ~ | ~ | ~ | ~ |
| D8: Maintainability | ✓ | ~ | ✓ | ✓ | ~ | ✓ | ~ |

## Top 5 Issues (Highest Impact)

| # | Scope | Issue | Affected Commands | Fix |
|---|-------|-------|-------------------|-----|
| 1 | ... | ... | ... | ... |

## Recommendations

### Immediate (Apply to All)
1. [Standardization fix]

### Per-Folder
1. [Folder-specific fix]
```

---

## Industry Standards Referenced

This review command evaluates against principles from:

| Standard | Aspect Applied |
|----------|---------------|
| **IEEE 829** | Test documentation structure and completeness |
| **ISTQB Foundation** | Test design clarity, traceability, independence |
| **ISO/IEC 29119-3** | Test documentation templates and required fields |
| **ISO/IEC 25010** | Software quality model — usability, maintainability |
| **Technical Writing Best Practices** | Scannability, progressive disclosure, examples-first |

---

## When to Use

- After creating or significantly updating a command file
- During periodic maintenance (quarterly)
- Before onboarding new team members to the workflow
- When commands produce unexpected or inconsistent results
- After running `/evolve` to validate suggested improvements

## Workflow Position

```
┌─────────────────────────────────────────────────────────────────┐
│                    COMMAND MAINTENANCE WORKFLOW                   │
└─────────────────────────────────────────────────────────────────┘

/evolve
    └── Detects patterns from git history → suggests improvements
                              ↓
              ┌───────────────────────────────┐
              │  /command-review  ◄── YOU     │
              │  Audits command quality       │
              │  Scores 8 dimensions          │
              └───────────────────────────────┘
                              ↓
Manual edits or /command-review --fix
    └── Apply fixes to command files
```
