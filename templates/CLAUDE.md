## AI QA Workflow

This section provides AI coding agents with QA workflow guidance powered by MCP integrations.

> **Note:** The QA test workflow (ticket intake, test planning, case design) is being migrated to a forthcoming `qa-workflow` command group. The commands below cover TestLink management and project/demo tasks; structured development uses the `dw-*` dev-workflow commands.

### Skills

Skills are loaded on demand. Use the matching skill when the trigger condition applies.

| Skill | Trigger Condition |
|-------|-------------------|
| `syncing-testlink` | When test cases need to be imported into TestLink |

### Test Lifecycle

| Phase | Skill | Key Commands |
|-------|-------|--------------|
| Manage | `syncing-testlink` | `/tl-create-suite`, `/tl-create-case`, `/tl-create-plan` |
| Execute | — | `/tl-execute-case`, `/tl-create-execution` |

### MCP Dependencies

These MCP servers must be configured:
- **testlink-mcp** — TestLink API access
- **playwright-mcp** — Browser automation (optional)

### Available Commands

**TestLink (tl-*):** `/tl-list-projects`, `/tl-create-suite`, `/tl-list-suites`, `/tl-update-suite`, `/tl-create-case`, `/tl-get-case`, `/tl-list-cases`, `/tl-update-case`, `/tl-identify-type`, `/tl-create-plan`, `/tl-get-cases-for-plan`, `/tl-add-case-to-plan`, `/tl-execute-case`, `/tl-read-execution`, `/tl-create-execution`, `/tl-format`, `/tl-sync`, `/tl-list-requirements`

**Project (pm-*):** `/pm-init`, `/pm-demo-content`, `/pm-demo-review`, `/pm-demo-ppt`, `/pm-demo-email`, `/pm-meeting-invite`, `/pm-bug-report`

**Utility:** `/rewrite-text`, `/robot-log-analyzer`
