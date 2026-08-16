# READMEs and Project Docs

## Contents

- What a README is for
- Standard structure
- The first screen
- Installation and configuration
- Usage examples
- What belongs elsewhere
- Contributing guides
- Changelogs
- Review checklist

## What a README is for

A README answers four questions for someone who arrived from a search result and will leave in thirty seconds if unsatisfied:

1. What is this?
2. Do I want it?
3. How do I run it?
4. Where do I go next?

It is not a manual. Every paragraph that does not serve one of those four questions pushes the answers below the fold.

## Standard structure

```
# project-name

<one-sentence description>

<badges — optional, and only informative ones: build, version, license>

## What it does
## Requirements
## Installation
## Quick start
## Configuration
## Documentation  (links out)
## Contributing
## License
```

Reorder only for a reason. Readers scan for these headings by habit, and unfamiliar organization costs them time.

## The first screen

The single most valuable line is the description directly under the title. It must be concrete and complete without context:

> An MCP server exposing TestLink test case management to AI agents over the Model Context Protocol.

Not:

> A powerful, flexible tool for modern test workflows.

Marketing adjectives — powerful, seamless, blazing fast, modern, simple — carry no information and signal that the author had nothing specific to say. Delete them all.

Follow the description with what the project does in three to six bullets, each naming a real capability. Then reach a runnable command as fast as possible. If a reader cannot execute something within the first screen, the README is too slow.

Badge rows exceeding four items become noise. Keep build status, version, and license; drop the rest.

## Installation and configuration

State prerequisites with versions before the install command, so a reader fails fast rather than midway:

```
Requires Python 3.11+, and a TestLink instance with the XML-RPC API enabled.
```

Give one canonical install path. Alternatives (source build, container, package manager variants) go below the canonical one, clearly subordinate. Presenting three equal options forces a decision the reader is not equipped to make.

Document configuration as a table, since readers arrive looking for one specific key:

| Variable | Required | Default | Description |
|---|---|---|---|
| `TESTLINK_URL` | Yes | — | Base URL of the TestLink XML-RPC endpoint |
| `TESTLINK_API_KEY` | Yes | — | Personal API key from user settings |
| `REQUEST_TIMEOUT` | No | `30` | Seconds before an API call aborts |

Never put a real credential in an example, even an expired one.

## Usage examples

Two or three examples, ordered by frequency of use, not by complexity. The first must be the thing almost everyone does.

Each example shows the invocation and its output:

```bash
testcase-validator check --project TestLink-QA --file cases.json
```

```
Validated 47 cases. 2 rejected:
  case_12: field 'importance' = 'critical' (expected: 1, 2, 3)
  case_31: missing required field 'summary'
```

Output is what convinces a reader the tool does what the description claims. An example without output asks for faith.

Stop at three. A fourth example belongs in a docs page linked from here.

## What belongs elsewhere

Move out of the README, leaving a link:

- Full API or CLI reference
- Architecture and internals
- Long troubleshooting catalogs
- Design rationale and history
- Extensive configuration for edge cases

A README over roughly 300 lines has become a manual and has stopped answering the four questions. Split it into `docs/` and link from a short Documentation section.

## Contributing guides

Separate file, `CONTRIBUTING.md`. Cover only what a contributor cannot infer:

- How to set up a development environment, as commands
- How to run tests, as a command
- Code style enforcement — the tool and how to run it, not a prose style essay
- Branch and commit message conventions, with one real example each
- What review looks like and how long it typically takes

Skip the code of conduct summary, the pep talk, and the general git tutorial. Contributors capable of contributing already have those.

## Changelogs

`CHANGELOG.md`, newest first, grouped by release with a date. Within a release, group by *Added / Changed / Deprecated / Removed / Fixed / Security*.

Entries describe user-visible effect, not commits:

- Good: `Fixed test case IDs being reassigned during bulk import.`
- Bad: `Refactored import handler (#412).`

Mark breaking changes unmistakably at the top of the release, with the migration action stated inline.

## Review checklist

```
- [ ] Description under the title is concrete and standalone
- [ ] Zero marketing adjectives
- [ ] Prerequisites with versions appear before install
- [ ] A runnable command appears within the first screen
- [ ] Every command executed as written, from a clean environment
- [ ] Examples show output, not just invocation
- [ ] Configuration documented as a table
- [ ] No credentials, real or expired, in examples
- [ ] Under ~300 lines; deeper material linked out
- [ ] License stated
```
