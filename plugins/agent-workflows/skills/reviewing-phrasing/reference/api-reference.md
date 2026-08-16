# API, CLI, and Tool Reference Docs

## Contents

- Reference vs guide
- Structure of a reference entry
- Describing parameters
- Documenting errors
- CLI documentation
- MCP tool and agent-facing docs
- Schema and data model docs
- Review checklist

## Reference vs guide

Reference documentation is consulted, not read. Its reader already knows what they want and is looking for one fact: the parameter name, the accepted values, the error meaning.

This inverts most writing advice. Reference entries are exhaustive rather than concise, uniform rather than varied, and complete in isolation rather than building on earlier sections. A reader jumping straight to one entry must find everything needed there.

Keep guides separate. A guide teaches a workflow across several calls; a reference documents one surface exhaustively. Mixing them makes the guide too long to follow and the reference too narrative to scan.

## Structure of a reference entry

Every entry, without exception, carries the same sections in the same order:

```
### <name>

<one-line statement of what it does>

<longer description if behavior is non-obvious — when to use it, what it costs>

**Parameters**
<table>

**Returns**
<type and shape, with field meanings>

**Errors**
<table>

**Example**
<request and response>
```

Uniformity is the feature. A reader who has read one entry knows exactly where to look in every other one. Omitting a section because it seems empty ("this one can't fail") breaks the pattern and forces the reader to determine whether it was omitted or forgotten — write "None." instead.

## Describing parameters

Tables, with a fixed column set:

| Parameter | Type | Required | Default | Description |
|---|---|---|---|---|
| `project_id` | integer | Yes | — | Numeric TestLink project ID. Obtain from `list_projects`. |
| `importance` | integer | No | `2` | Priority level. One of `1` (high), `2` (medium), `3` (low). |
| `timeout` | integer | No | `30` | Seconds before the call aborts. Maximum `300`. |

Requirements for the description column:

- **Enumerate accepted values** when the set is closed. `importance: integer` is useless; the enumeration is the whole content.
- **State units** for every number: seconds, bytes, records.
- **State bounds** — maximum, minimum, maximum length.
- **Say where the value comes from** when it is opaque. An ID parameter should name the call that yields it.
- **Note interactions** between parameters: mutually exclusive, required together, one ignored when another is set.
- **Describe the default's behavior**, not just its value, when the two differ — `null` meaning "inherit from project settings" must be said.

## Documenting errors

The error table is the most consulted part of any reference and the most commonly neglected. Readers arrive at documentation *because* something failed.

| Code | Meaning | Resolution |
|---|---|---|
| `INVALID_FIELD` | A field value fell outside its accepted set | Check accepted values in the parameter table; correct and resubmit |
| `PROJECT_NOT_FOUND` | No project matches `project_id` | Call `list_projects` to obtain a valid ID |
| `AUTH_FAILED` | API key missing, expired, or lacking permission | Regenerate the key in user settings; verify project-level access |

Each row needs a resolution, not just a restatement of the code. "`AUTH_FAILED`: authentication failed" is a tautology and helps no one.

Document partial failure explicitly for anything that operates in batch: which items applied, whether the operation is atomic, whether a retry is safe. Idempotency and retry semantics belong in the reference, not folklore.

## CLI documentation

Same skeleton per command: synopsis, description, options table, exit codes, examples.

```
## validate

    testcase-validator validate [OPTIONS] --project <name> --file <path>

Validates a test case payload field-by-field before any write occurs.
```

- **Synopsis notation must be consistent**: `<required>`, `[optional]`, `a|b` for exclusive choice, `...` for repeatable.
- **Document exit codes.** Scripts branch on them, and an undocumented exit code is an unusable one. `0` success, `1` validation failure, `2` usage error — say which is which.
- **Note what reaches stdout versus stderr**, since pipelines depend on the split.
- **Document global options once**, in a shared section, and reference it — repeating `--verbose` under twenty commands guarantees the copies drift.
- **Show one realistic example per command**, plus its output.

## MCP tool and agent-facing docs

Documentation read by a model has a constraint human docs lack: the tool description and parameter schema are the *only* things visible at call time. Anything explained in a separate guide is invisible when the decision is made.

- The tool description states what it does **and when to call it**, in one or two sentences, in third person.
- Every parameter description is self-contained. Assume no other tool's docs are in context.
- Enumerate accepted values inside the parameter description itself, not in prose elsewhere.
- Say what the tool does **not** do when a sibling tool covers the adjacent case, and name that sibling.
- Describe the return shape well enough that a caller can plan the next call without executing the first.
- Reference tools by fully qualified name — `ServerName:tool_name` — anywhere multiple servers may be loaded.
- State side effects unambiguously: whether the call writes, whether it is idempotent, whether a partial write is possible.

For human-facing docs of the same MCP server, keep a separate page covering installation, transport, authentication, and configuration — none of which belongs in the tool descriptions.

## Schema and data model docs

Document each field with: name, type, required, constraints, and meaning. Include the constraints the code enforces, not merely the type — a `string` that must match a pattern or stay under a length limit is meaningfully different from a `string`.

State nullability, and distinguish "absent" from "null" if the API does.

Version the schema and record what changed between versions. When a field is deprecated, mark it in place with the replacement named; removing it from the docs before removing it from the API leaves readers unable to interpret live data.

Give one complete, valid example document. Readers pattern-match against a whole example faster than they assemble one from field descriptions.

## Review checklist

```
- [ ] Every entry carries the identical section set, in identical order
- [ ] Empty sections say "None." rather than being omitted
- [ ] Parameter tables enumerate closed value sets
- [ ] Units and bounds stated for every numeric parameter
- [ ] Opaque IDs name the call that produces them
- [ ] Error table gives a resolution per code, not a restatement
- [ ] Partial-failure and retry semantics documented for batch operations
- [ ] Exit codes documented (CLI); side effects documented (tools)
- [ ] Every example executed as written, with output shown
- [ ] Agent-facing descriptions self-contained and in third person
- [ ] Deprecated fields marked in place, with replacements named
```
