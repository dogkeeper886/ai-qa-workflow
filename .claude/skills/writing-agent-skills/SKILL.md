---
name: writing-agent-skills
description: Author, review, and refactor Agent Skills — SKILL.md frontmatter, description wording for reliable triggering, progressive disclosure across bundled files, workflow checklists, validator feedback loops, and evaluation-driven iteration. Use whenever the user is writing a new skill, editing or splitting an existing SKILL.md, migrating slash commands or prompts into skills, packaging skills into a plugin, debugging a skill that fails to trigger or triggers too often, or asking how skills should be structured — including when they describe the work as "turn this into a skill" or "make this reusable" without saying the word skill.
---

# Writing Agent Skills

Source of truth: https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices

## Anatomy

```
skill-name/
├── SKILL.md          # required: YAML frontmatter + markdown body
├── reference/        # docs read on demand
│   ├── finance.md
│   └── sales.md
├── scripts/          # executed via bash, contents never loaded
└── assets/           # templates, fonts, icons used in output
```

Three loading levels:

1. **Metadata** (`name` + `description`) — always in the system prompt, for every installed skill.
2. **SKILL.md body** — loaded when the skill triggers. Under 500 lines.
3. **Bundled files** — loaded only when read. Scripts execute without loading; only their stdout costs tokens.

Large reference files and datasets cost nothing until accessed. Verbosity in SKILL.md itself is what competes with conversation history.

## Frontmatter

`name`
- ≤64 characters, lowercase letters / numbers / hyphens only
- No XML tags. No reserved words: `anthropic`, `claude`
- Prefer gerund form: `processing-pdfs`, `validating-test-cases`, `writing-documentation`
- Noun phrases (`pdf-processing`) and action forms (`process-pdfs`) are acceptable — pick one convention and hold it across the collection
- Reject: `helper`, `utils`, `tools`, `documents`, `data`

`description`
- Non-empty, ≤1024 characters, no XML tags
- **Third person.** It is injected into the system prompt; first- or second-person phrasing ("I can help you...", "You can use this to...") degrades discovery
- Must carry two things: what the skill does, and when to trigger it
- This is the only text the model sees when choosing among 100+ skills. All "when to use" information lives here, never in the body

Shape:

```yaml
description: <capabilities, comma-separated>. Use when <file types, user phrasings, task contexts>.
```

Working examples:

```yaml
description: Extract text and tables from PDF files, fill forms, merge documents. Use when working with PDF files or when the user mentions PDFs, forms, or document extraction.
```

```yaml
description: Generate descriptive commit messages by analyzing git diffs. Use when the user asks for help writing commit messages or reviewing staged changes.
```

Failing descriptions: `Helps with documents`, `Processes data`, `Does stuff with files`.

### Countering undertrigger

The dominant failure mode is a skill that never fires, not one that fires too often. Skills are consulted mainly for tasks the model can't trivially handle alone — a one-step request matches a description and still doesn't load the skill. Write descriptions slightly pushy and enumerate oblique triggers:

> ...Use whenever the user mentions dashboards, data visualization, internal metrics, or wants to display any kind of company data, even if they don't explicitly ask for a "dashboard."

## Conciseness

Assume the model already knows the domain. Add only what it cannot have: your schemas, your conventions, your sequences, your constraints.

Interrogate each paragraph:
- Does this explain something already known?
- Does it justify its token cost?

Good (~50 tokens):

````markdown
## Extract PDF text

Use pdfplumber:

```python
import pdfplumber
with pdfplumber.open("file.pdf") as pdf:
    text = pdf.pages[0].extract_text()
```
````

Bad (~150 tokens): the same section prefaced by what a PDF is, that libraries exist, that several libraries exist, and how pip works.

## Degrees of freedom

Match specificity to how fragile the task is. The model is a robot on a path — narrow bridge over cliffs versus open field.

| Freedom | Form | Use when |
|---|---|---|
| High | Prose steps | Multiple valid approaches; context decides |
| Medium | Parameterized template or pseudocode | A preferred pattern exists, variation tolerable |
| Low | Exact command, no parameters | Fragile, order-dependent, consistency critical |

Low-freedom example:

````markdown
## Database migration

Run exactly this:

```bash
python scripts/migrate.py --verify --backup
```

Do not modify the command or add flags.
````

## Progressive disclosure

Treat SKILL.md as a table of contents that routes to detail.

```markdown
# PDF Processing

## Quick start
[minimal working example inline]

## Advanced
**Form filling**: See [FORMS.md](FORMS.md)
**API reference**: See [REFERENCE.md](REFERENCE.md)
**Examples**: See [EXAMPLES.md](EXAMPLES.md)
```

**Keep every reference one level deep from SKILL.md.** Chained references (SKILL.md → advanced.md → details.md) cause partial reads — the model previews with `head -100` instead of reading the file whole, and acts on incomplete information.

Organize multi-domain skills by domain so irrelevant context never loads:

```
bigquery-skill/
├── SKILL.md
└── reference/
    ├── finance.md
    ├── sales.md
    └── product.md
```

Name files by content (`form_validation_rules.md`), not position (`doc2.md`). Add a table of contents to any reference file over ~100 lines so its scope survives a partial read.

## Workflows

For multistep tasks, give an explicit checklist the model copies into its response and ticks off:

````markdown
## PDF form filling workflow

Copy this checklist and check off items as you complete them:

```
Task Progress:
- [ ] Step 1: Analyze the form (run analyze_form.py)
- [ ] Step 2: Create field mapping (edit fields.json)
- [ ] Step 3: Validate mapping (run validate_fields.py)
- [ ] Step 4: Fill the form (run fill_form.py)
- [ ] Step 5: Verify output (run verify_output.py)
```

**Step 1: Analyze the form**
Run: `python scripts/analyze_form.py input.pdf`
...
**Step 5: Verify output**
If verification fails, return to Step 2.
````

Checklists stop the model skipping validation steps. If a workflow grows large, move it to its own file and route to it by task type.

## Feedback loops

Pattern: run validator → fix errors → repeat → gate.

```markdown
1. Make edits to `word/document.xml`
2. **Validate immediately**: `python ooxml/scripts/validate.py unpacked_dir/`
3. If validation fails: read the error, fix the XML, validate again
4. **Only proceed when validation passes**
5. Rebuild: `python ooxml/scripts/pack.py unpacked_dir/ output.docx`
```

The validator need not be code. A STYLE_GUIDE.md plus a comparison checklist is a validator.

Make validator output verbose and actionable — name the failure and enumerate the legal alternatives:

```
Field 'signature_date' not found.
Available fields: customer_name, order_total, signature_date_signed
```

## Conditional routing

```markdown
1. Determine the modification type:
   **Creating new content?** → Creation workflow
   **Editing existing content?** → Editing workflow
```

## Scripts

Pre-written scripts beat generated code: reliable, consistent, and free of context cost since only output is loaded.

**Solve, don't defer.** Handle the error condition in the script rather than failing into the model's lap.

```python
def process_file(path):
    try:
        with open(path) as f:
            return f.read()
    except FileNotFoundError:
        print(f"File {path} not found, creating default")
        with open(path, "w") as f:
            f.write("")
        return ""
```

**No voodoo constants.** If you can't justify the value, the model can't either.

```python
# HTTP requests typically complete within 30 seconds
# Longer timeout accounts for slow connections
REQUEST_TIMEOUT = 30
```

**State execution intent explicitly:**
- Execute: "Run `analyze_form.py` to extract fields"
- Read: "See `analyze_form.py` for the field extraction algorithm"

Document each script's invocation and output shape in SKILL.md.

### Plan–validate–execute

For batch, destructive, or high-stakes operations, insert a machine-checkable intermediate artifact: analyze → **write plan file** → **validate plan** → execute → verify. Errors surface before anything is mutated, and the plan can be iterated without touching originals.

## MCP tool references

Always fully qualify: `ServerName:tool_name`.

```markdown
Use the BigQuery:bigquery_schema tool to retrieve table schemas.
Use the GitHub:create_issue tool to create issues.
```

Bare tool names fail to resolve when multiple servers are loaded.

## Dependencies

Never assume a package is present. State the install, then the usage.

Platform limits: claude.ai can install from npm/PyPI and pull from GitHub; the Claude API code execution environment has no network access and no runtime installation. List required packages in SKILL.md and confirm availability against the code execution tool docs.

## Anti-patterns

- **Windows paths** — `scripts\helper.py` breaks on Unix. Forward slashes always.
- **Option menus** — "use pypdf, or pdfplumber, or PyMuPDF, or..." Give one default plus a named escape hatch: "Use pdfplumber. For scanned PDFs requiring OCR, use pdf2image with pytesseract."
- **Time-sensitive text** — "before August 2025, use the old API" rots. Put current guidance up front and park deprecated material in a collapsed "Old patterns" section.
- **Drifting terminology** — pick one term per concept and never vary it. Not `field` / `box` / `element` / `control`. Not `extract` / `pull` / `get` / `retrieve`.
- **Abstract examples** — concrete input/output pairs convey style far better than descriptions of style.
- **Heavy-handed MUSTs** — explain why a constraint exists. Escalate to imperative language only where observed behavior shows the constraint being dropped.

## Evaluation-driven development

Build evaluations before writing extensive documentation, so the skill closes observed gaps rather than imagined ones.

1. Run the model on representative tasks **without** the skill. Record concrete failures.
2. Build at least three eval scenarios covering those gaps.
3. Establish the no-skill baseline.
4. Write the minimum instructions that pass.
5. Iterate against the baseline.

Eval record:

```json
{
  "skills": ["pdf-processing"],
  "query": "Extract all text from this PDF file and save it to output.txt",
  "files": ["test-files/document.pdf"],
  "expected_behavior": [
    "Reads the PDF using an appropriate library or command-line tool",
    "Extracts text from all pages without missing any",
    "Saves output to output.txt in readable form"
  ]
}
```

No runner ships with this format — supply your own harness.

Write eval queries substantive enough that consulting a skill is actually worthwhile. "Read file X" is a poor test case: it won't trigger any skill regardless of description quality.

## Iteration loop

Two roles: an authoring session that holds the design context, and fresh sessions that use the skill on real tasks. Give the fresh session real work, not test scenarios. Observe, then bring specifics back to the authoring session — "it forgot to filter test accounts on a regional report; the rule is in the skill but maybe not prominent enough."

Diagnostic signals:

| Observation | Likely cause |
|---|---|
| Files read in unexpected order | Structure isn't as intuitive as assumed |
| References not followed | Links insufficiently explicit or prominent |
| Same file read repeatedly | Content belongs in SKILL.md |
| Bundled file never accessed | Unnecessary, or poorly signaled |
| Skill never fires | Description missing trigger terms |

Test against every model the skill will run on. Instructions tuned for a strong model may underspecify for a fast one; instructions tuned for a fast model may over-explain for a strong one.

## Pre-ship checklist

**Core**
- [ ] Description is third person, specific, and names both capability and triggers
- [ ] Description includes oblique phrasings the user might actually type
- [ ] SKILL.md body under 500 lines
- [ ] Overflow detail lives in separate files
- [ ] All file references exactly one level deep
- [ ] Reference files >100 lines carry a table of contents
- [ ] No time-sensitive claims outside an "Old patterns" section
- [ ] Terminology consistent throughout
- [ ] Examples concrete, not abstract
- [ ] Workflows have discrete, ordered steps

**Code**
- [ ] Scripts handle errors rather than deferring
- [ ] Every constant justified in a comment
- [ ] Required packages listed and verified available
- [ ] Execute-vs-read intent stated for each script
- [ ] Forward slashes everywhere
- [ ] Validation gates on destructive or batch operations
- [ ] MCP tools fully qualified as `ServerName:tool_name`

**Testing**
- [ ] At least three evaluations written
- [ ] Baseline measured without the skill
- [ ] Exercised on real tasks, not just synthetic prompts
- [ ] Tested across every target model

## Security

A skill's contents must not surprise a user who has read its description. No malware, exploit code, credential exfiltration, or instructions facilitating unauthorized access.
