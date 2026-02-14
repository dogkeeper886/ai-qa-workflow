# Demo Project: Dark Mode Toggle (DEMO-123)

This folder contains simulated project files and a video script for the AI QA Workflow YouTube showcase.

## Project Summary

**Ticket:** DEMO-123 — Add dark mode toggle to user settings page
**Type:** Story (New Feature)
**Epic:** DEMO-100 — User Preferences Redesign

## Files

| File | Description |
|------|-------------|
| `00_Main_Task_DEMO-123.md` | Simulated Jira ticket with acceptance criteria |
| `confluence/HLD_Dark_Mode_Toggle.md` | Simulated High Level Design document |

## v1.0 Command Files

The `v1_commands/` folder contains the original monolithic commands for comparison in the video:

| File | Lines | Description |
|------|-------|-------------|
| `jira-trace.md` | 209 | Original single-file Jira trace command |
| `test-planning-checklist.md` | 1,271 | Original all-in-one test planning command |
| `test-case-design-checklist.md` | 814 | Original all-in-one test case design command |

**Total: 3 files, 2,294 lines** — replaced by 53 focused commands across 6 folders.

## Example Command Outputs

| File | Command | Description |
|------|---------|-------------|
| `examples/01_tw-plan-init_output.md` | `/tw-plan-init` | Detection: Type A New Feature |
| `examples/02_tw-plan-feature_output.md` | `/tw-plan-feature` | Test plan with 6 scenarios |
| `examples/03_tw-plan-review_output.md` | `/tw-plan-review` | Coverage matrix, status READY |
| `examples/04_tw-case-feature_output.md` | `/tw-case-feature` | Example test cases (TS-01, TS-02) |
| `examples/05_tw-case-review_output.md` | `/tw-case-review` | Quality check passed |

## Video Script

See `script.md` for the full spoken script (~13-14 minutes). The script covers all three orchestration patterns (sequential pipeline, fan-out router, smart diff) across the full command set — not just the test-workflow family.
